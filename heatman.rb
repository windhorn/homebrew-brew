require "formula"

HOMEBREW_HEATMAN_VERSION="1.0.0"

class Heatman < Formula
  desc "Creating heat map from given csv file."
  homepage "https://github.com/tamada/goheatman"
  url "https://github.com/tamada/goheatman.git", :tag => "v#{HOMEBREW_HEATMAN_VERSION}"
  version HOMEBREW_HEATMAN_VERSION
  head "https://github.com/tamada/goheatman.git", :branch => "master"

  depends_on "go"  => :build

  def install
    ENV['GOPATH'] = buildpath
    ENV['GO111MODULE'] = 'on'
    uniq2_path = buildpath/"src/github.com/tamada/goheatman/"
    uniq2_path.install buildpath.children

    cd uniq2_path do
      system "make", "build"
      bin.install "cmd/heatman/heatman"
    end

    test do
      system "make test"
    end
  end
end
