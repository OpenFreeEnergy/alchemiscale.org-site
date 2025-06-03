---
title: ""
description: ""
---

{{< figure src="/img/alchemiscale-logo.png" title="alchemiscale logo" >}}

## scalable alchemistry with Open Free Energy

**alchemiscale** is a distributed execution system for alchemical networks, and is part of the [Open Free Energy (OpenFE)](https://openfree.energy/) ecosystem.
It is suitable for utilizing multiple compute resources, such as HPC clusters, Kubernetes clusters, individual hosts, Folding@Home work servers, etc., to support large campaigns requiring high-throughput.

**alchemiscale** is fully open source under the permissive **MIT license**, allowing users to scale it as far as their infrastructure allows.


## who uses **alchemiscale**?

**alchemiscale** is used today by several organizations, including but not limited to:
- [Open Force Field Consortium](https://openforcefield.org/) : benchmarking of new molecular mechanics force fields via protein-ligand binding free energy calculations
- [Open Free Energy Consortium](https://openfree.energy/) : methods development for alchemical network definition and execution, including atom mapping and scoring, network planning, and alchemical protocols
- [ASAP Discovery](https://asapdiscovery.org/) : fast and accurate binding affinity predictions supporting open science + open data antiviral discovery programs targeting viruses of pandemic potential

From April 2023 through April 2024, these organizations collectively performed over half a million GPU-hours of alchemical free energy calculations, leveraging compute across multiple clusters and orchestrated via a single **alchemiscale** instance.


## who develops **alchemiscale**?

**alchemiscale** began as a joint project between the [Open Force Field Consortium (OpenFF)](https://openforcefield.org/), [Open Free Energy Consortium (OpenFE)](https://openfree.energy/), and the [Chodera Lab](https://www.choderalab.org/), with coordination and development led by [Datryllic](https://datryllic.com/).
The project was co-developed alongside the [core OpenFE data model](https://github.com/OpenFreeEnergy/gufe), with the original objective to harness [Folding@Home](https://foldingathome.org/) for performing large-scale campaigns of protein-ligand binding free energy calculations. 
The project's scope was expanded to take advantage of a broader range of general-purpose compute, including HPC, Kubernetes clusters, and individual workstations/servers.

**alchemiscale** advancement continues via an [OpenFE](https://openfree.energy/) working group led by [Datryllic](https://datryllic.com/).
Development and coordination occurs primarily via [GitHub](https://github.com/OpenFreeEnergy/alchemiscale), with the working group meeting every two weeks for discussion and decision-making.
Notes from those meetings can be found publicly [here](https://github.com/OpenFreeEnergy/alchemiscale/discussions/categories/dev-group-meeting-notes).


## how to get started?

Interested in deploying and applying **alchemiscale** to your research or business problems?
Check out our [documentation](https://docs.alchemiscale.org)!
- the [Deployment](https://docs.alchemiscale.org/en/latest/deployment.html) and [Operations](https://docs.alchemiscale.org/en/latest/operations.html) guides should help you get up and running with a working **alchemiscale** instance
- the [User Guide](https://docs.alchemiscale.org/en/latest/user_guide.html) offers general details on how to make use of your instance
- the [Tutorials](https://docs.alchemiscale.org/en/latest/tutorials/index.html) give specific use case examples that you can craft to your own needs

If you encounter problems or have questions, drop us a message in our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum on GitHub.
Our community can likely point you in the right direction quickly!

If you're looking for **direct support**, such as help deploying to unique infrastructure, live working sessions to troubleshoot issues, or even fully-managed service for your **alchemiscale** instance(s), [Datryllic](https://datryllic.com) offers such support as a [plug-and-play](https://datryllic.com/services/#plug-alchemiscale) service.


## how to contribute?

Are you looking for ways to help advance **alchemiscale**?
- if you're a developer, feel free to [introduce yourself](https://github.com/OpenFreeEnergy/alchemiscale/discussions/categories/new-contributors) and your interests, and we can help get you started
- if you're a user, you can help us greatly by helping other users with their questions on our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum

Also check out our [Opportunities]({{< ref "/opportunities" >}}) page for where you might be able to apply impactful effort,
or our [Advancements]({{< ref "/advancements" >}}) page for news on happenings within the project, including ways to get involved!
