class Walletfetch < Formula
  desc "Like Neofetch, but for your wallet"
  homepage "https://github.com/stevedylandev/walletfetch"
  version "0.0.13"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.13/walletfetch-aarch64-apple-darwin.tar.xz"
      sha256 "7493520ff5624efdb0c9c85a745d2938b3de7b43068974c6fc955b4186f60075"
    end
    if Hardware::CPU.intel?
      url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.13/walletfetch-x86_64-apple-darwin.tar.xz"
      sha256 "7d3b13d18caf5c727cf37926d26cefea9302ff5919f4242f043d872d146f125b"
    end
  end
  if OS.linux? && Hardware::CPU.intel?
    url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.13/walletfetch-x86_64-unknown-linux-gnu.tar.xz"
    sha256 "b92c6d5b948d7f57fcfe8beecd98273e8bc04689ddf55d1f3805cc40d9fac674"
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
