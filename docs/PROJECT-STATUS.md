# PROJECT STATUS — Makalah Ceritas

**Last Update:** 2026-09-21
**Version:** v12.0 + IEEE patch (1.20.0 → 1.20.1)
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

## Recent Commits (2026-09-20 → 21)
| Hash | Task |
|---|---|
| ae855e5 | fix(rps-batch): single-column tables + cover_pih.png + config cover_file |
| 135b805 | feat(llm): multi Gemini API key rotation (auto-fallback on 429) |
| b912c26 | feat(rps-batch): LLM expand script paper v4 to v5 (OPSI C PIH) |
| 9ee3f85 | feat(rps-batch): full IEEE template + cover support |
| 4492a5d | docs(memory): final status 2026-09-20 + deferred log |
| 8a5d5cf | fix(latex): escape {} + A4/metadata/babel + narrative filter (PIH v4) |
| e279105 | feat(rps-batch): export RIS + CSL-JSON via exporters service |
| dc74996 | feat(rps-batch): wire plagiarism internal (local corpus) |
| c367f77 | docs(integrations): 11 planned integrations lengkap + roadmap |
| 0416fe8 | feat(rps-batch): wire parsers (RIS/BibTeX/CSL-JSON) ke references |

## Next (2026-09-21 → 22)
1. Submit PIH FINAL v5 (IEEE, 4186 kata) ke dosen
2. Manual: generate cover_pih.png + PPT 10 slide + NotebookLM 10 output
3. Besok: regen matkul-02 (Ulumul Hadis, template makalah/`uin`) + matkul-03 (Moderasi) + topik-05 (tunggu quota LLM reset)
4. Urgent: rotate 5 API keys (PostHog, Gemini #1, Gemini #2, Groq, Zen)
