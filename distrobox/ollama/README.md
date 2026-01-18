# Distrobox Ollama Environment

Arch Linux-based container for running Ollama and local LLMs.

## Quick Start

```bash
podman build -t distrobox-ollama ~/.dotfiles/distrobox/ollama/
distrobox create -i distrobox-ollama -n ollama
distrobox enter ollama
distrobox-setup
```

## Included Tools

### LLM Runtime
- **Ollama** - Local LLM runner

### Python Libraries
| Library | Description |
|---------|-------------|
| ollama | Official Ollama Python client |
| langchain | LLM application framework |
| llama-index | Data framework for LLMs |
| chromadb | Vector database |
| openai | OpenAI-compatible client |

### Interfaces
- **oterm** - Terminal UI for Ollama

## Helper Commands

| Command | Description |
|---------|-------------|
| `ollama-start` | Start Ollama server |
| `ollama-chat [model]` | Chat with a model |
| `ollama-models` | List/pull/remove models |
| `ollama-api model "prompt"` | Quick API call |
| `oterm` | Ollama TUI |

## Popular Models

| Model | Size | Description |
|-------|------|-------------|
| llama3.2 | 3B | Meta's latest, good all-rounder |
| llama3.2:70b | 70B | Largest Llama, best quality |
| mistral | 7B | Fast and capable |
| mixtral | 8x7B | Mixture of experts |
| codellama | 7B+ | Code generation |
| deepseek-coder | 6.7B+ | Strong code model |
| phi3 | 3.8B | Microsoft, efficient |
| qwen2.5-coder | 7B | Alibaba, excellent for code |
| gemma2 | 9B | Google's open model |

## Common Workflows

### Start and Chat

```bash
# Terminal 1: Start server
ollama-start

# Terminal 2: Chat
ollama-chat llama3.2

# Or pull first
ollama-models pull mistral
ollama-chat mistral
```

### Model Management

```bash
# List installed models
ollama-models list

# Pull a model
ollama-models pull codellama

# Remove a model
ollama-models rm codellama
```

### API Usage

```bash
# Quick prompt
ollama-api llama3.2 "Explain Docker in one sentence"

# With curl
curl http://localhost:11434/api/generate -d '{
  "model": "llama3.2",
  "prompt": "Hello!",
  "stream": false
}'
```

### Python Examples

```python
# Simple chat
import ollama

response = ollama.chat(
    model='llama3.2',
    messages=[{'role': 'user', 'content': 'Hello!'}]
)
print(response['message']['content'])
```

```python
# Streaming
import ollama

for chunk in ollama.chat(
    model='llama3.2',
    messages=[{'role': 'user', 'content': 'Write a poem'}],
    stream=True
):
    print(chunk['message']['content'], end='', flush=True)
```

```python
# With LangChain
from langchain_community.llms import Ollama

llm = Ollama(model="llama3.2")
response = llm.invoke("Explain recursion")
print(response)
```

### OpenAI-Compatible API

Ollama provides an OpenAI-compatible endpoint:

```python
from openai import OpenAI

client = OpenAI(
    base_url="http://localhost:11434/v1",
    api_key="ollama"  # Required but unused
)

response = client.chat.completions.create(
    model="llama3.2",
    messages=[{"role": "user", "content": "Hello!"}]
)
print(response.choices[0].message.content)
```

## GPU Support

The distrobox.ini has `nvidia=true` for GPU passthrough. Ensure:

1. NVIDIA drivers installed on host
2. nvidia-container-toolkit installed
3. Podman configured for GPU access

```bash
# Check GPU is visible
nvidia-smi
```

## Environment Variables

```bash
# API host (default)
export OLLAMA_HOST="http://localhost:11434"

# Model storage location
export OLLAMA_MODELS="$HOME/.ollama/models"

# GPU layers (0 = CPU only)
export OLLAMA_NUM_GPU=999
```

## Memory Requirements

| Model Size | RAM Required |
|------------|--------------|
| 3B | ~4GB |
| 7B | ~8GB |
| 13B | ~16GB |
| 70B | ~48GB+ |

Quantized versions (Q4_0, Q4_K_M) use less memory.
