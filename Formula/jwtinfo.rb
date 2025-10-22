class Jwtinfo < Formula
  desc "Command line tool to get information about JWTs (Json Web Tokens)"
  homepage "https://github.com/lmammino/jwtinfo"
  version "0.6.1"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.6.1/jwtinfo-aarch64-apple-darwin.tar.xz"
      sha256 "39e54f8f3278c54d437d81c2eb398e99ccbe58acbf822afed61599976e3051f2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.6.1/jwtinfo-x86_64-apple-darwin.tar.xz"
      sha256 "395b3e1e734c0483895e6482c503daac1bfba78234d78d37ff8ea520b2b6c7dc"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.6.1/jwtinfo-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "6e745874af85e24ac83474286d4120f1062571b8dd927d8e3fea67c1be156d70"
    end
    if Hardware::CPU.intel?
      url "https://github.com/lmammino/jwtinfo/releases/download/v0.6.1/jwtinfo-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "532cc5c82c6c207438b6b06a8cc30d3f4259133d5b6d1ef3a59a840fa31f7d98"
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
    bin.install "jwtinfo" if OS.mac? && Hardware::CPU.arm?
    bin.install "jwtinfo" if OS.mac? && Hardware::CPU.intel?
    bin.install "jwtinfo" if OS.linux? && Hardware::CPU.arm?
    bin.install "jwtinfo" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
