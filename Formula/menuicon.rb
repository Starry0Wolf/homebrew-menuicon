class Menuicon < Formula
  desc "Display multiple icons/letters in macOS menu bar using Python"
  homepage "https://github.com/starry/menuicon"
  url "https://github.com/starry/menuicon/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "0019dfc4b32d63c1392aa264aed2253c1e0c2fb09216f8e2cc269bbfb8bb49b5"
  license "MIT"
  version "1.0.1"

  depends_on "python@3.11"

  def install
    bin.install "menuicon"
    pkgshare.install "menuicon.py"
  end
end