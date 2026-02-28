#!/usr/bin/env bash
# Tweetlen Skills - Setup Script
# Configures the API key in ~/.claude/settings.json (Claude Code native config)
#
# Usage:
#   Interactive:     bash setup.sh
#   Non-interactive: bash setup.sh --key twtl_your_key_here

set -euo pipefail

SETTINGS_FILE="$HOME/.claude/settings.json"
API_KEY=""
NON_INTERACTIVE=false

# Parse arguments
while [[ $# -gt 0 ]]; do
  case $1 in
    --key|-k)
      API_KEY="$2"
      NON_INTERACTIVE=true
      shift 2
      ;;
    --help|-h)
      echo "Usage: bash setup.sh [--key twtl_your_key_here]"
      echo ""
      echo "Options:"
      echo "  --key, -k    API key to configure (non-interactive mode)"
      echo "  --help, -h   Show this help message"
      exit 0
      ;;
    *)
      echo "Unknown option: $1"
      exit 1
      ;;
  esac
done

# Check jq is available
if ! command -v jq &> /dev/null; then
  echo "Error: jq is required. Install it with:"
  echo "  brew install jq       # macOS"
  echo "  apt install jq        # Ubuntu/Debian"
  exit 1
fi

echo "=== Tweetlen Skills Setup ==="
echo ""

# Check if key already exists in settings.json
if [ -f "$SETTINGS_FILE" ]; then
  EXISTING_KEY=$(jq -r '.env.TWEETLEN_API_KEY // empty' "$SETTINGS_FILE" 2>/dev/null)
  if [ -n "$EXISTING_KEY" ]; then
    MASKED="${EXISTING_KEY:0:9}...${EXISTING_KEY: -4}"
    if [ "$NON_INTERACTIVE" = true ]; then
      echo "Overwriting existing key: $MASKED"
    else
      echo "Existing API key found: $MASKED"
      read -rp "Overwrite? (y/N): " OVERWRITE
      if [[ ! "$OVERWRITE" =~ ^[Yy]$ ]]; then
        echo "Setup cancelled."
        exit 0
      fi
    fi
  fi
fi

# Get API key (interactive or from argument)
if [ -z "$API_KEY" ]; then
  echo ""
  echo "Get your API key at: https://api.tweetlen.com"
  echo "Key format: twtl_xxxxxxxx..."
  echo ""
  read -rp "Enter your Tweetlen API Key: " API_KEY
fi

# Validate
if [ -z "$API_KEY" ]; then
  echo "Error: API key cannot be empty."
  exit 1
fi

if [[ ! "$API_KEY" =~ ^twtl_ ]]; then
  if [ "$NON_INTERACTIVE" = true ]; then
    echo "Warning: Key doesn't start with 'twtl_', proceeding anyway."
  else
    echo "Warning: Key doesn't start with 'twtl_'. Are you sure this is correct?"
    read -rp "Continue anyway? (y/N): " CONFIRM
    if [[ ! "$CONFIRM" =~ ^[Yy]$ ]]; then
      echo "Setup cancelled."
      exit 1
    fi
  fi
fi

# Ensure ~/.claude directory exists
mkdir -p "$HOME/.claude"

# Write key into settings.json
if [ -f "$SETTINGS_FILE" ]; then
  TEMP_FILE=$(mktemp)
  jq --arg key "$API_KEY" '.env.TWEETLEN_API_KEY = $key' "$SETTINGS_FILE" > "$TEMP_FILE"
  mv "$TEMP_FILE" "$SETTINGS_FILE"
else
  cat > "$SETTINGS_FILE" <<EOF
{
  "env": {
    "TWEETLEN_API_KEY": "$API_KEY"
  }
}
EOF
fi

echo ""
echo "API key saved to: $SETTINGS_FILE"

# Test the key
if [ "$NON_INTERACTIVE" = true ]; then
  echo "Testing key..."
else
  echo ""
  read -rp "Test the API key now? (Y/n): " TEST
  if [[ "$TEST" =~ ^[Nn]$ ]]; then
    echo ""
    echo "Setup complete! You can use Tweetlen skills now."
    exit 0
  fi
  echo "Testing..."
fi

HTTP_CODE=$(curl -s -o /dev/null -w "%{http_code}" \
  -H "Authorization: Bearer $API_KEY" \
  "https://api.tweetlen.com/v2/user/by-username/elonmusk" 2>/dev/null || echo "000")

if [ "$HTTP_CODE" = "200" ]; then
  echo "API key is valid!"
elif [ "$HTTP_CODE" = "401" ]; then
  echo "API key is invalid (401 Unauthorized). Please check your key."
elif [ "$HTTP_CODE" = "429" ]; then
  echo "API key is valid but rate limited. Try again later."
else
  echo "Unexpected response (HTTP $HTTP_CODE). The key may still be valid."
fi

echo ""
echo "Setup complete! You can use Tweetlen skills now — no restart needed."
