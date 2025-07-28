class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "cd92f6085a3c78799617bd7bfe8ba286efc3fecc1029a02ab17a789cc71d3a61"
  license "MIT"

  depends_on "python@3.11"

  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/34/fc/88fd1eab9b2b1bd2042d745f0aa0e4174218c657315e8b56a6c3c3d8bfc7/pyobjc-core-10.2.tar.gz"
    sha256 "fb1630389de947fdb21c2dc391d5f8bdff0108db911a4b6c65f8adfd2d7ab79e"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/bf/c2/e9e30de8ef96d8c173fcd0a733c2fcd1fe7b0fef50a53627be54d60dbf9b/pyobjc-framework-Cocoa-10.2.tar.gz"
    sha256 "fe5427b13d6b85bfc9edc8f3f8f79f001456e74e5d37640b9ae5d03d7a682ed0"
  end

  def install
    virtualenv_install_with_resources
    bin.install_symlink libexec/"bin/menuicon"
  end

  test do
    assert_predicate bin/"menuicon", :exist?
  end
end
