class GenSecp < Formula
  desc "Generate secp256k1 keypair CLI"
  homepage "https://github.com/tonidy/gen-secp"
  url "https://files.pythonhosted.org/packages/43/3f/5157304d35c1813ba9b137e81680a3cd71f706954f50243a0d732d2e78a4/gen_secp-0.1.6.tar.gz"
  sha256 "e44e3e1c106533613ef0503970ed42e8"
  license "MIT"
  version "0.1.6"

  depends_on "python@3.13"

  def install
    python = Formula["python@3.13"].opt_libexec/"bin/python"
    system python, "-m", "pip", "install", "--prefix=#{prefix}", "."
  end

  test do
    assert_match(/genkey/, `#{bin}/genkey --help 2>&1`)
  end
end
