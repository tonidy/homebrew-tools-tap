class Mkpasswd < Formula
  desc "mkpasswd: tool to make a password"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.5.9.zip"
  sha256 "c37d62883f549f28d214aa1aa1f393d335d20589f0353be714d568bd597ec5f2"
  version "5.5.9"
  license "GPL-2.0-or-later"
  head "https://github.com/rfc1036/whois.git", :branch => "master" 

  stable do
    patch do
      url "https://gist.github.com/tonidy/6676834c5434998d5a37200e39a533ed/raw/559e011077db15ac755e08eb971c1e1251653ff9/whois.diff"
      sha256 "e6a173c5c31d0e57edd2576e3b82cb084544af988e4d5861b24eee28c8ffb8fa"
    end
  end

  depends_on "pkg-config" => :build
  depends_on "openssl"

  def install
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
