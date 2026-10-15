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

Reference the issue in your commits, and use [Conventional Commits](https://www.conventionalcommits.org/en/v1.0.0/#summary) where you can:

```
fix: cascade hierarchy view (OpenConceptLab/ocl_issues#2301)
docs: add swagger /docs page (closes OpenConceptLab/ocl_issues#2272)
```

Use `closes` or `fixes` on the resolving commit, and the reference alone for partial work. Always write the full `OpenConceptLab/ocl_issues#N`: a bare `#N` points at the repo the commit lands in. Typo fixes don't need an issue.

Commit as yourself, with an email linked to your GitHub account, so the work counts as yours. If an AI agent writes the code, credit it with a `Co-authored-by:` line instead of committing from its account.

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

## Contributing from outside the team

You don't need to join the org to contribute.

1. Comment on the `ocl_issues` issue you're taking on, or file one. Commenting also lets us assign the issue to you.
2. Fork the repo, create a branch and open a PR from your fork against the default branch, linking the issue.
3. A maintainer adds the labels, reviews and merges. CI on your first PR may wait for a maintainer to approve it.

We assign each issue to whoever did the work, so the credit is on record. If you contribute regularly, we'll invite you to the `contributors` team.

## Labels

We use scoped labels (`scope/name`) across all repos. The main ones you'll interact with:

- **`type/`** — what kind of work (required on issues and PRs)
- **`priority/`** — how urgent (`critical`, `high`, `medium`, `low`)
- **`component/`** — which part of OCL (`api`, `web`, `fhir`, `mapper`, etc.)

Other scopes (`signal/`, `stage/`, `origin/`) are managed by automated systems. Don't apply those manually.

## Questions?

Open an issue on [ocl_issues](https://github.com/OpenConceptLab/ocl_issues) or raise it in the team channel.
