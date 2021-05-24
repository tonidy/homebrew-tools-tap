class Mkpasswd < Formula
  desc "mkpasswd: tool to make a password"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.5.9.zip"
  sha256 "c37d62883f549f28d214aa1aa1f393d335d20589f0353be714d568bd597ec5f2"
  version "5.5.9"
  license "GPL-2.0-or-later"
  head "https://github.com/rfc1036/whois.git", :branch => "master" 

  bottle :unneeded

  stable do
    patch do
      url "https://gist.github.com/tonidy/6676834c5434998d5a37200e39a533ed/raw/f80a6e596c503e33efd48cbd92d5f07768a2d1f3/whois.diff"
      sha256 "a9175e6d367f25890ee3bce65b972d2b42524204e0423902d72e8eb92e87ed99"
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

  test do
    system "#{bin}/mkpasswd", "test"
  end
end
