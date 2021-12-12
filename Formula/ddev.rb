class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.3-alpha1.tar.gz"
  sha256 "783becb9c8463ba67f81adb4078a25386a59962e7ad095693840901922afc760"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.3-alpha1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "e15b79b9bdae6286882546c187564c4c21c4a381d962318c81ae13313970ed57"
    sha256 cellar: :any_skip_relocation, high_sierra: "e33d6c26280036e34b84c51fc29cd73923f5f52b6e29017dbb777e3be7cfdc1b"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "ca65d8a08c45fff0363a7009575deafe76518d98db970ed2090e3b3c5511b50c"
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
