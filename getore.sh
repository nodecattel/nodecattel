#!/bin/bash

# Define configuration file and default values
CONFIG_FILE="$HOME/.ore_config"
SOLANA_CONFIG_DIR="$HOME/.config/solana"
KEYPAIR_FILE="$SOLANA_CONFIG_DIR/id.json"
RPC_DEFAULT="https://api.mainnet-beta.solana.com"
PRIORITY_FEE_DEFAULT=400000
THREADS_DEFAULT=6

# Install Rust and Cargo
echo "Installing Rust and Cargo..."
curl https://sh.rustup.rs -sSf | sh -s -- -y
source "$HOME/.cargo/env"

# Add Cargo's bin directory to the PATH in .profile and source it
echo 'export PATH="$HOME/.cargo/bin:$PATH"' >> ~/.profile
source ~/.profile

# Install Solana CLI
echo "Installing Solana CLI..."
sh -c "$(curl -sSfL https://release.solana.com/v1.18.4/install)"

# Check for Solana keypair, generate if not exists, and prompt for passphrase
mkdir -p "$SOLANA_CONFIG_DIR"
if [ ! -f "$KEYPAIR_FILE" ]; then
    echo "Generating a new Solana keypair..."
    solana-keygen new --outfile "$KEYPAIR_FILE"
    echo "A new Solana keypair has been generated and stored at: $KEYPAIR_FILE"
else
    echo "Solana keypair already exists at: $KEYPAIR_FILE"
fi

# Install Ore CLI
echo "Installing Ore CLI..."
cargo install ore-cli

# Download the ore.sh script (Now integrated directly into this script)
echo "Preparing for mining..."

# Configuration setup
if [ ! -f "$CONFIG_FILE" ]; then
    SOLANA_WALLET_ADDRESS=$(solana-keygen pubkey --keypair-path "$KEYPAIR_FILE")
    echo "SOLANA_WALLET_ADDRESS=$SOLANA_WALLET_ADDRESS" > "$CONFIG_FILE"
    echo "Default mining configuration saved to $CONFIG_FILE"
fi

# Start mining (simplified example, assuming 'ore mine' is the correct command)
echo "Starting mining with Ore CLI..."
while true; do
  ore \
      --rpc "$RPC_DEFAULT" \
      --keypair "$KEYPAIR_FILE" \
      --priority-fee "$PRIORITY_FEE_DEFAULT" \
      mine \
      --threads "$THREADS_DEFAULT"
  
  echo "Ore process has exited. Restarting in 3 seconds..."
  sleep 3
done

echo "Installation and mining setup complete. Mining in progress..."