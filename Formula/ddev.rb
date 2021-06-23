class Ddev < Formula
  desc "Local development environment management system"
  homepage "https://ddev.readthedocs.io/en/stable/"
  url "https://github.com/drud/ddev/archive/v1.17.6-rc1.tar.gz"
  sha256 "1e6ca74362f4ddba622db521dc46424958f77b8f90d2cc835e42feb2eeef3c36"

  depends_on "mkcert" => :run
  depends_on "nss" => :run

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.17.6-rc1/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "f5f78fcca821c7cb332e9734b496e3fc46af2fd5f506137e2147c05747730ff9"
    sha256 cellar: :any_skip_relocation, high_sierra: "13c6ee3cfef95bbbe25489ef7f88f510d70ec2f6104cab07ac48a6e3267e0739"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "d56ed2920fa3a4e18a9c995acf919ac3427f9202f1a9a43494f5b114883be379"
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
