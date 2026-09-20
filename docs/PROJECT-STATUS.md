# PROJECT STATUS — Makalah Ceritas

**Last Update:** 2026-09-20
**Version:** v12.0
**Status:** Production Live

## Quick Links
- [AGENTS.md](../AGENTS.md) — konteks proyek
- [MEMORY.md](../MEMORY.md) — memory lengkap
- [SECURITY-TODO.md](SECURITY-TODO.md) — rotate keys
- [CHANGELOG.md](../CHANGELOG.md) — riwayat versi

## Production
| Service | URL | Status |
|---|---|---|
| Web | https://web-taupe-pi-wnuhhjhh6s.vercel.app | ✅ |
| API | https://api2-production-1203.up.railway.app | ✅ |
| DB | Neon PostgreSQL (Singapore) | ✅ |

## Deploy Commands
```bash
# API (Railway)
cd product/apps/api
railway up --service api2 --detach

# Web (Vercel)
cd product/apps/web
vercel --prod --yes
```

## Pending
- [ ] Rotate semua API keys (SECURITY-TODO.md)
- [ ] design.md + prd.md versi user
- [ ] Onboarding 10 user
- [ ] RPS batch 42 topik sisa
