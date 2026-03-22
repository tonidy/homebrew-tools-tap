class Pa < Formula
  desc "A simple CLI password manager"
  homepage "https://github.com/tonidy/pa-cli"
  url "https://github.com/tonidy/pa-cli/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "0de7f86431134a7e357f3d03580dd1a8ea9125fd2636c045c11a690c879cd3e3"
  license "AGPL-3.0-or-later"
  revision 1

  depends_on "age"
  depends_on "fzf"

  def install
    bin.install "pa"
  end

  test do
    assert_match(/^pa$/, `#{bin}/pa 2>&1 || true`)
  end
end
