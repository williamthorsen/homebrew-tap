class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/refs/tags/v0.8.2.tar.gz"
  sha256 "f4b39c81b7b66b2c5efab55bf70cb7b2402a781554c76a5250bc0dbfd3ffcb98"
  version "0.8.2"

  def install
    (etc/"gitconfig.d").install "git/git-recon.gitconfig"
    bin.install "bin/git-recon.sh" => "git-recon"
  end

  def caveats
    <<~EOS
      ==> Important Caveats

      Git-Recon uses custom aliases, which are defined in a single file, "git-recon.gitconfig".

      To include this file in your ~/.gitconfig, run the following command:

        git-recon --install
    EOS
  end
end
