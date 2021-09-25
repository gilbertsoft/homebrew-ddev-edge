class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-rc4.tar.gz"
  sha256 "4996019d4c0f9611ecbb86cafbb818488b7c6f87041c435fc7f0141ef6309498"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-rc4/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "a05412f7246e22ad477cee057c7f7c99e498cca25ef886ce3ef334abdc37bb14"
    sha256 cellar: :any_skip_relocation, high_sierra: "539c9833af867c01db845ab43729a70138d28527a0a8e40dc051d41529b139a0"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "584bbb8c6cb065c0611faed89769259a0248eb181e65a814d79a4131d87d7ca4"
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
