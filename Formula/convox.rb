class Convox < Formula
  desc "Command-line interface for the Rack PaaS on AWS"
  homepage "https://convox.com/"
  url "https://github.com/convox/rack/archive/20180425220726.tar.gz"
  sha256 "a0c118d9e93531b00336bf1d87c6cd73e3e51ea8bd0e6993612fbb768f879c7c"

  bottle do
    cellar :any_skip_relocation
    sha256 "59fa9de0f8470537c89fb6ffb68321ed9f97c51bd284750e43014e1b16af4b9b" => :high_sierra
    sha256 "9e1c009ef4a363c4b131b9cd4b303a9d51161e4577181e95c3dc4f7e776ba2e6" => :sierra
    sha256 "f0238ef7300cb35424a8bdedb8431964b99b4b2c71e7e68c7c4021cb6e72f075" => :el_capitan
  end

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/convox/rack").install Dir["*"]
    system "go", "build", "-ldflags=-X main.Version=#{version}",
           "-o", bin/"convox", "-v", "github.com/convox/rack/cmd/convox"
  end

  test do
    system bin/"convox"
  end
end
