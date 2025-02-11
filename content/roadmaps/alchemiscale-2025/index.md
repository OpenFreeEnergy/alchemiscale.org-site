---
title: 'alchemiscale roadmap 2025'
date: "2025-02-11T00:00:00-00:00"
authors: ["dotsdl"]
draft: false
---


It's 2025, and this month the project now known as **alchemiscale** celebrates its 3rd anniversary since kicking off in 2022.
We've come a long way since then, and there is much to do this year to further improve **alchemiscale**'s capabilities and user experience.

We previously published a detailed perspective on what we considered to be the **alchemiscale** project's most attractive [advancement opportunities in 2025]({{< ref "/opportunities/alchemiscale-2025" >}}). 
That document serves as an input to this roadmap, which details our plans for executing on many of those opportunities over the course of the year.

## our objectives

This year, our overall objectives are:

1. Automated `Strategy` pursuit server-side via the `Strategist` service.

2. Mechanisms for finer and more performant introspection on `Transformation` results and failures, and performant whole-`AlchemicalNetwork` result retrieval.

3. Improved compute efficiency through better saturation of compute resources, and mechanisms for autoscaling compute services on those resources based on user demand.

4. Flexible "living networks" support, including merging and copying `AlchemicalNetwork`s server-side, and prediction of `AlchemicalNetwork` computational cost.


By the end of 2025, accomplishing much of the above would make **alchemiscale** largely feature-complete as originally envisioned.
This would position us well to release **alchemiscale** [v1.0.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/14), marking a high degree of API stability and greater suitability for production environments.


## our resources

We perform **alchemiscale** development via [two-week sprints](https://github.com/orgs/OpenFreeEnergy/projects/45/views/1) within the **OpenFE** organization, with development currently led by [**Datryllic**](https://datryllic.com/).
The **OpenFE** industry-funded project currently does not allocate its developer resources directly to **alchemiscale**, so resourcing comes through the following modes:
1. Service contracts with **Datryllic** from entities that depend on **alchemiscale**, either a [**bespoke**](https://datryllic.com/services/) engagement for building specific features, or a [**plug-and-play**](https://datryllic.com/services/#plug-alchemiscale) support engagement that funds continuous overall improvement of **alchemiscale**.
2. Contributions of internal developer effort from organizations that are invested in **alchemiscale**'s future for their own operations.
3. Individual developer effort, volunteered for personal or professional reasons.

As of this writing, **Datryllic** remains the primary contributor to **alchemiscale**, with its work supported via mode (1).
We welcome contributions via the other modes in pursuing [our objectives]({{< ref "#our-objectives" >}}) over the course of the year, however!
Please reach out via our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum if you are interested in contributing with us!

## our path

Given [our current resources]({{< ref "#our-resources" >}}), a high degree of team focus will be required to deliver features aligned with [our objectives]({{< ref "#our-objectives" >}}).
Major releases will be structured according to a theme, allowing related features to be grouped together and co-developed in the same release cycle.
This also helps us to realize more tangible, coherent improvements with users more frequently.

As of this writing, our next major releases will focus on the following:

- [v0.6.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/16) : result retrieval optimizations, server-side `Task` restart policies
- [v0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/11)  : automated `Strategy` execution via `Strategist` service
- [v0.8.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/9) : living networks enablement, fast traceback retrieval, archival extracts
- [v0.9.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/17) : improved compute efficiency for parallelizable `ProtocolDAG`s

Our aim is to produce one major release approximately each quarter, prioritizing features that align with each release's overall theme in service to our objectives.
We may rebalance individual features across major releases as needed, but this is the overall principle we use to guide what is triaged into release milestones.

In service to objective (3) **Datryllic** will also allocate development effort to [`alchemiscale-k8s`](https://github.com/datryllic/alchemiscale-k8s), in particular designing and implementing an approach to efficient compute service autoscaling on [Kubernetes](https://kubernetes.io/) clusters.
The business logic of this approach may end up being reusable for developing an autoscaling approach for HPC and other platforms, but this is yet to be seen.

**Datryllic** is also committed to advancing use of [Folding@Home](https://foldingathome.org/) with **alchemiscale** via [`alchemiscale-fah`](https://github.com/OpenFreeEnergy/alchemiscale-fah), unlocking citizen-science, "planetary-scale" compute for projects that can make use of it.

## onward

There's quite a lot to do this year, and plenty of opportunities for new folks to get involved.
If you are interested in trying **alchemiscale** out, or if you already have and want to offer ideas for improvement, please reach out!
Posting in our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum is the best way to get started!
