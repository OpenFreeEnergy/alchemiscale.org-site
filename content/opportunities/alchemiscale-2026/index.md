---
title: 'advancement opportunities in 2026-2027'
date: "2026-04-10T00:00:00-00:00"
authors: ["dotsdl"]
draft: true
---

We previously published a detailed perspective on what we considered to be the **alchemiscale** project's most attractive [advancement opportunities in 2025]({{< ref "/opportunities/alchemiscale-2025" >}}),
with our [alchemiscale roadmap 2025]({{< ref "/roadmaps/alchemiscale-2025" >}}) setting us out on a path that would allow us to achieve many of these given our available resources.

This year, in an effort to synchronize with the OpenFE roadmap calendar (which begins and ends in May), we are now publshing a new perspective on where we can take the **alchemiscale** project over the course of the coming year, given how far we've come and what is currently in development.
Based on feedback from our [2025 user survey](https://github.com/OpenFreeEnergy/alchemiscale/discussions/452), we've identified key areas where users desire improvements to make **alchemiscale** easier to use and deploy as we work toward a v1.0 release.

If you have any questions on the content, would like to get involved in development, or would like to sponsor any of these advancements, get in touch on our [Discussions thread](https://github.com/OpenFreeEnergy/alchemiscale/discussions/)!


## where we are

In 2025, we delivered significant advancements to **alchemiscale** across two major release series:

- [0.6.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.0) : result retrieval optimizations and automated failure handling
    - **Task restart policies** allowing automated restarts for failed `Task`s based on error patterns
    - **Client-side result caching** improving performance for repeated calls to commonly-used results
    - **At-rest `ProtocolDAGResult` compression** using `zstd`, significantly reducing storage requirements
    - **`KeyedChain` representation** for more space-efficient `ProtocolDAGResult` serialization 
- [0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.7.0) : automated execution and autoscaling foundations
    - **ComputeManager base class** enabling compute autoscaling implementations across platforms, such as HPC and Kubernetes
    - **Strategist service** for automated compute allocation across the `Transformation`s in an `AlchemicalNetwork`
    - **Substantial performance improvements** for `AlchemicalNetwork` submission and retrieval using `KeyedChain`s
    - **Python 3.12+ and Pydantic v2 compatibility** enabling access to advancments within the broader OpenFE ecosystem

These releases delivered on key priorities from our [2025 roadmap]({{< ref "/roadmaps/alchemiscale-2025" >}}), particularly around result handling efficiency and automated execution capabilities.
We also deployed compute services that make use of ['planetary scale' compute via Folding@Home]({{< ref "/advancements/folding-at-home-2025" >}}), greatly enhancing our compute throughput capabilities for open science efforts.

We are currently focused on making **alchemiscale** even more of a pleasure to use based on direct user feedback, with emphasis on observability, introspection, and user experience improvements.

The next major releases will focus on these areas:

- [0.8.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/9) : compute introspection and user experience
- [0.9.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/17) : compute efficiency and throughput
- [1.0.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/14) : deployment and operational improvements, API-breaking changes for v1.x forward stability


## where we can go next

Over the course of 2026-2027, our focus shifts toward making **alchemiscale** more easily deployable and usable for mission-critical work.
Our goal remains for **alchemiscale** to become the *de facto* standard execution system for high-throughput alchemical free energy calculations, enabling both industry and academia to perform their work in ways previously impossible or cost-prohibitive.

Based on user feedback and operational experience, we've identified key opportunities for advancement.
Many of these directly address pain points raised in our user survey, with emphasis on observability, introspection, and reducing barriers to easy use:

1. [**compute introspection**]({{< ref "#compute-introspection" >}})
2. [**visualization and observability**]({{< ref "#visualization-and-observability" >}})
3. [**scalability**]({{< ref "#scalability" >}})
4. [**compute efficiency**]({{< ref "#compute-efficiency" >}})
5. [**operations and user experience**]({{< ref "#operations-and-user-experience" >}})


Do any of these speak to your needs?
Is one of these blocking your use of **alchemiscale** today?
Get in touch on our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum!
We'd love to hear about your needs and how our development activity can help **alchemiscale** to meet them.

Are you a developer interested in contributing to **alchemiscale**?
If any of these areas sound appealing to you, your help is more than welcome!
Get in touch on our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum, and we'd be happy to help get you started.


### compute introspection

**Our user survey identified compute introspection as the highest priority area.**
Users need access to simulation trajectories, per-replicate results, hardware provenance, and the ability to extend simulations.

**alchemiscale** by design abstracts away the compute resources used to evaluate the `Transformation`s within an `AlchemicalNetwork`.
However, when problems occur with `Protocol` execution, or when users need to understand what's happening at a deeper level, they currently have limited mechanisms for introspecting compute-side execution.

There are several ways we could provide better introspection, all of which are independent but complementary to each other.


#### result file retention and retrieval

A long-standing pain point for users is the inability to examine any file outputs from `ProtocolDAG`s that execute on remote compute,
as these are not preserved by **alchemiscale**.
A challenge with supporting result file retention and retrieval is the potentially unbounded size of result files produced by a given `Protocol`,
with some `Protocol`s routinely producing files 10s of GiB in size with default settings choices.
If **alchemiscale** is to support retaining these files and making them available to users via the `AlchemiscaleClient`, the approach taken must put sane constraints on what is preserved and exposed.

One approach that could work well is implemented in [gufe#186](https://github.com/OpenFreeEnergy/gufe/pull/186).
This involves adding a third class of storage to the `Protocol` system, `permanent`, that `Protocol` authors can use for file outputs they would like preserved by the execution system.
This allows `scratch` and `shared` storage to continue to persist over the life of individual `ProtocolUnit`s and the `ProtocolDAG`, respectively, which may require much larger files to be produced during simulation runs.
It also gives a very clear signal to the execution system what should be preserved post-`ProtocolDAG` execution, requiring no heuristics or guessing.

If this becomes the accepted approach in **gufe**, then **alchemiscale** could support it rather easily.
Compute services would upload all files in `permanent` to the object store after a `ProtocolDAG` completes (or fails),
and the `AlchemiscaleClient` would expose methods for file listing and retrieval given a `Task`/`ProtocolDAGResult` `ScopedKey`.
Optimizations for retrieval via presigned URL ([alchemiscale#45](https://github.com/OpenFreeEnergy/alchemiscale/issues/45)) would help to make this performant.
The server can also be configured with limits on the size of individual files it will accept from a compute service, as well as the aggregate size of files in `permanent` prior to upload, to avoid unbounded storage requirements due to user settings choices.

**Multiple users requested trajectory retrieval as a top priority.**
Being able to retrieve and analyze simulation trajectories would enable visualization, debugging, and quality control of calculations.

This could be delivered as part of the result file retention system (see below), with trajectories stored in the `permanent` storage class and made available for download via the `AlchemiscaleClient`.
Though support for extending simulations is in principle already present in **alchemiscale**, it is limited by the lack of result file retention.

See [2025 opportunities: result file retention and retrieval]({{< ref "/opportunities/alchemiscale-2025#result-file-retention-and-retrieval" >}}) for details on this proposed feature.


#### per-replicate results

**Users need individual replicate data, not just mean predictions.**
This is essential for quality control and debugging, allowing users to identify outlier replicates or systematic issues in their calculations.

The `AlchemiscaleClient` should expose methods to retrieve individual replicate `ProtocolUnitResult`s alongside the aggregated `ProtocolDAGResult`, giving users full visibility into the variance across replicates.

See [alchemiscale#474](https://github.com/OpenFreeEnergy/alchemiscale/issues/474) for more information.


#### host provenance

**User survey feedback specifically requested hardware and software provenance tracking.**
Users need to understand performance across different GPU types and track software versions for reproducibility.

Capturing and preserving hardware details (GPU model, driver version, CUDA version) and software information (OpenMM version, force field versions, Python version) from the host on which a `ProtocolDAG` was executed would enable:
- performance measurement and comparison across different compute resources
- debugging hardware-specific issues
- reproducibility tracking for scientific publications
- throughput and usage metrics across different compute resources

See [alchemiscale#106](https://github.com/OpenFreeEnergy/alchemiscale/issues/106) for more information.


#### stdout, stderr retention

See [2025 opportunities: stdout, stderr retention]({{< ref "/opportunities/alchemiscale-2025#stdout-stderr-retention" >}}) for details on this proposed feature, or [alchemiscale#295](https://github.com/OpenFreeEnergy/alchemiscale/issues/295) for more information.


### visualization and observability

**User survey feedback highlighted "low task observability" as a major pain point.**
Users need better visibility into what **alchemiscale** is doing, from high-level network progress to detailed task status tracking.

**alchemiscale** features a powerful Python client that enables users to submit `AlchemicalNetwork`s, action and prioritize `Transformation`s for compute, and pull results as they become available.
However, rich visualization of the state of **alchemiscale** and its calculations is not something the client will ever be capable of, given its nature as a simple HTTP interface.

Administrators are even worse-off currently, as managing users on an **alchemiscale** instance requires execution of CLI commands against the server, which is often awkward and tedious. Tracking compute throughput also requires direct [Cypher](https://en.wikipedia.org/wiki/Cypher_(query_language)) queries on the Neo4j database backend, requiring knowledge of Cypher to do this effectively, while also presenting the risk of destructive actions that could put the system in an unrecoverable, inconsistent state.

To address these shortcomings, deployable web UIs that provide missing functionality for users and admin alike could be developed, offering alternative ways to interact with an **alchemiscale** deployment.


#### user-facing visualization and introspection UI

A user-facing web UI that allows users to do at least the following would be of high value:
1. visually represent `AlchemicalNetwork`s in a performant, informative, and interactive way
2. graphically illustrate degree of `AlchemicalNetwork` results coverage, for example by color coding `Transformation`s based on `Task` status counts
3. **task completion tracking** - show completion percentage, restart patterns, and current status for all tasks
4. `Transformation` result estimates, lazily computed and cached
5. detailed `Task` compute status and history
6. **storage consumption metrics** - visibility into S3 space usage per task and network

This same web UI could later be extended to allow users more than just read-only operations like those above, such as:
1. creating new `Task`s, as well as the ability to:
	- set `Task` status
	- set `Task` priority
	- set actioned `weight`
	- allow selection of multiple `Task`s at once to do the above in bulk
2. adding or altering the execution `Strategy`(s) applied to a given `AlchemicalNetwork`
3. changing the `state` of an `AlchemicalNetwork`
4. submitting serialized `AlchemicalNetwork`s produced with e.g. the `openfe` CLI

This is an area where we could use substantial help.
None of our current core developers are experienced in web UI development, and though building a read-only UI/dashboard might be possible for us using frameworks like [Plotly Dash](http://dash.plotly.com) or [Streamlit](https://streamlit.io), building a more full-featured UI will likely be more involved and require more expertise.


#### admin-facing management UI

See [2025 opportunities: admin-facing management UI]({{< ref "/opportunities/alchemiscale-2025#admin-facing-management-ui" >}}) for details on administrative web interface needs.


### scalability

**alchemiscale** can currently orchestrate compute for hundreds of `AlchemicalNetwork`s at once, each with thousands of `Transformation`s.
However, as these capabilities enable users to make heavier use of alchemical free energy calculations (FECs) at increasing scales, new barriers have emerged for efficiently analyzing results, provisioning sufficient compute, and dynamically managing that compute.


#### analysis bottlenecks

Users of `alchemiscale.org`, in particular **ASAP Discovery**, have noted that as their `AlchemicalNetwork`s grow larger in size, it becomes increasingly painful to pull results for whole-network analyses, such as MLE estimators featured in `cinnabar`.

While we've made significant progress with client-side caching and result compression in v0.6, several additional optimizations could further improve the user experience for analysis activity:
1. pre-signed URL `ProtocolDAGResult` retrieval : [alchemiscale#45](https://github.com/OpenFreeEnergy/alchemiscale/issues/45)
2. server-side `ProtocolResult` assembly
3. automated online estimates for `Transformation`s, whole-network estimators
4. easy creation of archival extracts for `AlchemicalNetwork`s and their results : [alchemiscale#246](https://github.com/OpenFreeEnergy/alchemiscale/issues/246)


#### Folding@Home Protocols

See [2025 opportunities: Folding@Home Protocols]({{< ref "/opportunities/alchemiscale-2025#foldinghome-protocols" >}}) for details on expanding Folding@Home protocol support.


#### autoscaling compute

With the `ComputeManager` base class introduced in v0.7.0, we now have the foundation for intelligent autoscaling across different platforms.
Building on this foundation, [**alchemiscale-k8s**](https://github.com/OpenFreeEnergy/alchemiscale-k8s) is now available as a working Kubernetes autoscaling implementation, providing intelligent scaling of compute resources based on **alchemiscale** task demand.

Remaining autoscaling opportunities include:
- **`alchemiscale-hpc`** for autoscaling on HPC clusters with queueing systems (SLURM, LSF, PBS)
- **`alchemiscale-metascale`** for meta-autoscaling with policies across multiple compute backends, enabling "baseload" compute on owned resources and "burst" compute on cloud resources

See [2025 opportunities: autoscaling compute]({{< ref "/opportunities/alchemiscale-2025#autoscaling-compute" >}}) for full details on autoscaling approaches.


### compute efficiency

Complementary to [**scalability**]({{< ref "#scalability" >}}), there are several areas in which we may be able to make better use of the compute we are already using, requiring less need to scale up or out to deliver the same result throughput.


#### simulation continuation and extension

**Critical for longer simulations and expensive protocols.**
Users need the ability to extend simulations that haven't converged or require longer sampling, particularly for:
- charge-changing transformations
- expensive protocols like SepTop and ABFE
- calculations that show poor convergence in initial runs

This requires enhancements to both **gufe** and **alchemiscale** to support checkpoint-based continuation, where a new `Task` can be created that continues from where a previous one left off.


#### parallel execution of `ProtocolDAG`s for GPU saturation

See [2025 opportunities: parallel execution of ProtocolDAGs for GPU saturation]({{< ref "/opportunities/alchemiscale-2025#parallel-execution-of-protocoldags-for-gpu-saturation" >}}) for details on this performance optimization.


#### immediate `Task` cancellation on a compute service when not actioned anywhere

See [2025 opportunities: immediate Task cancellation on a compute service when not actioned anywhere]({{< ref "/opportunities/alchemiscale-2025#immediate-task-cancellation-on-a-compute-service-when-not-actioned-anywhere" >}}) for details on this efficiency improvement.


#### task timeout detection and handling
<!-- add issue and expound -->

**User survey feedback identified tasks stuck in "Running" phase as a pain point.**
Sometimes jobs get stuck without properly failing, requiring manual intervention.

Implementing automatic detection of stalled tasks and either restarting them or marking them as failed would improve the user experience and prevent compute waste.


#### additional `Strategy` implementations

See [2025 opportunities: additional Strategy implementations]({{< ref "/opportunities/alchemiscale-2025#additional-strategy-implementations" >}}) for details on expanding the portfolio of adaptive sampling strategies.


#### `Strategy` stacking

With the `Strategist` service delivered in v0.7.0, we now have working automated `Strategy` execution.
The next step is enabling more sophisticated strategy combinations through stacking.

See [2025 opportunities: Strategy stacking]({{< ref "/opportunities/alchemiscale-2025#strategy-stacking" >}}) for details on how multiple strategies could work together.


### operations and user experience

**User survey feedback emphasized the need to shift "from tool to product" with better UX and lower barriers to entry.**

In addition to the other areas detailed above, there are several key areas that could significantly enhance **alchemiscale**'s operations model and user experience.


#### installation simplification

**User survey identified installation complexity as a major barrier to entry.**
New users struggle with the deployment process, limiting **alchemiscale** adoption.

Providing simplified deployment options could include:
- pre-built Docker Compose configurations for common scenarios
- Kubernetes Helm charts for cloud deployments
- automated setup scripts that handle common configuration tasks
- improved documentation with step-by-step guides for different deployment scenarios
- example configurations for common use cases


#### experimental stack support

**Users need a way to test upcoming OpenFE and OpenMM versions before committing to upgrades.**

An "experimental" deployment configuration with reduced pre-deployment validation would allow users to:
- test new protocol implementations as they're developed
- validate upcoming OpenFE releases against their workloads
- experiment with cutting-edge OpenMM features
- provide early feedback on new features before they're officially released

This would accelerate the feedback loop between users and developers.

#### tooling for performing data model migrations

See [2025 opportunities: tooling for performing data model migrations]({{< ref "/opportunities/alchemiscale-2025#tooling-for-performing-data-model-migrations" >}}) for details on this operational requirement.

#### admin client/API for remote user management

See [2025 opportunities: admin client/API for remote user management]({{< ref "/opportunities/alchemiscale-2025#admin-clientapi-for-remote-user-management" >}}) for details on this operational improvement.


#### user read, write, domain permissions

See [2025 opportunities: user read, write, domain permissions]({{< ref "/opportunities/alchemiscale-2025#user-read-write-domain-permissions" >}}) for details on granular permission controls.


## how do we do it?

All of this sounds amazing!
How do we do it?

**alchemiscale** development is coordinated via [two-week sprints](https://github.com/orgs/OpenFreeEnergy/projects/45/views/1) within the **OpenFE** organization, with development currently led by [**Datryllic**](https://datryllic.com/).
The **OpenFE** industry-funded project currently does not allocate its developer resources directly to **alchemiscale**, so resourcing for the possibilities detailed above can occur by at least the following modes:
- service contracts with **Datryllic** from entities that depend on **alchemiscale**, either a [**bespoke**](https://datryllic.com/services/) engagement for building specific features, or a [**plug-and-play**](https://datryllic.com/services/#plug-alchemiscale) support engagement that funds continuous overall improvement of **alchemiscale** 
- contributions of internal developer effort from organizations that are invested in **alchemiscale**'s future for their own operations
- individual developer effort, volunteered for personal or professional reasons

We are happy to coordinate effort across any or all of these modes.
If you're interested in engaging in any of these ways, get in touch on our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum!
We're grateful for your interest, and eager to support your contributions to **alchemiscale**.

Together, we can make **alchemiscale** the premier execution system for alchemical free energy calculations now and into the future.
Cheers to an exciting 2026!
