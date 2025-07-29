class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.4.tar.gz"
  sha256 "3f6c5466ea07d2cb714a33058b347bce7b0e7fc658d6180fd7177d769fa01355"
  license "MIT"

  depends_on "python@3.11"

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc-core/pyobjc-core-11.1.tar.gz"
    sha256 "2dbf5b0e1e95a70d57b4fbc1aa60f0c7f8c5ad5b78314fbdc5f2d4a1c8b6e342"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc-framework-Cocoa/pyobjc-framework-Cocoa-11.1.tar.gz"
    sha256 "7a3d9f5e8c6cfae2b5f8810e3f507dbff5a9c663b593a8f8e6a2a4f9d23e1c8c"
  end

  def install
    # create a virtualenv and install PyObjC into it
    virtualenv_install_with_resources

    # link your script into bin/
    bin.install_symlink libexec/"bin/menuicon"
  end

  test do
    # make sure the wrapper is there and prints help text
    assert_match "Display reversed string", shell_output("#{bin}/menuicon --help")
  end
end
