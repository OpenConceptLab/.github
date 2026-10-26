# OCL repository categories

Open Concept Lab (OCL) sorts its repositories into four categories. This page defines them and lists the public repositories in each. The first category, the OCL DPG, is governed by the [OCL Digital Public Good rule](DIGITAL-PUBLIC-GOOD.md).

## The categories

1. **OCL DPG.** The open OCL product: the repositories on the [OCL DPG list](DIGITAL-PUBLIC-GOOD.md#the-ocl-dpg-list). They are public. Their code is licensed under the Mozilla Public License 2.0 (MPL 2.0) with the OCL Healthcare Disclaimer, and their documentation under CC BY 4.0. The DPG rule says how the list changes.

2. **OCL Open Source.** OCL's other public repositories that state an open-source or open content license. Each is licensed as it states. They are not part of the OCL DPG.

3. **OCL Online Shared Services.** Private repositories and services that run or support OCL's free community services and the OCL DPG, such as community infrastructure and hosting, deployment and operations, the community website, and the OCL AI Assistant service.

4. **OCL Online Commercial Services.** Code and services that exist only to provide OCL Online's paid plans, such as plans and entitlements, plan allowances and limits, billing and payments, pricing, and upgrade prompts. This includes the OCL AI Assistant's plan allowances, limits and billing.

The first three categories follow where a repository lives and how it is licensed. The fourth follows what code does: code that exists only to provide paid plans is in OCL Online Commercial Services wherever it sits, and the DPG rule lets OCL move it out of a DPG repository.

Private repositories are not listed on this page. OCL shares their names and categories with partners on request, in confidence.

## The lists

**OCL DPG:** see the [OCL DPG list](DIGITAL-PUBLIC-GOOD.md#the-ocl-dpg-list).

**OCL Open Source:**

| Repository | What it is | License |
|---|---|---|
| [.github](https://github.com/OpenConceptLab/.github) | OCL's GitHub organization profile, templates and these pages | MPL 2.0 |
| [ocl-fhir-ig](https://github.com/OpenConceptLab/ocl-fhir-ig) | Generic FHIR implementation guide for OCL | MPL 2.0 |
| [oclazure](https://github.com/OpenConceptLab/oclazure) | Terraform deployment of OCL on Azure | MPL 2.0 |
| [oclci](https://github.com/OpenConceptLab/oclci) | CI and deployment scripts for OCL's hosted service | MPL 2.0 |

**OCL Online Shared Services and OCL Online Commercial Services:** private, so not listed.

## Repositories outside the categories

- **Public repositories that state no license.** They are public to read but not licensed for reuse. OCL may license any of them, which moves it into OCL Open Source.
  - [fhir_imports](https://github.com/OpenConceptLab/fhir_imports): FHIR resources from other publishers, which keep their sources' licenses.
  - [ocl_issues](https://github.com/OpenConceptLab/ocl_issues): the issue tracker for OCL's repositories.
  - [ocl-kb](https://github.com/OpenConceptLab/ocl-kb)
  - [ocl-mcp-client](https://github.com/OpenConceptLab/ocl-mcp-client)
  - [ocl-scispacy-match](https://github.com/OpenConceptLab/ocl-scispacy-match)
  - [oclsso](https://github.com/OpenConceptLab/oclsso)
- **Forks of other projects** keep their upstream licenses: [errbit](https://github.com/OpenConceptLab/errbit) (MIT) and [org.hl7.fhir.validator-wrapper](https://github.com/OpenConceptLab/org.hl7.fhir.validator-wrapper) (Apache 2.0).
- **[Archived repositories](https://github.com/orgs/OpenConceptLab/repositories?q=archived%3Atrue)** are read-only, and each keeps any license it states.

## How this page is kept

A new OCL repository gets its category when it is created. OCL updates this page whenever a public repository is added, licensed, archived or changes category, and publishes each change below with its date. Open Concept Lab LLC maintains this page. Questions go to info@openconceptlab.org.

## Changes

| Date | Change |
|---|---|
| 2026-10-26 | Categories defined. |
