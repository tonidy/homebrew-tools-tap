class Pa < Formula
  desc "A simple CLI password manager"
  homepage "https://github.com/tonidy/pa-cli"
  url "https://github.com/tonidy/pa-cli/archive/refs/tags/v1.2.2.tar.gz"
  sha256 "b13da6e1db3844087f38adfe6870b8392df1c19cc67b8e59ddd9b4163c8b2674"
  license "AGPL-3.0"
  revision 1

  depends_on "age"
  depends_on "fzf"

  def install
    # Replace version placeholders (similar to Makefile install target)
    inreplace "pa" do |s|
      s.gsub!('PA_VERSION="__VERSION__"', "PA_VERSION=\"v1.2.2\"")
      s.gsub!('PA_RELEASE_DATE="__RELEASE_DATE__"', "PA_RELEASE_DATE=\"Mar 22 2026\"")
      s.gsub!('PA_COMMIT="__COMMIT__"', "PA_COMMIT=\"889d604\"")
    end

    bin.install "pa"
  end

  test do
    assert_match(/pa version: v1.2.2/, `#{bin}/pa --version 2>&1`)
  end
end
