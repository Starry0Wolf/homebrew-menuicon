class Menuicon < Formula
  include Language::Python::Virtualenv

  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.2.tar.gz"
  sha256 "f427e82b57cd71ff3ed4c37be223123ba7da7e6ff5487af2bef5ae9f6d75061c"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Install the python script into libexec
    libexec.install "menuicon.py"

    # Create a wrapper script in bin/
    (bin/"menuicon").write <<~EOS
      #!/bin/bash
      exec "#{Formula["python@3.11"].opt_bin}/python3.11" "#{libexec}/menuicon.py" "$@"
    EOS

    # Make it executable
    chmod 0755, bin/"menuicon"
  end

  test do
    # Basic check: does the help text work
    assert_match "Display reversed string", shell_output("#{bin}/menuicon -h")
  end
end
