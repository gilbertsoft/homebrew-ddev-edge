class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.7-alpha1.tar.gz"
  sha256 "0a1d045f1b9014c38a8f74e486a0e569023f6b4bfb8197d43fd07b5a12023d43"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.7-alpha1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "1212b7b1f8721e65008bd2bd9bc16aa74deb54188edd3c098b0da313b64e26f4"
    sha256 cellar: :any_skip_relocation, high_sierra: "286fa96fb0e8c5912e231c7faa66ba31fe562b613a3bfcb9f18cf1f32bb99ba7"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "fd0ca3b83eaefdea52c248ead9dd13620d97f82e07b2e72ceacf4e5b67b1caca"
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
