class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.3.tar.gz"
  sha256 "d5558cd419c8d46bdc958064cb97f963d1ea793866414c025906ec15033512ed"
  license "MIT"

  depends_on "python@3.11"

  resource "pyobjc" do
    url "https://files.pythonhosted.org/packages/9f/99/4f18364a0b7c44e1bdb43be395ac3077a4e9aa360b151d012be7391e0e3a/pyobjc-10.2.tar.gz"
    sha256 "ef71a4cbf4853a4723b9ae61deef8693e7656b64c9f78fe7cb5eab21f77e7d58"
  end

  def install
    virtualenv_install_with_resources
    bin.install_symlink libexec/"bin/menuicon"
  end

  test do
    # Might fail headless, but we can at least check the file exists
    assert_predicate bin/"menuicon", :exist?
  end
end
