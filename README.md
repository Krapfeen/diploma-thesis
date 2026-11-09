# Corporate Web Messenger — meta workspace

Orchestration of the `server` and `client` repositories via git submodules.

## Architecture

Each repository is self-contained and ships its own `compose.yml`:

- **server/** — PHP 8.2 / Symfony 7, Ratchet WebSocket, PostgreSQL 15,
  Redis 7, MinIO, Nginx (reverse-proxy for the API and the WS endpoint)
- **client/** — Vue 3 + Vite; Nginx serves static assets in production
- **meta** (this repo) — aggregates both via `include:` in `compose.yml`

Consequences:

- run the server only: `cd server && docker compose up`
- run the client only: `cd client && docker compose up`
- run everything: `docker compose up` from the repository root

## Submodules

- `server/` → [diploma-thesis-server](https://github.com/Krapfeen/diploma-thesis-server)
- `client/` → [diploma-thesis-client](https://github.com/Krapfeen/diploma-thesis-client)

Clone including submodules:

```bash
git clone --recurse-submodules <url>
```
