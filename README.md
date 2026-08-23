# APEX starter app (APEXLang)

![License: MIT](https://img.shields.io/badge/License-MIT-informational) [![harby.dev](https://img.shields.io/badge/harby.dev-templates-C74634)](https://harby.dev/templates) ![Oracle APEX](https://img.shields.io/badge/Oracle-APEX%2026.1-F80000?logo=oracle&logoColor=white)

A minimal, opinionated **Git layout for a file-based Oracle APEX app** — the kind
an AI agent (Claude, Cursor) can read and edit safely, then sync back to APEX.
Companion to [Vibe-code APEX with Claude + APEXLang](https://harby.dev/learn/vibe-code-apex-apexlang-claude) on harby.dev.

This is a **scaffold**, not a pre-built application: it gives you the folder
structure, conventions, and database objects to start from. You drop your own
`apex export -split` output into `app/` and you're in business.

## Layout

```
.
├── app/                 # APEXLang (.apx) split export lives here — one app per subfolder
│   └── README.md        # how to export/import into this folder
├── database/            # schema the app depends on (version-controlled DDL)
│   ├── install.sql      # runs every table/seed in order
│   └── tables/
│       └── 01_orders.sql
├── .editorconfig
└── .gitignore
```

## Workflow

**1. Export your app to files** (from SQLcl, connected to your workspace schema):

```sql
apex export -applicationid 100 -split -dir ./app/app100
```

**2. Edit with an AI agent.** Open the repo in VS Code / Cursor and describe the
change in plain English. Tell the agent to **preserve component IDs** so the
re-import stays clean:

```
› Add a "Status" select list to page 12 (Open, In Progress, Closed),
  default Open. Keep item and region IDs stable.
```

**3. Review the diff, then import back:**

```sql
apex import -dir ./app/app100 -applicationid 100
```

Because the app is files, every change is a reviewable `git diff` — treat AI
edits like a junior developer's pull request and read the diff before importing
to a real workspace.

## Database objects

`database/install.sql` creates the sample schema the starter app expects. Run it
in your APEX workspace schema (SQLcl / SQL Workshop) before importing the app:

```sql
@database/install.sql
```

## What is APEXLang?

A file-based representation of an APEX application (`.apx` files) you can edit in
your editor and sync to APEX — the thing that unlocks Git history, code review,
and AI-assisted development for APEX.

## License

MIT © Mohamed Harby — see [LICENSE](LICENSE). Built for [harby.dev](https://harby.dev).
