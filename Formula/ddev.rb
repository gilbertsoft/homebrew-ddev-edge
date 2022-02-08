class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/"
  url "https://github.com/drud/ddev/archive/v1.19.0-alpha4.tar.gz"
  sha256 "fa6e2b288ee358ea1ccf661b21113913eb6f217434964e31f1fe5c1eefc6abcc"
  license "apache-2.0"
  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.19.0-alpha4/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e0712e1fe39920ffdd3d0a3e49ef7c46a148e3035c8212bcb988238b349122e7"
    sha256 cellar: :any_skip_relocation, high_sierra: "422f32d2fdadcdd26633370c6b11f2ebfb66f2e18fe038649c131a1fced080d5"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ebae095c85065d0b566fdd94f6303b9598f79c2cab6af374a189c59a28165384"
  end
  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
        if Hardware::CPU.arm?
            system "cp", ".gotmp/bin/darwin_arm64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_arm64/ddev_gen_autocomplete"
        else
            system "cp", ".gotmp/bin/darwin_amd64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_amd64/ddev_gen_autocomplete"
        end
    end
    if OS.linux?
      system "cp", ".gotmp/bin/linux_amd64/ddev", "#{bin}/ddev"
      system ".gotmp/bin/linux_amd64/ddev_gen_autocomplete"
    end
    bash_completion.install ".gotmp/bin/ddev_bash_completion.sh" => "ddev"
    zsh_completion.install ".gotmp/bin/ddev_zsh_completion.sh" => "ddev"
    fish_completion.install ".gotmp/bin/ddev_fish_completion.sh" => "ddev"
  end

  def caveats
    <<~EOS
            Make sure to do a 'mkcert -install' if you haven't done it before, it may require your sudo password.
      #{"      "}
            ddev requires docker or colima.
            See https://ddev.readthedocs.io/en/latest/users/docker_installation/
    EOS
  end

  test do
    system "#{bin}/ddev", "--version"
  end
end
