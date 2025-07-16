class Walletfetch < Formula
  desc "Like Neofetch, but for your wallet"
  homepage "https://github.com/stevedylandev/walletfetch"
  version "0.0.14"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.14/walletfetch-aarch64-apple-darwin.tar.xz"
      sha256 "d3878da0fb3b61d5eb529b98e5ac738b414e65acef44b0cdc2681735b3fcda35"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.14/walletfetch-x86_64-apple-darwin.tar.xz"
      sha256 "b2315b8d691d083d4a6c3b464f0b732992f59d15b7f9561e6ebf319de35ce0ab"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.14/walletfetch-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "cf5f29243b02ade8fb4088234d61ccf6c1b29bbdd3cf8a5d9a0986f1bafe33be"
  end
  license "MIT"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":     {},
    "x86_64-apple-darwin":      {},
    "x86_64-pc-windows-gnu":    {},
    "x86_64-unknown-linux-gnu": {},
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
    bin.install "walletfetch" if OS.mac? && Hardware::CPU.arm?
    bin.install "walletfetch" if OS.mac? && Hardware::CPU.intel?
    bin.install "walletfetch" if OS.linux? && Hardware::CPU.intel?

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
