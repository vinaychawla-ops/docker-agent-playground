# Probe notes — Docker Agent v1.150.0 (observed 2026-10-11)

Installed in a Linux x86_64 sandbox from
`https://github.com/docker/docker-agent/releases/download/v1.150.0/docker-agent-linux-amd64`
(145MB, statically linked Go). Binary runs fine headless.

## Verified

- `docker-agent version` → prints welcome banner (version detail terse).
- `docker-agent doctor` → checks `~/.config/cagent/config.yaml` and reports
  per-provider credential status (not set vs set + source). Providers seen:
  anthropic, openai, chatgpt (OAuth), github-copilot, google, mistral,
  openrouter, baseten, ovhcloud, daoxe (+ more below the fold).
- `docker-agent run --exec agent.yaml "…"` with a dummy key → YAML parses,
  agent loop starts, fails only at the model API with HTTP 401. So config
  validation = "does it reach the API call".
- No model key was available in the sandbox, so no live agent loop was run.

## Built-in toolsets (`docker-agent toolsets`)

a2a, api, background_agents, background_jobs, calculator, datetime,
environment, fetch, file, filesystem, git (read-only), lsp, mcp,
mcp_catalog, memory, model_picker, open_url, openapi, plan, rag, random,
scheduler, script, session_context, shell, tasks, think, todo, user_prompt.

Notable: `memory` (persistent key-value cross-session recall), `rag`
(hybrid retrieval over local docs), `todo`/`tasks`/`plan` (task management
+ shared multi-agent scratchpad), `scheduler` (timed/recurring instructions),
`mcp_catalog` (Docker's MCP catalog), `background_agents` (concurrent
sub-agent dispatch), `session_context` (reference a prior session).

## Serve modes (`docker-agent serve`)

a2a, acp, api, chat (OpenAI-compatible chat completions), mcp.
An agent YAML can be exposed as an MCP server or an OpenAI-compatible
endpoint.

## Distribution (`docker-agent share`)

`share push` / `share pull` move agents through any OCI-compatible registry —
same workflow as Docker images.

## Other commands

- `new` — scaffold a new agent config
- `getting-started` — interactive tour
- `eval` — run evaluations for an agent
- `board` — orchestrate agents on a Kanban board
- `alias`, `debug`, `plans`, `sandbox`, `sessions`, `models`, `toolsets`,
  `setup` (interactive model setup), `doctor`, `completion`

Config dirs reference `cagent` (Docker Agent is built on the cagent project):
`~/.config/cagent`, `~/.cagent`, `~/Library/Caches/cagent` (macOS).

## Providers (from docs)

Inline `model: <provider>/<model>` syntax. OpenAI, Anthropic, Google Gemini,
AWS Bedrock, NVIDIA NIM (`nvidia/...`, free tier at build.nvidia.com, also
works against self-hosted NIM via `base_url`), Docker Model Runner, Ollama,
OpenRouter, and more. HCL configs also supported.

## Limits / caveats

- Needs a real model key for anything beyond config validation.
- Marketing page undersells the CLI; the interesting surface is `toolsets`,
  `serve`, `share`, `eval`, `board`.
- 2026-10-11: live loop, TUI, `serve`, and `share` not exercised (no key,
  no registry login in sandbox).
