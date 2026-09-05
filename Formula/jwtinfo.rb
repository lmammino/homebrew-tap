class Jwtinfo < Formula
  desc "Command line tool to get information about JWTs (Json Web Tokens)"
  homepage "https://github.com/lmammino/jwtinfo"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.7.0/jwtinfo-aarch64-apple-darwin.tar.xz"
      sha256 "efc12b7e14de597046fde2202a625568d61b62684f9a4dc0996a80aa74190a74"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.7.0/jwtinfo-x86_64-apple-darwin.tar.xz"
      sha256 "e133454c1cb519b7e7832f105d9199c1c8d164a97e03c4e36de5754d4875a09f"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.7.0/jwtinfo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "e38e7a076560c8c7b2b121e8e3924a3a3979e0a5e560c669f1f25064a7531ab4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.7.0/jwtinfo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "912e668e949c057a5ccd086f04b63adf81689ea7470eed34a16d345589eec3b5"
    end
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-pc-windows-gnu":            {},
    "aarch64-unknown-linux-gnu":         {},
    "armv7-unknown-linux-gnueabihf":     {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "jwtinfo"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "jwtinfo"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "jwtinfo"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "jwtinfo"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
