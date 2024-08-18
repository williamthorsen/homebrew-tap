/**
 * Safely removes a temporary directory.
 */
export async function removeTempDir(tempDir: string): Promise<void> {
  if (tempDir.startsWith('/tmp/') || tempDir.startsWith('/var/folders/')) {
    await Deno.remove(tempDir, { recursive: true });
  } else {
    console.warn(`Warning: Skipping cleanup of unexpected temporary directory ${tempDir}`);
  }
}
