# app/

Put your file-based (APEXlang) APEX application here — one folder per app.

Requires **APEX 26.1+** and **SQLcl 26.1.2+**. Generate it from SQLcl, connected
as the app's parsing schema:

```sql
-- 100 = your application id
apex export -applicationid 100 -exptype APEXLANG -skipexportdate -dir app -force
```

`-skipexportdate` keeps diffs clean; `-force` replaces the previous export.
SQLcl names the folder after the application alias, in lower case
(alias `MY-APP` → `app/my-app/`):

```
my-app/
├── application.apx                  # application definition
├── page-groups.apx
├── pages/
│   ├── p00000-global-page.apx
│   ├── p00001-home.apx
│   └── p09999-login.apx
├── shared-components/               # navigation, auth, LOVs, themes…
├── supporting-objects/
└── deployments/
    └── default.json                 # app id (and optionally workspace / parsing schema)
```

Commit the export so each change is a reviewable diff. Check it, then import it
back:

```sql
-- offline, no connection needed
apex validate -input app/my-app

-- connected as the parsing schema
apex import -input app/my-app -id 100
```

> SQLcl exits with code 0 even when validation or import fails. Look for
> `Validation successful.` / `Import successful.` in the output, and check for
> them explicitly in any script or CI job.
