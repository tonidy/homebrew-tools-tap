class Mkpasswd < Formula
  desc "Generate hashed passwords (mkpasswd from whois package)"
  homepage "https://github.com/rfc1036/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.6.6.tar.gz"
  sha256 "43d3b3cc64c75e8bd10aee6feff3906e9488ed335076d206e70f3b25bf644969"
  license "GPL-2.0-or-later"
  revision 23

  depends_on "openssl@3"

  def install
    # Add missing headers at the very beginning of mkpasswd.c
    inreplace "mkpasswd.c", /\A/, "#include <stdio.h>\n#include <string.h>\n\n"

    # Add string.h at the beginning of utils.c
    inreplace "utils.c", /\A/, "#include <string.h>\n\n"

    # Generate version.h if missing (required for mkpasswd.c)
    File.write("version.h", "#define VERSION \"#{version}\"\n") unless File.exist?("version.h")

    # Patch Makefile for pkg-config libcrypto
    inreplace "Makefile", /^else$/, <<~EOS
      else ifeq ($(shell $(PKG_CONFIG) --exists 'libcrypto' || echo NO),)
        mkpasswd_LDADD += $(shell $(PKG_CONFIG) --libs libcrypto)
      else
    EOS

    ENV.append "LDFLAGS", "-L/usr/lib -liconv" if OS.mac?
    ENV.append "LDFLAGS", "-lcrypt" if OS.linux?

    have_iconv = OS.mac? ? "HAVE_ICONV=1" : "HAVE_ICONV=0"

    ENV["PKG_CONFIG_PATH"] = Formula["openssl@3"].opt_lib/"pkgconfig" if OS.linux?

    system "make", "mkpasswd", have_iconv
    bin.install "mkpasswd"
    man1.install "mkpasswd.1"
  end

  test do
    output = shell_output("#{bin}/mkpasswd password")
    assert_match(/\$/, output)
  end
end
