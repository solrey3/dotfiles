#!/bin/bash
# Post-creation setup script for Ollama distrobox
set -e

echo "===================================="
echo "Distrobox Ollama Environment Setup"
echo "===================================="
echo ""

BIN_DIR="$HOME/.local/bin"
mkdir -p "$BIN_DIR"
export PATH="$BIN_DIR:$PATH"

# Install Ollama
if ! command -v ollama &> /dev/null; then
    echo "Installing Ollama..."
    curl -fsSL https://ollama.com/install.sh | sh || {
        echo "Standard install failed, trying manual..."
        OLLAMA_VERSION=$(curl -fsSL "https://api.github.com/repos/ollama/ollama/releases/latest" | jq -r '.tag_name')
        curl -fsSLo "$BIN_DIR/ollama" "https://github.com/ollama/ollama/releases/download/${OLLAMA_VERSION}/ollama-linux-amd64"
        chmod +x "$BIN_DIR/ollama"
    }
fi

# Install Python LLM tools
echo ""
echo "Installing Python LLM tools..."
pip install --user --break-system-packages \
    ollama \
    openai \
    langchain \
    langchain-community \
    llama-index \
    chromadb \
    rich \
    2>/dev/null || echo "Some Python packages failed, continuing..."

# Install oterm (Ollama TUI)
if ! command -v oterm &> /dev/null; then
    echo "Installing oterm (Ollama TUI)..."
    pip install --user --break-system-packages oterm 2>/dev/null || echo "oterm installation failed, skipping..."
fi

# Create helper scripts
cat > "$BIN_DIR/ollama-start" << 'EOF'
#!/bin/bash
# Start Ollama server
echo "Starting Ollama server..."
echo "API: http://localhost:11434"
ollama serve
EOF
chmod +x "$BIN_DIR/ollama-start"

cat > "$BIN_DIR/ollama-chat" << 'EOF'
#!/bin/bash
# Quick chat with a model
MODEL="${1:-llama3.2}"
echo "Chatting with $MODEL (Ctrl+D to exit)"
ollama run "$MODEL"
EOF
chmod +x "$BIN_DIR/ollama-chat"

cat > "$BIN_DIR/ollama-models" << 'EOF'
#!/bin/bash
# List and manage models
case "${1:-list}" in
    list)
        ollama list
        ;;
    pull)
        ollama pull "${2:-llama3.2}"
        ;;
    rm)
        ollama rm "$2"
        ;;
    *)
        echo "Usage: ollama-models [list|pull|rm] [model]"
        echo ""
        echo "Popular models:"
        echo "  llama3.2        - Meta's Llama 3.2 (3B)"
        echo "  llama3.2:70b    - Llama 3.2 70B"
        echo "  mistral         - Mistral 7B"
        echo "  mixtral         - Mixtral 8x7B"
        echo "  codellama       - Code Llama"
        echo "  deepseek-coder  - DeepSeek Coder"
        echo "  phi3            - Microsoft Phi-3"
        echo "  qwen2.5-coder   - Alibaba Qwen 2.5 Coder"
        echo "  gemma2          - Google Gemma 2"
        ;;
esac
EOF
chmod +x "$BIN_DIR/ollama-models"

cat > "$BIN_DIR/ollama-api" << 'EOF'
#!/bin/bash
# Quick API call to Ollama
MODEL="${1:-llama3.2}"
PROMPT="$2"

if [ -z "$PROMPT" ]; then
    echo "Usage: ollama-api [model] \"prompt\""
    exit 1
fi

curl -s http://localhost:11434/api/generate -d "{
  \"model\": \"$MODEL\",
  \"prompt\": \"$PROMPT\",
  \"stream\": false
}" | jq -r '.response'
EOF
chmod +x "$BIN_DIR/ollama-api"

# Create Python example script
mkdir -p "$HOME/ollama-examples"
cat > "$HOME/ollama-examples/chat.py" << 'EOF'
#!/usr/bin/env python3
"""Simple Ollama chat example"""
import ollama

response = ollama.chat(
    model='llama3.2',
    messages=[
        {'role': 'user', 'content': 'Hello! How are you?'}
    ]
)
print(response['message']['content'])
EOF
chmod +x "$HOME/ollama-examples/chat.py"

cat > "$HOME/ollama-examples/stream.py" << 'EOF'
#!/usr/bin/env python3
"""Streaming Ollama example"""
import ollama

stream = ollama.chat(
    model='llama3.2',
    messages=[{'role': 'user', 'content': 'Write a haiku about coding'}],
    stream=True,
)

for chunk in stream:
    print(chunk['message']['content'], end='', flush=True)
print()
EOF
chmod +x "$HOME/ollama-examples/stream.py"

# Shell configuration
echo ""
echo "Configuring shell..."

if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
fi
if ! grep -q 'export PATH="$HOME/.local/bin:$PATH"' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
fi

# Ollama environment
if ! grep -q 'OLLAMA_HOST' "$HOME/.bashrc" 2>/dev/null; then
    echo 'export OLLAMA_HOST="http://localhost:11434"' >> "$HOME/.bashrc"
fi
if ! grep -q 'OLLAMA_HOST' "$HOME/.zshrc" 2>/dev/null; then
    echo 'export OLLAMA_HOST="http://localhost:11434"' >> "$HOME/.zshrc"
fi

if ! grep -q "zoxide init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(zoxide init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "zoxide init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(zoxide init zsh)"' >> "$HOME/.zshrc"
fi

if ! grep -q "starship init" "$HOME/.bashrc" 2>/dev/null; then
    echo 'eval "$(starship init bash)"' >> "$HOME/.bashrc"
fi
if ! grep -q "starship init" "$HOME/.zshrc" 2>/dev/null; then
    echo 'eval "$(starship init zsh)"' >> "$HOME/.zshrc"
fi

echo ""
echo "===================================="
echo "Setup Complete!"
echo "===================================="
echo ""
echo "Helper commands:"
echo "  ollama-start      - Start Ollama server"
echo "  ollama-chat [m]   - Chat with model"
echo "  ollama-models     - List/pull/remove models"
echo "  ollama-api m \"p\" - Quick API call"
echo "  oterm             - Ollama TUI client"
echo ""
echo "Python libraries:"
echo "  ollama, langchain, llama-index, chromadb"
echo ""
echo "Example scripts: ~/ollama-examples/"
echo ""
echo "Quick start:"
echo "  1. Start server:  ollama-start"
echo "  2. Pull model:    ollama-models pull llama3.2"
echo "  3. Chat:          ollama-chat llama3.2"
echo ""
echo "Popular models:"
echo "  llama3.2, mistral, codellama, deepseek-coder"
echo "  phi3, qwen2.5-coder, gemma2"
echo ""
