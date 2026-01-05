---
title: "advancements in alchemiscale v0.7"
date: "2025-12-17T00:00:00-00:00"
authors: ["dotsdl"]
tags: ["release"]
showTableOfContents: false
draft: false
---

In October of this year we released **alchemiscale** [v0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.0), and followed this up with [v0.7.1](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.1) and [v0.7.2](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.2).
We wanted to take a moment to highlight these releases, and the improvements they bring for users!


## v0.7.0

As a major release, [v0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.0) introduced two significant features that advance **alchemiscale**'s capabilities for automated, large-scale execution.

First, this release introduced the **`ComputeManager`** base class, which lays the foundation for upcoming compute autoscaling implementations.
This abstraction enables **alchemiscale** to dynamically scale compute resources across different platforms, including HPC clusters and Kubernetes environments.
With this foundation in place, compute services can now be managed more intelligently, responding to workload demands without manual intervention.
Keep an eye out for [**alchemiscale-k8s**](https://github.com/OpenFreeEnergy/alchemiscale-k8s), which leverages this new capability!

Second, we added the **`Strategist`** service, which enables automated execution of `Strategy` objects for `AlchemicalNetwork`s.
A `Strategy` proposes where to apply additional compute given the set of results currently available for a given `AlchemicalNetwork`.
Users can now submit a `Strategy` alongside their `AlchemicalNetwork`s, and the `Strategist` service will periodically apply it server-side to adaptively sample `Transformation`s until the `Strategy`'s stop thresholds are satisfied.

This release also delivered substantial performance improvements for `AlchemicalNetwork` submission and retrieval via the `AlchemiscaleClient`.
We optimized how `AlchemicalNetwork` objects are submitted to the state store, and implemented direct `KeyedChain` retrieval from Neo4j, making these operations notably faster for large networks.

Finally, [v0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.0) resolved deprecation issues affecting Python 3.12+ (specifically `utcnow`) and upgraded to Pydantic v2, ensuring **alchemiscale** remains compatible with modern Python environments.


## v0.7.1

Release [v0.7.1](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.1) was a bugfix release addressing issues found in v0.7.0, while also improving developer experience.

A critical bug affecting the `Strategist` service startup process was resolved, ensuring the service initializes correctly in deployed environments.
We also added the ability for compute managers to specify service names via command-line arguments, giving operators more flexibility when deploying compute services across different environments.

On the development side, we implemented parallel Neo4j container testing, significantly improving test suite performance.
This makes it faster for contributors to run the full test suite during development.
We also enhanced our developer documentation with guidance on Docker setup for integration testing, making it easier for new contributors to get started.


## v0.7.2

Release [v0.7.2](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.2) was an incremental release focused on bugfixes and improvements in support of autoscaling implementations, such as that featured in [**alchemiscale-k8s**](https://github.com/OpenFreeEnergy/alchemiscale-k8s).

Key improvements included updating Traefik to v2.11 for better routing performance and security, fixing scope-related issues in the compute manager, and making adjustments to `ComputeManagerID` validation.
We also added the `Strategist` service to the docker-compose deployment configuration, making it easier to deploy complete **alchemiscale** instances with automated strategy execution capabilities.


## what's next?

We are currently hard at work on the major new features coming in [v0.8.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/9), so keep a look out for this release in the coming months!

If you are interested in trying **alchemiscale** out, or if you already have and want to offer ideas for improvement, please reach out!
Posting in our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum is the best way to get started!
