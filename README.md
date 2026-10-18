# APEX starter app (APEXlang)

![License: MIT](https://img.shields.io/badge/License-MIT-informational) [![harby.dev](https://img.shields.io/badge/harby.dev-templates-C74634)](https://harby.dev/templates) ![Oracle APEX](https://img.shields.io/badge/Oracle-APEX%2026.1%2B-F80000?logo=oracle&logoColor=white) ![SQLcl](https://img.shields.io/badge/Oracle-SQLcl%2026.1.2%2B-F80000?logo=oracle&logoColor=white)

A minimal, opinionated **Git layout for a file-based Oracle APEX app** — the kind
an AI agent (Claude, Cursor) can read and edit safely, then sync back to APEX.
Companion to [Vibe-code APEX with Claude + APEXLang](https://harby.dev/learn/vibe-code-apex-apexlang-claude) on harby.dev.

This is a **scaffold**, not a pre-built application: it gives you the folder
structure, conventions, and database objects to start from. You drop your own
APEXlang export into `app/` and you're in business.

## Requirements

- **APEX 26.1 or later** — APEXlang export/import needs it.
- **SQLcl 26.1.2 or later** — older SQLcl does not know `-exptype APEXLANG`,
  `apex validate`, or `apex import -input`.

## Layout

```
.
├── app/                 # APEXlang export lives here — one folder per app, named after its alias
│   └── README.md        # how to export/import into this folder
├── database/            # schema the app depends on (version-controlled DDL)
│   ├── install.sql      # runs every table/seed in order
│   └── tables/
│       └── 01_orders.sql
├── .editorconfig
└── .gitignore
```

## Workflow

**1. Export your app to files** (SQLcl, connected as the app's parsing schema):

```sql
apex export -applicationid 100 -exptype APEXLANG -skipexportdate -dir app -force
```

SQLcl writes the app to `app/<alias>/`, named after the application alias in
lower case (alias `MY-APP` → `app/my-app/`), with `application.apx`, one `.apx`
file per page under `pages/`, and `deployments/default.json`. See
[`app/README.md`](app/README.md) for the full tree.

**2. Edit with an AI agent.** Open the repo in VS Code / Cursor and describe the
change in plain English:

```
› Add a "Status" select list to page 12 (Open, In Progress, Closed),
  default Open.
```

**3. Validate, review the diff, then import back:**

```sql
-- offline, no connection needed
apex validate -input app/my-app

-- connected as the parsing schema
apex import -input app/my-app -id 100
```

Because the app is files, every change is a reviewable `git diff` — treat AI
edits like a junior developer's pull request and read the diff before importing
to a real workspace.

> **Check the output, not the exit code.** SQLcl exits with code 0 even when
> `apex validate` or `apex import` fails. Look for `Validation successful.` and
> `Import successful.`. In scripts or CI, save the output to a log and fail if
> those lines are missing. The
> [apex-cicd-github-actions](https://github.com/Mohamedhrby/apex-cicd-github-actions)
> template does this for you.

## Database objects

`database/install.sql` creates the sample schema the starter app expects. Run it
in your APEX workspace schema (SQLcl / SQL Workshop) before importing the app:

```sql
@database/install.sql
```

## What is APEXlang?

A file-based representation of an APEX application (`.apx` files) you can edit in
your editor and sync to APEX — the thing that unlocks Git history, code review,
and AI-assisted development for APEX. It is different from the classic
`apex export -split` output, which is a tree of `.sql` install scripts.

## License

MIT © Mohamed Harby — see [LICENSE](LICENSE). Built for [harby.dev](https://harby.dev).
