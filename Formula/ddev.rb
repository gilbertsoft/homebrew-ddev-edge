class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-alpha3.tar.gz"
  sha256 "26be823571e6384931d25d33c67dbb2e4cdafea9ea13c2f519156d98a08544d4"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-alpha3/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "4288e2ee2fcaca94fc791730170491f915c518b7cfec8924e2a5a038c0bd06be"
    sha256 cellar: :any_skip_relocation, high_sierra: "d90b6de98ea89c66fc0956699f88299cb4fae3d8ed0fe2803df9df2216502b3f"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d54e5feb2d367a675842b8ac2f54ec260ccc18b1e5c8351c386f395a857fbc70"
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
