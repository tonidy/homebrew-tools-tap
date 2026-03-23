class GenSecp < Formula
  desc "Generate secp256k1 keypair CLI"
  homepage "https://github.com/tonidy/gen-secp"
  url "https://files.pythonhosted.org/packages/43/3f/5157304d35c1813ba9b137e81680a3cd71f706954f50243a0d732d2e78a4/gen_secp-0.1.6.tar.gz"
  sha256 "7fc802ab4f721ea9308fba8a1ee3928a0f8c99a8f3f484cca4caf833210a1890"
  license "MIT"
  revision 3

  depends_on "python@3.13"

  def install
    python = Formula["python@3.13"].opt_libexec/"bin/python"
    system python, "-m", "pip", "install", "--prefix=#{prefix}", "."
    cp "pyproject.toml", python_site_packages/"pyproject.toml"
  end

  def python_site_packages
    lib/"python3.13/site-packages"
  end

  test do
    assert_match(/genkey/, `#{bin}/genkey --help 2>&1`)
    assert_path_exists(python_site_packages/"pyproject.toml")
    assert_match(/0\.1\.6/, `#{bin}/genkey --version 2>&1`)
  end
end
