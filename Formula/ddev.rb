class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.7-alpha2.tar.gz"
  sha256 "185b45e603f6eb14b51433e306bcff0b43a48963cfff5d7f9bc8d22caac1c0d3"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.7-alpha2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "9f08514326f1eaf9cfb9fcfdd0f2d29501da59ec8fa1dc1be781ef8d81738ab3"
    sha256 cellar: :any_skip_relocation, high_sierra: "4ec5a87a537627f93424ea01024431a84bb23669651a7a2a1deba9d39fc3f5a9"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "198e6c193f463368b23267602e9599a22cc202e9b1a8c4af2093c1a78cc3a58a"
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
