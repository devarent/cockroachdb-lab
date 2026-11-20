<div align="center">
<img src="assets/brand-logo.svg" alt="Arya Fatthurahman" width="120" />
</div>

# CockroachDB Lab

<sub>Run a single-node CockroachDB cluster in Docker, explore distributed SQL, and inspect ranges and execution plans.</sub>

<p>
  <img src="https://img.shields.io/badge/Database-CockroachDB-6933FF?style=flat-square" alt="Database: CockroachDB" />
  <img src="https://img.shields.io/badge/Category-Distributed%20SQL-6366F1?style=flat-square" alt="Category: Distributed SQL" />
  <img src="https://img.shields.io/badge/Runs%20in-Docker-2496ED?style=flat-square&logo=docker&logoColor=white" alt="Runs in Docker" />
  <img src="https://img.shields.io/badge/License-MIT-22C55E?style=flat-square" alt="License: MIT" />
  <a href="https://github.com/devarent/cockroachdb-lab/actions/workflows/compose-check.yml"><img src="https://github.com/devarent/cockroachdb-lab/actions/workflows/compose-check.yml/badge.svg" alt="compose-check" /></a>
</p>

## What this lab is

CockroachDB speaks the PostgreSQL wire protocol but behaves like a distributed system. This lab starts a single-node cluster in insecure mode, gives you a schema, and shows the commands that make the distributed nature visible: ranges, replicas, and `EXPLAIN`.

## Quickstart

```bash
docker compose up -d
docker compose exec -T cockroach cockroach sql --insecure --host=localhost:26257 < examples/01_schema.sql
docker compose exec -T cockroach cockroach sql --insecure --host=localhost:26257 < examples/02_queries.sql
open http://localhost:8080
```

## Connection details

| Field | Value |
| --- | --- |
| Host | `localhost` |
| SQL port | `26257` |
| Admin UI | `http://localhost:8080` |
| Database | `defaultdb` |
| User | `root` |
| JDBC URL | `jdbc:postgresql://localhost:26257/defaultdb?sslmode=disable` |
| cockroach sql | `cockroach sql --insecure --host=localhost:26257` |

## Examples

| File | What it shows |
| --- | --- |
| [`docker-compose.yml`](docker-compose.yml) | Engine, ports, and persistent volume. |
| [`.github/workflows/compose-check.yml`](.github/workflows/compose-check.yml) | Validates the Compose file on every push. |
| [`examples/01_schema.sql`](examples/01_schema.sql) | UUID keys, a foreign key, and a secondary index. |
| [`examples/02_queries.sql`](examples/02_queries.sql) | Seed data, an aggregation, `SHOW RANGES`, and `EXPLAIN`. |

## Exercises

1. Add a `products` table with a `JSONB` column and query a field with `->>`.
2. Run `SHOW RANGES FROM TABLE orders` and explain what a range is in one sentence.
3. Compare `EXPLAIN` and `EXPLAIN ANALYZE` for the join query.
4. Start a second node (requires a multi-node Compose file) and watch the replica count change.

## Notes and limits

- `--insecure` disables TLS and authentication. It is only appropriate for a local lab.
- The Admin UI on port 8080 shows ranges, replicas, and statement statistics.
- CockroachDB is PostgreSQL wire-compatible, so the PostgreSQL JDBC driver works.
- The pinned tag is a stable release; check the upstream release notes before upgrading.

## Run it from anywhere

This lab publishes its ports on `127.0.0.1` only. To use it from another country, do **not** open the database port to the internet. Pick one:

- **VPS + private tunnel:** run the lab on a small Ubuntu VPS, keep the port closed, and connect through WireGuard or `ssh -L`.
- **Managed service:** use a managed free tier for this engine and point the same examples at its connection string.
- **HTTP UI only:** if the engine has a web UI, put it behind Caddy with TLS and basic auth.

The shared checklist, provider map, and commands are in **[REMOTE-ACCESS.md](https://github.com/devarent/database-labs/blob/main/REMOTE-ACCESS.md)**.

## Cleanup

```bash
docker compose down -v
```

`-v` also removes the named volume, so the next start is a clean slate.

## References

- [CockroachDB documentation](https://www.cockroachlabs.com/docs/)
- [CockroachDB Docker image](https://hub.docker.com/r/cockroachdb/cockroach)
- [CockroachDB SQL reference](https://www.cockroachlabs.com/docs/stable/sql-statements)

---

<sub>Part of the <a href="https://github.com/devarent/database-labs">database-labs</a> collection: 26 database engines, one index.</sub>

## License

MIT (c) 2026 Arya Fatthurahman. See [LICENSE](LICENSE).
