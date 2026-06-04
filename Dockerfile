# Self-hosted github-readme-stats image for stats.wielandtech.com
#
# Upstream ships express.js, which mounts the same cards the README uses:
#   GET /api            -> stats card
#   GET /api/top-langs  -> top languages card
# We just containerize that server. A GitHub PAT is supplied at runtime via the
# PAT_1 env var (see the homelab sealed secret).
FROM node:22-alpine

WORKDIR /app

# express is a *devDependency* upstream, so a production-only install would omit
# it and the server would not start — install the full dependency set.
# --ignore-scripts skips the husky "prepare" hook (needs git, not wanted in the image).
COPY package.json package-lock.json ./
RUN npm ci --ignore-scripts

COPY . .

ENV PORT=9000
EXPOSE 9000

# express.js binds 0.0.0.0:$PORT
CMD ["node", "express.js"]
