# The OCL Digital Public Good

[![DPG Badge](https://img.shields.io/badge/Verified-DPG-3333AB?logo=data:image/svg%2bxml;base64,PHN2ZyB3aWR0aD0iMzEiIGhlaWdodD0iMzMiIHZpZXdCb3g9IjAgMCAzMSAzMyIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTE0LjIwMDggMjEuMzY3OEwxMC4xNzM2IDE4LjAxMjRMMTEuNTIxOSAxNi40MDAzTDEzLjk5MjggMTguNDU5TDE5LjYyNjkgMTIuMjExMUwyMS4xOTA5IDEzLjYxNkwxNC4yMDA4IDIxLjM2NzhaTTI0LjYyNDEgOS4zNTEyN0wyNC44MDcxIDMuMDcyOTdMMTguODgxIDUuMTg2NjJMMTUuMzMxNCAtMi4zMzA4MmUtMDVMMTEuNzgyMSA1LjE4NjYyTDUuODU2MDEgMy4wNzI5N0w2LjAzOTA2IDkuMzUxMjdMMCAxMS4xMTc3TDMuODQ1MjEgMTYuMDg5NUwwIDIxLjA2MTJMNi4wMzkwNiAyMi44Mjc3TDUuODU2MDEgMjkuMTA2TDExLjc4MjEgMjYuOTkyM0wxNS4zMzE0IDMyLjE3OUwxOC44ODEgMjYuOTkyM0wyNC44MDcxIDI5LjEwNkwyNC42MjQxIDIyLjgyNzdMMzAuNjYzMSAyMS4wNjEyTDI2LjgxNzYgMTYuMDg5NUwzMC42NjMxIDExLjExNzdMMjQuNjI0MSA5LjM1MTI3WiIgZmlsbD0id2hpdGUiLz4KPC9zdmc+Cg==)](https://digitalpublicgoods.net/r/open-concept-lab)

Open Concept Lab (OCL) has been a verified digital public good since January 2025 ([DPG Registry](https://www.digitalpublicgoods.net/r/open-concept-lab) ID GID0091038). This rule says which parts of OCL make up that digital public good, which licenses they use, and how the list of them changes. It applies from the day it is published to every OCL repository, existing and new.

## The rule

1. **The OCL DPG is the open OCL product.** It is the software anyone needs to run, use and extend OCL on their own infrastructure, without an OCL Online account. It includes the OCL Terminology Service, the OCL TermBrowser, the OCL Mapper, client libraries and tools, and their documentation. The repositories that make it up are named in the [OCL DPG list](#the-ocl-dpg-list) below. A repository is part of the OCL DPG only if it is on that list.

2. **The test.** A repository belongs in the OCL DPG when it is part of that open product: someone running OCL needs it to run, use or extend OCL without OCL Online. Code that exists only to provide OCL Online's paid services does not belong in the OCL DPG.

3. **DPG repositories are open.** Every repository in the OCL DPG is public. Its code is licensed under the Mozilla Public License 2.0 (MPL 2.0) with the OCL Healthcare Disclaimer, and its documentation under the Creative Commons Attribution 4.0 International license (CC BY 4.0). Third-party code in a DPG repository keeps its own open-source license.

4. **The OCL DPG is complete on its own.** With a normal setup, the OCL DPG builds, passes its tests and provides all of its features without any component outside the OCL DPG. Administrators of an installation may restrict access on it.

5. **Optional services stay optional.** A DPG repository may include a client for an OCL Online service, such as the OCL AI Assistant, for people with an OCL Online account. The client is off until it is configured, and it uses the service's public API. No other part of the OCL DPG depends on it.

6. **Everything else follows its own terms.** Repositories that are not on the list are not part of the OCL DPG, whether public or private. Each states its own license, and a repository that states none is not licensed for reuse. OCL Online's paid services, including the OCL AI Assistant, are proprietary. Terminologies and other content published on OCL Online are licensed by their publishers, as the [Terms of Use](https://openconceptlab.org/terms-of-use) describe. This rule covers OCL's software and documentation.

7. **The OCL DPG doesn't shrink.** OCL does not move a feature of the OCL DPG into a proprietary service. A repository leaves the list only when it is retired or replaced by another DPG repository, and OCL announces that on the list at least 90 days in advance. Code that only provides OCL Online's paid services may be moved out of a DPG repository, because the OCL DPG works without it. Every version already published stays available under the license it was published under.

8. **How the list is kept.** The list is public, and each change to it is published with its date and reason. A new OCL repository says in its README, from its first commit, whether it is part of the OCL DPG, and one that is goes on the list before its first release. Every DPG repository carries its license files, the DPG badge, the `digital-public-good` topic and a README line naming it as part of the OCL DPG. Every other active public OCL repository, except forks of other projects, says in its README that it is not. OCL reviews the list every year when it renews its DPG status, and keeps its DPG Registry entry in step with the list.

9. **Who maintains it.** Open Concept Lab LLC, which owns the OCL codebase, maintains this rule and the list. Changes to the rule are published with their date. Questions go to info@openconceptlab.org.

## The OCL DPG list

| Repository | What it is | License |
|---|---|---|
| [oclapi2](https://github.com/OpenConceptLab/oclapi2) | OCL Terminology Service: the REST API and FHIR terminology service | MPL 2.0 with the OCL Healthcare Disclaimer |
| [oclweb3](https://github.com/OpenConceptLab/oclweb3) | OCL TermBrowser v3 | MPL 2.0 with the OCL Healthcare Disclaimer |
| [oclweb2](https://github.com/OpenConceptLab/oclweb2) | OCL TermBrowser v2 | MPL 2.0 with the OCL Healthcare Disclaimer |
| [oclmap](https://github.com/OpenConceptLab/oclmap) | OCL Mapper | MPL 2.0 with the OCL Healthcare Disclaimer |
| [ocl-cli](https://github.com/OpenConceptLab/ocl-cli) | Command-line client for the OCL API | MPL 2.0 with the OCL Healthcare Disclaimer |
| [ocldev](https://github.com/OpenConceptLab/ocldev) | Python library for working with OCL resources and APIs | MPL 2.0 with the OCL Healthcare Disclaimer |
| [ocl_omrs](https://github.com/OpenConceptLab/ocl_omrs) | Imports an OpenMRS concept dictionary into OCL | MPL 2.0 with the OCL Healthcare Disclaimer |
| [ocl-docs](https://github.com/OpenConceptLab/ocl-docs) | OCL documentation, published at [docs.openconceptlab.org](https://docs.openconceptlab.org) | CC BY 4.0 |
| [ocl-design-system](https://github.com/OpenConceptLab/ocl-design-system) | OCL v3 Design System for the TermBrowser and the Mapper | CC BY 4.0 for content; MPL 2.0 with the OCL Healthcare Disclaimer for code |

Every other OCL repository is not part of the OCL DPG.

## Licenses

- **MPL 2.0:** [mozilla.org/MPL/2.0](https://mozilla.org/MPL/2.0/). The OCL Healthcare Disclaimer is in each code repository's `HEALTHCARE-DISCLAIMER.md` and at [openconceptlab.org/license](https://openconceptlab.org/license).
- **CC BY 4.0:** [creativecommons.org/licenses/by/4.0](https://creativecommons.org/licenses/by/4.0/).

## Changes

| Date | Change |
|---|---|
| 2026-10-26 | Rule adopted, with nine repositories on the list. |
