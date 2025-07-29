class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url   "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.10.tar.gz"
  sha256 "<UPDATE_SHA256_FOR_v1.0.10>"
  license "MIT"
  revision 1

  depends_on "python@3.11"

  # === Python deps ===
  resource "pyobjc-core" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc_core/pyobjc_core-11.1.tar.gz"
    sha256 "b63d4d90c5df7e762f34739b39cc55bc63dbcf9fb2fb3f2671e528488c7a87fe"
  end

  resource "pyobjc-framework-Cocoa" do
    url "https://files.pythonhosted.org/packages/source/p/pyobjc_framework_cocoa/pyobjc_framework_cocoa-11.1.tar.gz"
    sha256 "87df76b9b73e7ca699a828ff112564b59251bb9bbe72e610e670a4dc9940d038"
  end

  def install
    # Inject a minimal setup.py if one is not present upstream
    (buildpath/"setup.py").write <<~EOS
      from setuptools import setup

      setup(
          name="menuicon",
          version="1.0.10",
          py_modules=["menuicon"],
          entry_points={
              "console_scripts": ["menuicon=menuicon:main"],
          },
      )
    EOS

    virtualenv_install_with_resources
  end

  test do
    assert_match "Display reversed strings", shell_output("#{bin}/menuicon --help")
  end
end
