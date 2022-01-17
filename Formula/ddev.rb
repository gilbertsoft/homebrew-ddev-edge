class Ddev < Formula
  desc "Local web development system"
  homepage "https://ddev.readthedocs.io/"
  url "https://github.com/drud/ddev/archive/v1.19.0-alpha2.tar.gz"
  sha256 "6a1f82d6bcaaeb94a9122f5b0b978ccfc968d2abdbe7b0318b409690ab775e75"
  license "apache-2.0"
  head "https://github.com/drud/ddev.git", branch: "master"

  depends_on "mkcert" => :run
  depends_on "nss" => :run
  depends_on "go" => :build
  depends_on "make" => :build

  bottle do
    root_url "https://github.com/drud/ddev/releases/download/v1.19.0-alpha2/"
    sha256 cellar: :any_skip_relocation, x86_64_linux: "56403f4f7b308f6cfd018a92ae011b18f445e61ec4c418d67263890f1ac80da9"
    sha256 cellar: :any_skip_relocation, high_sierra: "aac508898becbc51ed4c6d96cf51763c1139ce1c2812a67ce74d6b9ac7582fc2"
    sha256 cellar: :any_skip_relocation, arm64_big_sur: "b91d54020a4dcaca95880250efe94267051c8fa4681e4d311d8440ee94a87a90"
  end
  def install
    system "make", "VERSION=v#{version}", "COMMIT=v#{version}"
    system "mkdir", "-p", "#{bin}"
    if OS.mac?
        if Hardware::CPU.arm?
            system "cp", ".gotmp/bin/darwin_arm64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_arm64/ddev_gen_autocomplete"
        else
            system "cp", ".gotmp/bin/darwin_amd64/ddev", "#{bin}/ddev"
            system ".gotmp/bin/darwin_amd64/ddev_gen_autocomplete"
        end
    end
    if OS.linux?
      system "cp", ".gotmp/bin/linux_amd64/ddev", "#{bin}/ddev"
      system ".gotmp/bin/linux_amd64/ddev_gen_autocomplete"
    end
    bash_completion.install ".gotmp/bin/ddev_bash_completion.sh" => "ddev"
    zsh_completion.install ".gotmp/bin/ddev_zsh_completion.sh" => "ddev"
    fish_completion.install ".gotmp/bin/ddev_fish_completion.sh" => "ddev"
  end

  def caveats
    <<~EOS
            Make sure to do a 'mkcert -install' if you haven't done it before, it may require your sudo password.
      #{"      "}
            ddev requires docker or colima.
            See https://ddev.readthedocs.io/en/latest/users/docker_installation/
    EOS
  end

  test do
    system "#{bin}/ddev", "--version"
  end
end
