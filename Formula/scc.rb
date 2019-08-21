class Scc < Formula
  desc "Fast and accurate code counter with complexity and COCOMO estimates"
  homepage "https://github.com/boyter/scc/"
  url "https://github.com/boyter/scc/archive/v2.7.0.tar.gz"
  sha256 "16238df60bef3f2a758e0516c9bec3ed24e2dcb29386ad2c183eef44d7f1db67"

  depends_on "go" => :build

  def install
    ENV["GOPATH"] = buildpath
    (buildpath/"src/github.com/boyter/scc/").install Dir["*"]
    system "go", "build", "-o", "#{bin}/scc", "-v", "github.com/boyter/scc/"
  end

  test do
    assert_match version.to_s, shell_output("#{bin}/scc --version", 0)
  end
end
