# Contributing to OCL

Thanks for contributing! Here's what you need to know.

## Filing Issues

File issues on **[ocl_issues](https://github.com/OpenConceptLab/ocl_issues)** — that's our central tracker for all open-source work. Don't file issues on individual code repos unless you know it belongs there.

| Scope | Where |
|---|---|
| Bugs, features, docs (open-source) | `ocl_issues` |
| OCL Online (private) | `ocl_online` |
| Infrastructure / secrets | `oclinfrastructure` |

Add a `type/` label when you create an issue: `type/bug`, `type/feature`, `type/docs`, `type/infra`, `type/refactor`, or `type/dependency`. If you're not sure, use `type/feature` — triage will fix it.

## Commits

Reference the issue number in your commits (and use [conventional comments](https://www.conventionalcommits.org/en/v1.0.0/#summary) descriptions whenever is possible):

```
fix: cascade hierarchy view (#2301)
docs: add swagger /docs page (closes OpenConceptLab/ocl_issues#2272)
```

Use `closes #N` or `fixes #N` on the resolving commit. Use bare `#N` for partial work. Typo fixes are exempt.

## Pull Requests

Every change goes through a PR — no direct pushes to main. The PR template will prompt you for a linked issue, summary, and test plan.

Add a `type/` label to your PR. This drives release note generation.

**Who can merge:**

| Change type | Who merges | Review needed? |
|---|---|---|
| Docs, config, dependency bumps | Author (self-merge) | Automated only |
| AI-generated (`origin/ai-generated`) | Human maintainer | Yes |
| Core logic, data models, auth | Another maintainer | Recommended |

This isn't about gatekeeping — most PRs can be self-merged. The goal is visibility and an audit trail.

## Labels

We use scoped labels (`scope/name`) across all repos. The main ones you'll interact with:

- **`type/`** — what kind of work (required on issues and PRs)
- **`priority/`** — how urgent (`critical`, `high`, `medium`, `low`)
- **`component/`** — which part of OCL (`api`, `web`, `fhir`, `mapper`, etc.)

Other scopes (`signal/`, `stage/`, `origin/`) are managed by automated systems. Don't apply those manually.

## Questions?

Open an issue on [ocl_issues](https://github.com/OpenConceptLab/ocl_issues) or raise it in the team channel.
