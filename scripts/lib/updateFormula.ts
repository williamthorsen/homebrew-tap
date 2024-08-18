interface UpdateFormulaArgs {
  formulaPath: string;
  latestVersion: string;
  sha256: string;
  tarballUrl: string;
}

/**
 * Reads the current formula from `formulaPath`, updates its tarball URL, sha256 hash, and version, and writes
 * the new formula to the same path.
 */
export async function updateFormula({
  formulaPath,
  tarballUrl,
  sha256,
  latestVersion,
}: UpdateFormulaArgs) {
  const formulaContent = await readFormulaContent(formulaPath);
  const updatedContent = generateUpdatedContent(
    formulaContent,
    tarballUrl,
    sha256,
    latestVersion,
  );
  await writeFormulaContent(formulaPath, updatedContent);
}

/**
 * Replaces the sha256 hash, tarball URL, and version number in the formula content with the new values
 * and returns the result.
 */
function generateUpdatedContent(
  formulaContent: string,
  tarballUrl: string,
  sha256: string,
  latestVersion: string,
): string {
  let updatedContent = formulaContent;

  updatedContent = updatedContent.replace(
    /^(\s{2})url\s+".*"/m,
    `$1url "${tarballUrl}"`,
  );

  updatedContent = updatedContent.replace(
    /^(\s{2})sha256\s+".*"/m,
    `$1sha256 "${sha256}"`,
  );

  updatedContent = updatedContent.replace(
    /^(\s{2})version\s+".*"/m,
    `$1version "${latestVersion}"`,
  );

  return updatedContent;
}

// Function to read the formula content
async function readFormulaContent(filePath: string): Promise<string> {
  return await Deno.readTextFile(filePath);
}

// Function to write the updated content to the formula file
async function writeFormulaContent(
  filePath: string,
  content: string,
): Promise<void> {
  await Deno.writeTextFile(filePath, content);
}
