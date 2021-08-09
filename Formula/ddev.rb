class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.18.0-alpha4.tar.gz"
  sha256 "fe40d8af15ae63bf39e5564580687f67dd4793054ccc85c444867f23b4b25a2a"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.18.0-alpha4/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "eac6dba26df963ac79e5b2dfde6d47e17cac60a3ca4d7eb18129d22c05a9826e"
    sha256 cellar: :any_skip_relocation, high_sierra: "7d57dad341e360b21d1e99402bcdd1be0534a7c89cf77345bd26af70f9337f3e"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "f70af6587def87c51a961b90adb2ddb517653526a12b6c3c55dd8ff5d1cbb0e1"
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
