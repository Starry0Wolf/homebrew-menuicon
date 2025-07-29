class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url   "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.7.tar.gz"
  sha256 "9394676b60b954fdebf6ec5cf5c27ea84d3534aa6651ef2decd95825f5983062"

  depends_on "python@3.11"

  # === Python deps ===
  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/…/pyobjc-core-11.1.tar.gz"
    sha256 "b63d4d90c5df7e762f34739b39cc55bc63dbcf9fb2fb3f2671e528488c7a87fe"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/…/pyobjc-framework-Cocoa-11.1.tar.gz"
    sha256 "87df76b9b73e7ca699a828ff112564b59251bb9bbe72e610e670a4dc9940d038"
  end

  def install
    virtualenv_install_with_resources
  end

  test do
    assert_match "Display reversed strings", shell_output("#{bin}/menuicon --help")
  end
end
