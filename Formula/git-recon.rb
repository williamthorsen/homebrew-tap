class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/v0.7.1.tar.gz"
  sha256 "2a0121f47439973b4f7bb72b70036fa43d01530c7ec2717939abcc950b2834c8"

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
