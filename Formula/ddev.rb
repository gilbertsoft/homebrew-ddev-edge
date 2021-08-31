class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-rc1.tar.gz"
  sha256 "138cb17f1633cf868add13bd9ea3aced2fdfadf24140758ccd048ef3972e5499"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-rc1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "3b2bdd8fbb156e8d845d776cf305211419b82e2704920e513e8ea1e61cb2165f"
    sha256 cellar: :any_skip_relocation, high_sierra: "6e58336bfcf486df65528cc95458279e0f2b84af11899c8aed984b8254132dd4"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "30191f3ead3bac2c70c9bc8fc3e6ed979de5ed77200ecd94e5b3af8ab88623a9"
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
