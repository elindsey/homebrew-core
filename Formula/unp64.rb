class Unp64 < Formula
  desc "Generic C64 prg unpacker,"
  homepage "http://iancoog.altervista.org/"
  url "http://iancoog.altervista.org/C/unp64_235.7z"
  version "2.35"
  sha256 "32f8606ecafed66180d434853a5e7992d82426d9e1fceb81bec467e1ea6c6921"
  revision 1

  bottle do
    cellar :any_skip_relocation
    sha256 "d557f1d75c5b5b1f68c0e088b88a55bd20d7a71110a7090570549602f81374e5" => :high_sierra
    sha256 "7287c0bb661bf779b8fd564f372e09a020d2f9d41c39374e83b877aada641ab0" => :sierra
    sha256 "3069407419e7b348c90f2001fb54671f2b145ed09c7a77eb4cf6a0599fb491ac" => :el_capitan
  end

  def install
    cd Dir["unp64_*/src"].first do
      system "make", "unp64"
      bin.install "Release/unp64"
    end
  end

  test do
    code = [0x00, 0xc0, 0x4c, 0xe2, 0xfc]
    File.open(testpath/"a.prg", "wb") do |output|
      output.write [code.join].pack("H*")
    end

    output = shell_output("#{bin}/unp64 -i a.prg 2>&1")
    assert_match "a.prg :  (Unknown)", output
  end
end
