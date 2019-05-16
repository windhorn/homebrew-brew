require "formula"

HOMEBREW_UNIQ2_VERSION="1.0.0"

class Uniq2 < Formula
  desc "Eliminating duplicated lines"
  homepage "https://github.com/tamada/uniq2"
  url "https://github.com/tamada/uniq2.git", :tag => "v#{HOMEBREW_UNIQ2_VERSION}"
  version HOMEBREW_UNIQ2_VERSION
  head "https://github.com/tamada/uniq2.git", :branch => "master"

  depends_on "go"  => :build
  depends_on "dep" => :build

  def install
    ENV['GOPATH'] = buildpath
    uniq2_path = buildpath/"src/github.com/tamada/uniq2/"
    uniq2_path.install buildpath.children

    cd uniq2_path do
      system "dep", "ensure", "-vendor-only"
      system "make", "build"
      bin.install "cmd/uniq2/uniq2"
    end

    test do
      system "make test"
    end
  end
end
