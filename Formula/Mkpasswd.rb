class Mkpasswd < Formula
  desc "mkpasswd tool to make password tool"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/tonidy/whois/archive/3be4b59af6d601c3b8f2d2634459fc31b1bf7155.zip"
  sha256 "b946386e2406991a855b935ad4efca87767bb65df80d5616d08c88a3ec716aaa"
  license "GPL-2.0-or-later"
  head "https://github.com/tonidy/whois.git", :branch => "master" 

  keg_only :provided_by_macos

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
    on_macos do
      ENV.append "LDFLAGS", "-L/usr/lib -liconv"
      ENV.append "LDFLAGS", "-L/usr/local/opt/openssl@1.1/lib"
      ENV.append "CPPFLAGS", "-I/usr/local/opt/openssl@1.1/include"
    end

    have_iconv = "HAVE_ICONV=1"

    on_linux do
      have_iconv = "HAVE_ICONV=0"
    end

    system "make", "mkpasswd", have_iconv
    bin.install "mkpasswd"
    man1.install "mkpasswd.1"
  end

  test do
    system "#{bin}/mkpasswd", "test"
  end
end
