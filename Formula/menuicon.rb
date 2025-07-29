class Menuicon < Formula
  desc "Display reversed strings as individual menu bar icons"
  homepage "https://github.com/Starry0Wolf/menuicon"
  url "https://github.com/Starry0Wolf/menuicon/archive/refs/tags/v1.0.6.tar.gz"
  sha256 "dae66e38ba7cc2eeddfad00d567f08d8c1f829666122e56b86ef9fc475aae19b"
  license "MIT"

  depends_on "python@3.11"

  def install
    # Install your Python script directly as an executable
    bin.install "menuicon.py" => "menuicon"
    chmod 0755, bin/"menuicon"
  end

  test do
    # It should at least print its help/usage text
    assert_match "Display reversed string", shell_output("#{bin}/menuicon --help", 1)
  end
end
