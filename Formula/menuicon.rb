class Menuicon < Formula
  desc "Display multiple icons/letters in macOS menu bar using Python"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.1.tar.gz"
  sha256 "5e8366fe7a27b0bb60a05f940892cd1846b87ed9bd4d0be6f57d0c9f5f9cc5c9"
  license "MIT"
  version "1.0.1"

  depends_on "python@3.11"

  def install
    bin.install "menuicon"
    pkgshare.install "menuicon.py"
  end
end