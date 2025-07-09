# Create this file at Formula/your-app.rb in your homebrew-tap repository
class walletfetch < Formula
  desc "Like Neofetch, but for your wallet"
  homepage "https://github.com/stevedylandev/walletfetch"
  url "https://github.com/stevedylandev/walletfetch/releases/download/v0.0.1/walletfetch-macos-x86_64.tar.gz"
  sha256 "replace-with-actual-sha256"
  version "0.0.1"
  license "MIT" # or your license

  # Optional: Add dependencies if needed
  # depends_on "some-dependency"

  # Support both Intel and Apple Silicon Macs
  on_macos do
    if Hardware::CPU.intel?
      url "https://github.com/your-username/your-app/releases/download/v1.0.0/your-app-macos-x86_64.tar.gz"
      sha256 "intel-sha256"
    elsif Hardware::CPU.arm?
      url "https://github.com/your-username/your-app/releases/download/v1.0.0/your-app-macos-aarch64.tar.gz"
      sha256 "arm-sha256"
    end
  end

  def install
    bin.install "waletfetch"
    
    # Optional: Install man pages, completions, etc.
    # man1.install "docs/your-app.1"
    # bash_completion.install "completions/your-app.bash"
    # zsh_completion.install "completions/_your-app"
    # fish_completion.install "completions/your-app.fish"
  end

  test do
    system "#{bin}/walletfetch", "--version"
  end
end
