class Pa < Formula
  desc "A simple CLI password manager"
  homepage "https://github.com/tonidy/pa-cli"
  url "https://github.com/tonidy/pa-cli/archive/refs/tags/v1.2.1.tar.gz"
  sha256 "0de7f86431134a7e357f3d03580dd1a8ea9125fd2636c045c11a690c879cd3e3"
  license "AGPL-3.0"
  revision 2

  depends_on "age"
  depends_on "fzf"

  def install
    # Replace version placeholders (similar to Makefile install target)
    inreplace "pa" do |s|
      s.gsub!('PA_VERSION="__VERSION__"', "PA_VERSION=\"v1.2.1\"")
      s.gsub!('PA_RELEASE_DATE="__RELEASE_DATE__"', "PA_RELEASE_DATE=\"Oct 24 2025\"")
      s.gsub!('PA_COMMIT="__COMMIT__"', "PA_COMMIT=\"c6d63ee\"")
    end

    bin.install "pa"
  end

  test do
    assert_match(/pa version: v1.2.1/, `#{bin}/pa --version 2>&1`)
  end
end
