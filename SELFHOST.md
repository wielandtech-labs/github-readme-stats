# Self-hosted github-readme-stats

This is a fork of [anuraghazra/github-readme-stats](https://github.com/anuraghazra/github-readme-stats)
self-hosted in my K3s homelab so the cards on my GitHub profile don't depend on
the shared `github-readme-stats.vercel.app` instance (which is frequently
rate-limited / paused).

## How it runs

Upstream already ships `express.js`, which serves the same endpoints the public
instance does:

| Route | Card |
|-------|------|
| `GET /api` | overall stats |
| `GET /api/top-langs` | top languages |

The added `Dockerfile` containerizes that server (port `9000`), and
`.github/workflows/build-selfhost-image.yml` builds + pushes it to
`ghcr.io/wielandtech/github-readme-stats`. Flux image-automation in the homelab
repo tracks the `YYYYMMDD-HHMMSS-<sha>` tag and rolls the Deployment.

A GitHub PAT (classic, `public_repo` / read-only scope is enough) is supplied at
runtime via the `PAT_1` env var — see the homelab sealed secret.

Served publicly at <https://stats.wielandtech.com>.

## Syncing upstream

`git fetch upstream && git merge upstream/master` — the only local additions are
`Dockerfile`, `.dockerignore`, `SELFHOST.md`, and the build workflow, so merges
should stay clean.
