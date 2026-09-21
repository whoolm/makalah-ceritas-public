# Memory System Schema

## Struktur

```
.memory/
├── README.md                 # Cara pakai
├── progress.json             # Progress saat ini (per-project)
├── tasks.json                # Daftar semua task (done/stopped/next)
├── timeline.jsonl            # Log kronologis (append-only)
├── cross-ref.json            # Link ke PRD, commits, docs
├── sessions/                 # Per-session log
│   ├── 2026-09-21-morning.json
│   └── ...
└── archive/                  # Task lama (>30 hari)
```

## progress.json

```json
{
  "currentFocus": "Mega Prompt F — Memory System",
  "lastUpdated": "2026-09-21T07:00:00Z",
  "phase": "in-progress",
  "blockers": [],
  "nextActions": [
    "Fase 2 design schema",
    "Fase 3 implement module"
  ],
  "recentlyDone": [
    "Mega Prompt E — Personal Intelligence",
    "Task 1-21"
  ]
}
```

## tasks.json

```json
{
  "tasks": [
    {
      "id": "E",
      "title": "Personal Intelligence System",
      "status": "done",
      "startedAt": "2026-09-21T05:00:00Z",
      "completedAt": "2026-09-21T06:30:00Z",
      "commits": ["abc123"],
      "prdRef": "PRD §7 Personalization",
      "artifacts": ["docs/PERSONAL-INTELLIGENCE.md"]
    },
    {
      "id": "F",
      "title": "Memory System",
      "status": "in-progress",
      "startedAt": "2026-09-21T07:00:00Z",
      "commits": [],
      "prdRef": "PRD §8 Memory"
    },
    {
      "id": "A",
      "title": "Regen Moderasi",
      "status": "next",
      "plannedFor": "2026-09-22T00:00:00Z"
    }
  ]
}
```

## timeline.jsonl (append-only, 1 JSON per baris)

```
{"ts":"2026-09-21T05:00:00Z","type":"task.start","taskId":"E","note":"Mega Prompt E"}
{"ts":"2026-09-21T06:30:00Z","type":"task.done","taskId":"E","commits":["abc123"]}
{"ts":"2026-09-21T07:00:00Z","type":"task.start","taskId":"F","note":"Mega Prompt F"}
```

Event types: `task.add`, `task.update`, `task.start`, `task.done`, `task.stop`,
`task.block`, `task.defer`, `generate.start`, `generate.done`, `generate.error`,
`session.start`, `session.end`, `progress.update`.

## cross-ref.json

```json
{
  "prdSections": {
    "7": "Personalization",
    "8": "Memory System"
  },
  "commitMap": {
    "E": ["abc123", "def456"],
    "F": []
  },
  "docMap": {
    "E": ["docs/PERSONAL-INTELLIGENCE.md"],
    "F": ["docs/MEMORY-SCHEMA.md"]
  },
  "featureMap": {
    "personal-intelligence": {"phase": "E", "status": "done"},
    "memory-system": {"phase": "F", "status": "in-progress"}
  }
}
```

## Status enum

- `next` — akan dikerjakan
- `in-progress` — sedang
- `done` — selesai
- `stopped` — dihentikan (dengan alasan)
- `blocked` — terhalang (dengan blocker)
- `deferred` — ditunda
- `archived` — >30 hari, dipindah ke archive/

## Aturan

1. `timeline.jsonl` append-only — jangan edit baris lama, tambah baris baru.
2. Setiap transisi status task WAJIB log ke timeline.
3. `progress.json.lastUpdated` di-set otomatis oleh `writeProgress()`.
4. Task `archived` dipindah ke `.memory/archive/` setelah >30 hari selesai.
5. `.memory/` di-commit ke git (history), JANGAN di-gitignore.
