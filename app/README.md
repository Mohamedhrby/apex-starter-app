# app/

Put your file-based APEX application here — one subfolder per app.

Generate it from SQLcl, connected to your APEX workspace schema:

```sql
-- 100 = your application id
apex export -applicationid 100 -split -dir ./app/app100
```

That produces a tree like:

```
app100/
├── install.sql                      # imports the whole application
├── application/
│   ├── create_application.sql
│   ├── set_environment.sql
│   ├── shared_components/           # navigation, auth, LOVs, templates…
│   └── pages/
│       ├── page_00001.sql           # Home
│       └── page_00101.sql           # Login
└── ...
```

Commit the split export so each change is a reviewable diff. Import it back with:

```sql
apex import -dir ./app/app100 -applicationid 100
```

> Keep component IDs stable across edits — it keeps import/sync clean and avoids
> duplicate components.
