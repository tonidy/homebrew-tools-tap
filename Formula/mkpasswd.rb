class Mkpasswd < Formula
  desc "Generate hashed passwords (mkpasswd from whois package)"
  homepage "https://github.com/rfc1036/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.6.6.tar.gz"
  sha256 "43d3b3cc64c75e8bd10aee6feff3906e9488ed335076d206e70f3b25bf644969"
  version "5.6.6_12"
  license "GPL-2.0-or-later"

  depends_on "openssl@3"

  def install
    openssl = Formula["openssl@3"]

    ENV.append "CPPFLAGS", "-I#{openssl.opt_include}"
    ENV.append "LDFLAGS", "-L#{openssl.opt_lib}"

    have_iconv = OS.mac? ? "HAVE_ICONV=1" : "HAVE_ICONV=0"

    system "make", "mkpasswd", have_iconv

    bin.install "mkpasswd"
    man1.install "mkpasswd.1"
  end

  test do
    output = shell_output("#{bin}/mkpasswd password")
    assert_match(/\$/, output)
  end
end