class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/refs/tags/v0.10.0.tar.gz"
  sha256 "3a8ff48477622218df130ddff4715057f38cf5e3ac2de4c1722d1f008743d957"
  version "0.10.0"

  def install
    # Install the configuration file in a shared directory
    (share/"gitconfig.d").install "git/git-recon.gitconfig"

    # Install the executable script
    bin.install "bin/git-recon.sh" => "git-recon"
  end

  def post_install
      # Prompt the user to run the installer
      opoo <<~EOS
        Git-Recon has been installed successfully.

        To enable the Git-Recon aliases, please run the following command:

          git-recon --install

        This will automatically add the necessary `include` directive to your ~/.gitconfig file.
      EOS
    end
end
