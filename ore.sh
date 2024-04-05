#!/bin/bash

# Variables
CONFIG_FILE="$HOME/.ore_config"
DEFAULT_RPC="https://api.mainnet-beta.solana.com"
DEFAULT_PRIORITY_FEE="5000"
DEFAULT_THREADS="4"
DEFAULT_KEYPAIR="$HOME/.config/solana/id.json"

# Load existing config or use default values
if [[ -f "$CONFIG_FILE" ]]; then
    source "$CONFIG_FILE"
else
    RPC="$DEFAULT_RPC"
    PRIORITY_FEE="$DEFAULT_PRIORITY_FEE"
    THREADS="$DEFAULT_THREADS"
    KEYPAIR="$DEFAULT_KEYPAIR"
fi

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

# Function to parse command-line options
while getopts ":r:k:f:t:" opt; do
    case ${opt} in
        r ) RPC="$OPTARG"
            ;;
        k ) KEYPAIR="$OPTARG"
            ;;
        f ) PRIORITY_FEE="$OPTARG"
            ;;
        t ) THREADS="$OPTARG"
            ;;
        \? ) show_help
             exit 1
            ;;
    esac
done
shift $((OPTIND -1))

# Check for help or fast preset
if [[ "$1" == "--help" ]]; then
    show_help
    exit 0
elif [[ "$1" == "fast" ]]; then
    PRIORITY_FEE=$((PRIORITY_FEE + PRIORITY_FEE / 4))
    THREADS=$((THREADS + 2))
fi

# First-time setup
setup_defaults() {
    echo "It looks like this is the first time you are running this script."
    echo "Let's set up some default values."

    read -p "Enter default RPC URL [$RPC]: " input_rpc
    RPC="${input_rpc:-$RPC}"

    read -p "Enter default keypair path [$KEYPAIR]: " input_keypair
    KEYPAIR="${input_keypair:-$KEYPAIR}"

    read -p "Enter default priority fee [$PRIORITY_FEE]: " input_fee
    PRIORITY_FEE="${input_fee:-$PRIORITY_FEE}"

    read -p "Enter default number of threads [$THREADS]: " input_threads
    THREADS="${input_threads:-$THREADS}"

    # Save the configuration
    echo "RPC=$RPC" > "$CONFIG_FILE"
    echo "KEYPAIR=$KEYPAIR" >> "$CONFIG_FILE"
    echo "PRIORITY_FEE=$PRIORITY_FEE" >> "$CONFIG_FILE"
    echo "THREADS=$THREADS" >> "$CONFIG_FILE"
}

# Main execution block
if [[ ! -f "$CONFIG_FILE" ]]; then
    setup_defaults
else
    while true; do
        echo "Starting mining operation with the following settings:"
        echo "RPC URL: $RPC"
        echo "Keypair Path: $KEYPAIR"
        echo "Priority Fee: $PRIORITY_FEE"
        echo "Threads: $THREADS"
        # Placeholder for the ore command. Replace with the actual command and its options.
        echo "ore-cli command would run here."

        echo "Ore process has exited. Restarting in 3 seconds..."
        sleep 3
    done
fi