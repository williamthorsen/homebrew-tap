class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/refs/tags/v0.8.3.tar.gz"
  sha256 "a78d63417b9b14586750d0389520d812f32c2753f85b45a3d10816fea1a0db27"
  version "0.8.3"

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
