class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-alpha2.tar.gz"
  sha256 "2df732b1d69bfc952ec2d7f68bd12f5445232a8570af8977b2d1d2ba7e602ae9"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-alpha2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "2c19952aa432a4f06097f339a0dd4d5f26fbde8c7baeeaabdd540cc2edcc28d9"
    sha256 cellar: :any_skip_relocation, high_sierra: "2b606a8748ba69ff2083588f89b80c77a200c9876817f4c9b13d989aadbf88d0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "71a28bf8dad9005017f6d0ae6efe69163bf89d37b7e32f3af95434cfc6b53008"
  end
  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
      system "cp", ".gotmp/bin/darwin_amd64/ddev", "#{bin}/ddev"
      system ".gotmp/bin/darwin_amd64/ddev_gen_autocomplete"
    else
      system "cp", ".gotmp/bin/ddev", "#{bin}/ddev"
      system ".gotmp/bin/ddev_gen_autocomplete"
    end
    bash_completion.install ".gotmp/bin/ddev_bash_completion.sh" => "ddev"
    zsh_completion.install ".gotmp/bin/ddev_zsh_completion.sh" => "ddev"
    fish_completion.install ".gotmp/bin/ddev_fish_completion.sh" => "ddev"
  end

  def caveats
    <<~EOS
            Make sure to do a 'mkcert -install' if you haven't done it before, it may require your sudo password.
      #{"      "}
            ddev requires docker and docker-compose.
            Docker installation instructions at https://ddev.readthedocs.io/en/stable/users/docker_installation/
    EOS
  end

  test do
    system "#{bin}/ddev", "--version"
  end
end
