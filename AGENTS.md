# AGENTS.md — fork deployment notes

This is a fork of `anuraghazra/github-readme-stats`, self-hosted on the
homelab at https://stats.wielandtech.com. Keep drift from upstream minimal —
prefer syncing upstream over local patches.

**Merging to `master` is a production deploy**: the
`build-selfhost-image.yml` workflow publishes
`ghcr.io/wielandtech-labs/github-readme-stats:YYYYMMDD-HHMMSS-<sha>` (doc and
theme changes are path-ignored), and Flux image automation in
`wielandtech-labs/w_homelab` auto-deploys it. There is no dev/QA tier or
review app for this fork.

Deployment manifests: `w_homelab` `clusters/prod/apps/github-readme-stats/`.
Rollback = revert the HelmRelease image tag there via PR. Do not change the
CI tag format — Flux ImagePolicies parse it.
