#!/bin/bash

# Exit script if any command fails
set -e

# Install Rust and Cargo
echo "Installing Rust and Cargo..."
curl https://sh.rustup.rs -sSf | sh -s -- -y

# Ensure Cargo is in the PATH
source $HOME/.cargo/env

# Install Solana CLI
echo "Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

# Install Ore CLI
echo "Installing Ore CLI..."
cargo install ore-cli

echo "Installation completed successfully."