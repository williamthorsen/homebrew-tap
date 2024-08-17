class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/refs/tags/v0.8.0.tar.gz"
  sha256 "5c2169b69ddf2735d84be8c6ef4d4cf4b8290382b00efc67ddb0f66a2e2e6677"
  version "0.8.0"

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
