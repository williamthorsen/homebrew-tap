# Homebrew formula for Git-Recon

Homebrew formula to allow easy installation and use of Git-Recon.

## Installation

To install the `recon.gitconfig` file using Homebrew, follow these steps:

1. **Tap the repository**:

   Add this repository to Homebrew:
   ```bash
   brew tap williamthorsen/git-recon
   ```

2. **Install the formula**:

   Install the formula:
   ```bash
   brew install git-recon
   ```

3. **Include the configuration in your global Git config:**

After installation, add the following lines to your `~/.gitconfig` file to include the custom configuration:

  ```ini
  [include]
    path = $(brew --prefix)/etc/gitconfig.d/git-recon.gitconfig
  ```
