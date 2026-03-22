class Mkpasswd < Formula
  desc "mkpasswd: tool to make a password"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.6.6.zip"
  sha256 "3418aa374858199e14a229b89547bc1aca6412ebf18bc3be11cb9d7268bf562a"
  version "5.6.6_8"
  license "GPL-2.0-or-later"
  head "https://github.com/rfc1036/whois.git", :branch => "master" 

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    # Read source files
    mkpasswd_content = File.read("mkpasswd.c")
    utils_content = File.read("utils.c")

    puts "mkpasswd.c first 5 lines: #{mkpasswd_content.lines.first(5).join}"
    puts "utils.c first 5 lines: #{utils_content.lines.first(5).join}"

    # Fix mkpasswd.c - add includes at the very beginning
    unless mkpasswd_content.include?('#include <stdio.h>')
      mkpasswd_content = '#include <stdio.h>
#include <string.h>
' + mkpasswd_content
      File.write("mkpasswd.c", mkpasswd_content)
      puts "Wrote mkpasswd.c with includes"
    else
      puts "mkpasswd.c already has includes, skipping"
    end

    # Fix utils.c - add includes at the very beginning
    unless utils_content.include?('#include <string.h>')
      utils_content = '#include <string.h>
' + utils_content
      File.write("utils.c", utils_content)
      puts "Wrote utils.c with includes"
    else
      puts "utils.c already has includes, skipping"
    end

    # Add pkg-config support for libcrypto in Makefile
    inreplace "Makefile", /^else$/, "else ifeq ($(shell $(PKG_CONFIG) --exists 'libcrypto' || echo NO),)\n  mkpasswd_LDADD += $(shell $(PKG_CONFIG) --libs libcrypto)\nelse"

    on_macos do
      ENV.append "LDFLAGS", "-L/usr/lib -liconv"
    end

    have_iconv = "HAVE_ICONV=1"

    on_linux do
      have_iconv = "HAVE_ICONV=0"
    end

    system "make", "mkpasswd", have_iconv
    bin.install "mkpasswd"
    man1.install "mkpasswd.1"
  end

  def caveats; <<~EOS
    Debian mkpasswd has been installed as `mkpasswd` and may shadow the
    system binary of the same name.
  EOS
  end

  test do
    system "#{bin}/mkpasswd", "test"
  end
end
