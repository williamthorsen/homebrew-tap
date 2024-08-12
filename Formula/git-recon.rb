class GitRecon < Formula
  desc "Git-Recon custom Git configuration"
  homepage "https://github.com/williamthorsen/git-recon"
  url "https://github.com/williamthorsen/git-recon/archive/v0.7.1.tar.gz"
  sha256 "2a0121f47439973b4f7bb72b70036fa43d01530c7ec2717939abcc950b2834c8"
  version "0.7.1"

  def install
    (etc/"gitconfig.d").install "git/git-recon.gitconfig"
  end

  def caveats
    <<~EOS
      To use this configuration, add the following line to your ~/.gitconfig:

      [include]
        path = #{etc}/gitconfig.d/git-recon.gitconfig
    EOS
  end
end
