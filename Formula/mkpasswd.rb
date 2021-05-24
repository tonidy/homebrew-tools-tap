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
      url "https://gist.github.com/tonidy/6676834c5434998d5a37200e39a533ed/raw/5a04e2988f95fce473e157e2f1ad5206fedac472/whois.diff"
      sha256 "9303199b3b5b8c2de18aecc20a2cd7fce68b87e75b1b2c8de6d767b887c07da8"
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
