# typed: false
# frozen_string_literal: true

# This file was generated by GoReleaser. DO NOT EDIT.
class Ddev < Formula
  desc "DDEV"
  homepage "https://github.com/drud/ddev"
  version "1.19.6-alpha.2"
  license "Apache 2"

  on_macos do
    if Hardware::CPU.arm?
      url "https://github.com/gilbertsoft/ddev/releases/download/v1.19.6-alpha.2/ddev_macos-arm64.v1.19.6-alpha.2.tar.gz"
      sha256 "df0ed0b713001f96b2846c932bf862dd37641101e6a1a93368d99f28a9fe6f87"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
    if Hardware::CPU.intel?
      url "https://github.com/gilbertsoft/ddev/releases/download/v1.19.6-alpha.2/ddev_macos-amd64.v1.19.6-alpha.2.tar.gz"
      sha256 "c722711985db0bdf442276fdc0c187ad49d579d2ef1d7e7df0d742f570b25afd"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
  end

  on_linux do
    if Hardware::CPU.intel?
      url "https://github.com/gilbertsoft/ddev/releases/download/v1.19.6-alpha.2/ddev_linux-amd64.v1.19.6-alpha.2.tar.gz"
      sha256 "42bcb092c1566e25c0a9b07303886b527b0eb5e923bfc13d87b774d1b06b2b88"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
    if Hardware::CPU.arm? && Hardware::CPU.is_64_bit?
      url "https://github.com/gilbertsoft/ddev/releases/download/v1.19.6-alpha.2/ddev_linux-arm64.v1.19.6-alpha.2.tar.gz"
      sha256 "03289ae2984b0ec979d937d2b8e7b033f894781f9f9bb3faf66960ec970ce36c"

      def install
        if build.head?
            os = OS.mac? ? "darwin" : "linux"
            arch = Hardware::CPU.arm? ? "arm64" : "amd64"
            system "mkdir", "-p", "#{bin}"
            system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
            system "cp", ".gotmp/bin/" + os + "_" + arch + "/ddev", "#{bin}/ddev"
        else
            bin.install "ddev"
            bash_completion.install "ddev_bash_completion.sh" => "ddev"
            zsh_completion.install "ddev_zsh_completion.sh" => "ddev"
            fish_completion.install "ddev_fish_completion.sh" => "ddev"
        end
      end
    end
  end

  head "https://github.com/drud/ddev.git", branch: "master"
  depends_on "go" => :build
  depends_on "make" => :build

  depends_on "mkcert"

  test do
    system "#{bin}/ddev --version"
  end
end
