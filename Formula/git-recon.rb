class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://api.github.com/repos/williamthorsen/git-recon/tarball/v0.7.3"
  sha256 "a262de5376699bb99c6bc3cfc488e203d5e7ef01ef3aa6134b4b7937bd017498"

  def install
    (etc/"gitconfig.d").install "git/git-recon.gitconfig"
    bin.install "bin/git-recon.sh" => "git-recon"
  end

  def caveats
    <<~EOS
      Git-Recon uses custom aliases, which are defined in a "git-recon.gitconfig" file.
      To include this file in your ~/.gitconfig, run the following command:
        git-recon --install
    EOS
  end
end
