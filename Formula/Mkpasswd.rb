class Mkpasswd < Formula
  desc "mkpasswd tool to make password tool"
  homepage "https://packages.debian.org/sid/whois"
  url "https://github.com/rfc1036/whois/archive/refs/tags/v5.5.9.tar.gz"
  sha256 "32de280893ca1fa93a6d4e952f04a4e66bcd62f5bddf631f207b217285efdea0"
  license "GPL-2.0-or-later"
  #head "https://github.com/tonidy/whois.git", :branch => "master" 

  # bottle do
  #   sha256 cellar: :any, arm64_big_sur: "131eca7a6a0466f410a0ad4f00e54de60fd5dfd2eca4f94ebfdbbe7dd28c65b5"
  #   sha256 cellar: :any, big_sur:       "9ced0ec07b88b9915a574e2f5e31b66f76e8ddd0d7b678452cef175ef2e5cb14"
  #   sha256 cellar: :any, catalina:      "961d72a35be229f81b4202f171054cb234b15ece9df017b125b0bd8798a5f4ca"
  #   sha256 cellar: :any, mojave:        "7b8d36fae69c3c4ec0d77bd7f713ff0a587101053f2de8f5e155a7f040e5eaba"
  # end

  keg_only :provided_by_macos

  depends_on "pkg-config" => :build
  # depends_on "libidn2"
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

    # system "make", "whois", have_iconv
    # bin.install "whois"
    # man1.install "whois.1"
    # man5.install "whois.conf.5"

    system "make", "mkpasswd", have_iconv
    bin.install "mkpasswd"
    man1.install "mkpasswd.1"
  end

  test do
    # system "#{bin}/whois", "brew.sh"
    system "#{bin}/mkpasswd", "test"
  end
end
