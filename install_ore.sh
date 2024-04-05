#!/bin/bash

# Install Rust and Cargo
echo "Installing Rust and Cargo..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Add Cargo's bin directory to the PATH in .profile and source it
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile
source ~/.profile

# Install Solana CLI
echo "Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

# Generate a Solana keypair
echo "Generating a Solana keypair..."
solana-keygen new --no-bip39-passphrase

# Install Ore CLI
echo "Installing Ore CLI..."
cargo install ore-cli

# Download the ore.sh script
echo "Downloading the ore.sh script for mining..."
curl -o ore.sh https://raw.githubusercontent.com/nodecattel/nodecattel/main/ore.sh
chmod +x ore.sh

# Display Solana wallet address
echo "Your Solana wallet address:"
solana-keygen pubkey

echo "Installation complete. Please ensure you have enough SOL topped up on your account to pay for transaction fees."
echo "You can start mining with the Ore CLI using the './ore.sh' command."