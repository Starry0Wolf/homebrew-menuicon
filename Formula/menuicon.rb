class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.5.tar.gz"
  sha256 "e1607945f18c361c962bda8f4f6c32033dc3e68a0a40f4d6ce3582d8238c5052"
  license "MIT"

  depends_on "python@3.11"

  def install
    # 1) create a virtualenv using Homebrew Python
    venv = virtualenv_create(libexec, Formula["python@3.11"].opt_bin/"python3")

    # 2) let pip fetch the latest PyObjC wheels
    venv.pip_install "pyobjc"

    # 3) install your script into libexec
    libexec.install "menuicon.py"

    # 4) write a tiny wrapper into bin/
    (bin/"menuicon").write <<~EOS
      #!/usr/bin/env bash
      exec "#{libexec}/bin/python" "#{libexec}/menuicon.py" "$@"
    EOS
    chmod 0755, bin/"menuicon"
  end

  test do
    output = shell_output("#{bin}/menuicon --help", 1)
    assert_match "Display reversed string", output
  end
end
