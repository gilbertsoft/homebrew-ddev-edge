class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-rc3.tar.gz"
  sha256 "803b7975e989283f8002881e0b1ef79c87226d55e07e0cda5cc14b4623691a3f"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-rc3/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "7dcbbe516a00347f2c520fc1575deff2caf5046f0dbe69120991da999bdb4a88"
    sha256 cellar: :any_skip_relocation, high_sierra: "8f46cf49661d955409ff20c2789270198bb4b2853a5ff85a30febe71e964c2ed"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b50043ab1e0bb54b4ad1a1812181f46f656b902000df9779b810b874cacfa517"
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
