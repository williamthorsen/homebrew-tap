// Import necessary modules from Deno
import { join } from 'https://deno.land/std@0.190.0/path/mod.ts';

// Change directory to the root of the repository
const repoRootProcess = new Deno.Command('git', {
  args: ['rev-parse', '--show-toplevel'],
}).output();

const repoRoot = await repoRootProcess;
const repoPath = new TextDecoder().decode(repoRoot.stdout).trim();
Deno.chdir(repoPath);

// Safely clean up the temporary directory after the tests
async function cleanupTempDir(tempDir: string) {
  if (tempDir.startsWith('/tmp/') || tempDir.startsWith('/var/folders/')) {
    await Deno.remove(tempDir, { recursive: true });
  } else {
    console.warn(`Warning: Skipping cleanup of unexpected temporary directory ${tempDir}`);
  }
}

// Variables
const REPO = 'williamthorsen/git-recon';
const FORMULA_PATH = join(repoPath, 'Formula/git-recon.rb');
const API_URL = `https://api.github.com/repos/${REPO}/releases/latest`;

// Fetch release data from GitHub API
const response = await fetch(API_URL);
const releaseData = await response.json();
const latestVersion = releaseData.tag_name.replace(/^v/, ''); // Remove 'v' prefix if exists
const tarballUrl = `https://github.com/${REPO}/archive/refs/tags/v${latestVersion}.tar.gz`;

// Create a temporary directory for the download
const tempDir = await Deno.makeTempDir();
const tarballFile = join(tempDir, `${latestVersion}.tar.gz`);

// Download the tarball
const tarballResponse = await fetch(tarballUrl);
const tarballArrayBuffer = await tarballResponse.arrayBuffer();
await Deno.writeFile(tarballFile, new Uint8Array(tarballArrayBuffer));

// Compute the SHA256 checksum
const sha256Process = new Deno.Command('shasum', {
  args: ['-a', '256', tarballFile],
}).output();

const sha256Output = await sha256Process;
const sha256 = new TextDecoder().decode(sha256Output.stdout).split(' ')[0];

// Function to update the formula file
async function updateFormula() {
  let formulaContent = await Deno.readTextFile(FORMULA_PATH);

  formulaContent = formulaContent.replace(
    /^(\s{2})url\s+".*"/m,
    `$1url "${tarballUrl}"`,
  );

  formulaContent = formulaContent.replace(
    /^(\s{2})sha256\s+".*"/m,
    `$1sha256 "${sha256}"`,
  );

  formulaContent = formulaContent.replace(
    /^(\s{2})version\s+".*"/m,
    `$1version "${latestVersion}"`,
  );

  await Deno.writeTextFile(FORMULA_PATH, formulaContent);
}

// Update the formula
await updateFormula();

// Cleanup the temporary directory
await cleanupTempDir(tempDir);

console.log(
  `Formula updated with version: ${latestVersion}, URL: ${tarballUrl}, and SHA256: ${sha256}`,
);
