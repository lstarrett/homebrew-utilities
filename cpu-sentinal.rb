class CpuSentinal < Formula
  desc "CPU Sentinal CLI"
  homepage "https://github.com/lstarrett/cpu-sentinal"
  url "https://github.com/lstarrett/cpu-sentinal/archive/0.1.tar.gz"
  sha256 "c81aeb0c0ecf39208c3cf1c8a1eb4be90430b099423193c29577acf8299e4e12"
  license "MIT"
  version "0.1"

  def install
    # Move everything under #{libexec}/
    libexec.install Dir["*"]

    # Then write executables under #{bin}/
    bin.write_exec_script (libexec/"cpu-sentinal.sh")
  end

  test do
    system "true"
  end
end
