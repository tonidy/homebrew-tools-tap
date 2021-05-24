class Mkpasswd < Formula
  desc "mkpasswd tool to make password tool"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.5.9.zip"
  sha256 "b946386e2406991a855b935ad4efca87767bb65df80d5616d08c88a3ec716aaa"
  version "5.5.9"
  license "GPL-2.0-or-later"
  head "https://github.com/tonidy/whois.git", :branch => "master" 

  bottle :unneeded
  keg_only :provided_by_macos

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    on_macos do
      ENV.append "LDFLAGS", "-L/usr/lib -liconv"
      # ENV.append "LDFLAGS", "-L/usr/local/opt/openssl@1.1/lib"
      # ENV.append "CPPFLAGS", "-I/usr/local/opt/openssl@1.1/include"
    end

    have_iconv = "HAVE_ICONV=1"

    on_linux do
      have_iconv = "HAVE_ICONV=0"
    end

    system "make", "mkpasswd", have_iconv
    bin.install "bin/mkpasswd"
    man1.install "man/mkpasswd.1"
  end

  test do
    system "#{bin}/mkpasswd", "test"
  end
end
