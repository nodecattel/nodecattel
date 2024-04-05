#!/bin/bash
#made by NodeCattel

CONFIG_FILE="$HOME/.ore_config"

# Function to display help message
show_help() {
  echo "Usage: $0 [options] [preset]"
  echo "Options:"
  echo "  -r <RPC URL>        Specify the RPC URL."
  echo "  -k <keypair path>   Specify the keypair path."
  echo "  -f <priority fee>   Specify the priority fee."
  echo "  -t <threads>        Specify the number of threads."
  echo "Presets:"
  echo "  fast                Increase priority fee by 25% and threads by 2."
  echo "  --help              Display this help message and exit."
}

# First-time setup
setup_defaults() {
  echo "It looks like this is the first time you are running the script."
  echo "Setup Initiated..."

  read -p "Enter Solana RPC URL [$RPC]: " input_rpc
  RPC="${input_rpc:-$RPC}"

  read -p "Enter your keypair path [$KEYPAIR]: " input_keypair
  KEYPAIR="${input_keypair:-$KEYPAIR}"

  read -p "Enter default priority fee [$PRIORITY_FEE]: " input_fee
  PRIORITY_FEE="${input_fee:-$PRIORITY_FEE}"

  read -p "Enter number of threads to mine with [$THREADS]: " input_threads
  THREADS="${input_threads:-$THREADS}"

  # Save configuration
  echo "RPC=$RPC" > "$CONFIG_FILE"
  echo "KEYPAIR=$KEYPAIR" >> "$CONFIG_FILE"
  echo "PRIORITY_FEE=$PRIORITY_FEE" >> "$CONFIG_FILE"
  echo "THREADS=$THREADS" >> "$CONFIG_FILE"
}

# Load or setup default configuration
if [ -f "$CONFIG_FILE" ]; then
  source "$CONFIG_FILE"
else
  # Default values for the first-time setup
  RPC="https://api.mainnet-beta.solana.com"
  KEYPAIR="/Users/nodecattel/.config/solana/id.json"
  PRIORITY_FEE=100000
  THREADS=4
  setup_defaults
fi

# Existing parsing and execution logic remains the same