class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/refs/tags/v0.8.1.tar.gz"
  sha256 "a45d30f4767e74cc8c8c3634e7e2f4b6a81a5cdb4e455e8dbb2fbb5597459311"
  version "0.8.1"

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
