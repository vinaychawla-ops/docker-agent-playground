# docker-agent-playground

Notes, installer, and sample agent configs for **Docker Agent** — Docker's
open-source agent runtime (`docker agent run`): agents declared in YAML/HCL,
run with one command, shared through any OCI registry.

Probed 2026-10-11 against upstream `docker/docker-agent` **v1.150.0**.

## Quick start

```sh
./install.sh            # downloads the docker-agent binary into ./bin
export PATH="$PWD/bin:$PATH"

docker-agent doctor     # shows which model-provider credentials are set
docker-agent getting-started   # hands-on interactive tour

# run the sample agents (needs a model key, e.g. OPENAI_API_KEY)
docker-agent run agents/support-reviewer.yaml
docker-agent run --exec agents/support-reviewer.yaml "summarize the README"
```

## What's here

- `install.sh` — fetches the latest `docker-agent` release binary for your
  platform (linux/darwin, amd64/arm64) into `./bin`. The binary is ~145MB, so
  it is not committed; this script is the distribution path.
- `agents/support-reviewer.yaml` — single read-only reviewer agent
  (filesystem + think toolsets). Config validated end-to-end 2026-10-11
  (parses, run reaches the model API; fails only without a key).
- `agents/team.yaml` — multi-agent team: a coordinator delegating to a coder
  and a reviewer, different models per agent.
- `NOTES.md` — everything the probe turned up: the 27 built-in toolsets,
  `serve` modes (HTTP API, OpenAI-compatible chat, MCP server, A2A, ACP),
  OCI `share push/pull`, eval, Kanban board, provider list, and limits.

## Model keys

The agent loop needs a provider credential; `docker-agent doctor` reports
what's set. Supported env vars include `OPENAI_API_KEY`, `ANTHROPIC_API_KEY`,
`GOOGLE_API_KEY`, `OPENROUTER_API_KEY`, and `NVIDIA_API_KEY` (NVIDIA NIM,
which has a free tier). Local models work via Docker Model Runner or Ollama.

## Links

- Docs: https://docker.github.io/docker-agent/
- Upstream repo: https://github.com/docker/docker-agent
