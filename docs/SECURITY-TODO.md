# SECURITY TODO — API Keys Ter-expose

> ⚠️ Keys berikut ter-paste di chat publik. ROTATE setelah setup final.

## Urgent — Rotate Sekarang
- [ ] **PostHog** — https://us.posthog.com/project/617275/settings/project
- [ ] **Gemini** — https://aistudio.google.com/apikey
- [ ] **Groq** — https://console.groq.com/keys
- [ ] **OpenRouter** — https://openrouter.ai/keys
- [ ] **Zen** — https://opencode.ai/keys

## Setelah Rotate
- [ ] Update `.env.production` di Default Project
- [ ] Update Railway env: `railway variables set <KEY>=<new>`
- [ ] Update Vercel env: `vercel env add <KEY> production`
- [ ] Redeploy: `railway up --service api2` + `vercel --prod`

## Best Practices
- Jangan commit `.env*` (sudah gitignored)
- Jangan paste key di chat publik (Slack, Discord, ChatGPT, dll)
- Simpan di password manager (Bitwarden, 1Password)
