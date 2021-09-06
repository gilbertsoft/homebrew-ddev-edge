class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-rc2.tar.gz"
  sha256 "e201047c060b1e88192fa1dad654ec594fcade8f739b1ffb2b6642231cd85062"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-rc2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9af0d39b785c6165d46b38f0490bc3b408a40193d3b94d46bdb90c0e5c160586"
    sha256 cellar: :any_skip_relocation, high_sierra: "3c96909c3a9cea5bb510af55001fcf51ca4e6c88c22981b0014d85fa6d5ebcae"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "33ebe82072c3dd4eecdc90228ff5e88ba11ce8bade019fc182d88816b29b4ca8"
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
