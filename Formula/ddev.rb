class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-alpha1.tar.gz"
  sha256 "3fddcf802706e5e02db4e0c1c3dc36fe7974e2fc82ebc6c3383a9549c7887c47"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-alpha1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "d38d3266a816f9fafcbff042256f63acbb5b9af656263f2d145cc010f3495df9"
    sha256 cellar: :any_skip_relocation, high_sierra: "7fdc1daa24c6129e4a33b0498b455960dac4c406d63dbc539fd37824ea1aaa4e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "46108105e967a4d44bdb7d6bf38cd2b78a2bf4b6e2573e6fbc7d3c5a04f78c0b"
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
