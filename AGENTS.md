# AGENTS.md — docker-agent-playground

How to work in this repo.

## What it is

A playground/notes repo for Docker Agent (upstream: docker/docker-agent),
not a fork. Everything here is config, scripts, and notes — no application
code.

## Conventions

- The `docker-agent` binary is never committed (it's ~145MB). `install.sh`
  fetches it from upstream releases; update the pinned version there.
- Sample agents live in `agents/` as `.yaml`. Validate a new one before
  committing: `docker-agent run --exec <file> "ping"` should reach the model
  API (it will fail on auth without a key — that means the YAML parsed).
- Probe findings and CLI output go in `NOTES.md` with the date and the
  upstream version they were observed against. Never present stale findings
  as current; re-run before claiming.
- Upstream version pinned at probe time: **v1.150.0** (2026-10-11).
- This repo is public. Nothing confidential or Vector 3 related goes here.
