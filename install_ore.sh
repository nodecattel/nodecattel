#!/bin/bash

# Install Rust and Cargo
echo "Installing Rust and Cargo..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Ensure the cargo bin directory is in the PATH
source "$HOME/.cargo/env"

# Install Solana CLI
echo "Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

# Generate a Solana keypair and show the address
echo "Generating a Solana keypair..."
KEYPAIR_OUTPUT=$(solana-keygen new --no-outfile)
echo "$KEYPAIR_OUTPUT"
echo "Your Solana address is:"
echo "$KEYPAIR_OUTPUT" | grep -o 'pubkey: .*' | cut -d ' ' -f2

# Install Ore CLI
echo "Installing Ore CLI..."
cargo install ore-cli

# Download the ore.sh script
echo "Downloading the ore.sh script for mining..."
curl -o ore.sh https://raw.githubusercontent.com/nodecattel/nodecattel/main/ore.sh
chmod +x ore.sh

echo "Installation complete. Please ensure you have enough SOL topped up on your account to pay for transaction fees."
echo "You can start mining with the Ore CLI using the './ore.sh' command."