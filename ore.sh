#!/bin/bash
# Version Information, and Credits
echo -e "\033[0;32m" # Start green color
cat << "EOF"
█▀█ █▀█ █▀▀ █▀▄▀█ █ █▄░█ █▀▀ █▀█
█▄█ █▀▄ ██▄ █░▀░█ █ █░▀█ ██▄ █▀▄
EOF
echo -e "Version 0.1.0 - Ore Mining Script"
echo -e "Made by NodeCattel\033[0m" # End green color

# Initial variable settings
ORE_DIR="$HOME/.ore"
CONFIG_FILE="$ORE_DIR/ore.conf"
DEFAULT_RPC="https://api.mainnet-beta.solana.com"
DEFAULT_PRIORITY_FEE="5000"
DEFAULT_THREADS="4"
KEYPAIR_PATH="$HOME/.config/solana/id.json"

# Create Ore directory
mkdir -p "$ORE_DIR"

# Function to display help message
show_help() {
    echo -e "\033[0;32mUsage: $0 [options] [preset]\033[0m"
    echo "Options:"
    echo "  -r <RPC URL>        Specify the RPC URL."
    echo "  -k <keypair path>   Specify the keypair path. (This option is ignored since we're using the default path)"
    echo "  -f <priority fee>   Specify the priority fee."
    echo "  -t <threads>        Specify the number of threads."
    echo "Presets:"
    echo "  fast                Increase priority fee by 25% and threads by 2."
    echo "  --help              Display this help message and exit."
}

# Generate Solana keypair if it does not exist
if [ ! -f "$KEYPAIR_PATH" ]; then
    echo -e "\033[0;32mGenerating Solana keypair...\033[0m"
    solana-keygen new --no-passphrase --outfile "$KEYPAIR_PATH"
fi

# Extract the public key (wallet address) from the keypair
WALLET_ADDRESS=$(solana-keygen pubkey "$KEYPAIR_PATH")
echo -e "\033[0;32mYour wallet address is: $WALLET_ADDRESS\033[0m"

# Function to setup defaults and save to config file
setup_defaults() {
    echo -e "\033[0;32mSetting up default values for mining.\033[0m"

    # Default values setup
    read -e -p "Enter default RPC URL [$DEFAULT_RPC]: " -i "$DEFAULT_RPC" RPC
    read -e -p "Enter default priority fee [$DEFAULT_PRIORITY_FEE]: " -i "$DEFAULT_PRIORITY_FEE" PRIORITY_FEE
    read -e -p "Enter default number of threads [$DEFAULT_THREADS]: " -i "$DEFAULT_THREADS" THREADS

    # Save to config file
    echo "RPC=$RPC" > "$CONFIG_FILE"
    echo "PRIORITY_FEE=$PRIORITY_FEE" >> "$CONFIG_FILE"
    echo "THREADS=$THREADS" >> "$CONFIG_FILE"
    echo "WALLET_ADDRESS=$WALLET_ADDRESS" >> "$CONFIG_FILE"
}

# Load config if exists or setup defaults
if [ ! -f "$CONFIG_FILE" ]; then
    setup_defaults
else
    source "$CONFIG_FILE"
fi

# Prompt screen to start mining
read -p "Press any key to start mining with the above wallet address or CTRL+C to cancel..."

# Display mining configuration
echo -e "\033[0;32mStarting mining operation with the following configuration:\033[0m"
echo "RPC URL: $RPC"
echo "Priority Fee: $PRIORITY_FEE"
echo "Threads: $THREADS"
echo "Wallet Address: $WALLET_ADDRESS"

# Start mining in a loop.
while :; do
    echo "Mining operation would start here."
    # Simulating a mining operation with sleep
    sleep 5

    echo -e "\033[0;32mMining process exited, restarting in 3 seconds...\033[0m"
    sleep 3
done