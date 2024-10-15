---
title: 'advancement opportunities in 2025'
date: "2024-10-14T00:00:00-00:00"
authors: ["dotsdl"]
draft: false
---

This is a perspective on where we can take the **alchemiscale** project in 2025, given how far we've come and what is currently in development.
If you have any questions on the content, would like to get involved in development, or would like to sponsor any of these advancements, get in touch on our [Discussions thread]()!


## where we've been

We've come a long way since the **alchemiscale** project kicked off in early 2022.
Originally conceived as a wrapper around [**Folding@Home**](https://foldingathome.org/) for performing alchemical binding free energy calculations routinely and at scale, the project co-evolved with the [**Open Free Energy (OpenFE)**](https://openfree.energy/) data model to become a general-purpose, high-throughput execution system that can take advantage of a variety of distributed compute.
**alchemiscale** abstracts this compute away from users with a uniform interface, and is fully compatible with the [**OpenFE**](https://openfree.energy/) data model encoded in [**gufe**](https://github.com/OpenFreeEnergy/gufe).

In April 2023, we deployed the first **alchemiscale** instance to `alchemiscale.org`.
This instance saw joint use by [**OpenFF**](https://openforcefield.org/), [**OpenFE**](https://openfree.energy/), and [**ASAP Discovery**](https://asapdiscovery.org/), accelerating their work:
- **OpenFF** : benchmarking new molecular mechanics force fields via protein-ligand binding free energy calculations
- **OpenFE** : methods development for alchemical network definition and execution, including atom mapping and scoring, network planning, and alchemical protocols
- **ASAP Discovery** : fast and accurate binding affinity predictions supporting open science + open data antiviral discovery programs targeting viruses of pandemic potential

The `alchemiscale.org` instance has to date orchestrated ~700k GPU-hours of alchemical binding free energy calculations, and continues to perform large-scale compute for these organizations today.

{{< figure src="throughput.png" height=500 title="Cumulative throughput over time for alchemiscale.org instance." >}}


## where we are
<!-- add details on what we've done this year, our current activities, how advancement is organized-->

This year we've delivered many advancements to **alchemiscale** over multiple major releases:
- [0.3.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.3.0) : improvements to users’ ability to influence compute effort allocation, support for large `AlchemicalNetwork`s
    - ability to set and get `Task` priority and `AlchemicalNetwork` weight relative to others
    - vast speed improvement to `AlchemicalNetwork` submission and retrieval via use of `KeyedChain`s for smarter serialization
- [0.4.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.4.0) : performance improvements, both user- and compute-facing
    - performance improvements to `Task` creation, actioning, and claiming by compute services
    - new client methods for getting and setting many `AlchemicalNetwork` weights at once
    - new client methods for getting `Task` statuses and actioned `Task`s for many `AlchemicalNetwork`s at once
    - added concept of `AlchemicalNetwork` *state*, allowing users to set them to `inactive`, `deleted`, or `invalid` when no longer relevant
    - now using [Neo4j](https://github.com/neo4j/neo4j) 5.x, and the [official Neo4j Python Driver](https://neo4j.com/docs/python-manual/current/) for database communication
- [0.5.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.5.0) : **openfe** and **gufe** 1.0 compatibility, Folding@Home execution support
    - includes interoperability with the needs of the `FAHAsynchronousComputeService` in [alchemiscale-fah](https://github.com/OpenFreeEnergy/alchemiscale-fah)


We are currently designing and implementing MVP support for automated effort allocation via `Strategy`s.
A `Strategy` proposes where to apply additional compute given the set of results currently available for a given `AlchemicalNetwork`.
This will allow users to optionally associate a parameterized `Strategy` with the `AlchemicalNetwork`s they submit, and this `Strategy` will be applied periodically server-side to adaptively sample `Transformation`s until the `Strategy`'s stop thresholds are satisfied.
You can read more about the design for `Strategy`s on [Ian Kenney's development log](https://ianmkenney.github.io/devlog/strategiest_implementation/).

The next few major releases are focused around delivering this feature alongside related optimizations:

- [0.6.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/16) : result retrieval optimizations, server-side Task restart policies
    - Task restart policies detailed by [Ian Kenney on his development log](https://ianmkenney.github.io/devlog/taskrestartpolicy/) 
    - persistent caching for `ProtocolDAGResult`s in the `AlchemiscaleClient`
    - at-rest compression of `ProtocolDAGResult`s
- [0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/9)  : “living networks” and automated `Strategy` enablement
- [0.8.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/11) : automated `Strategy` execution


The **alchemiscale** project also recently migrated to the **OpenFE** organization after previously being hosted under **OpenFF**.
This enables more coherent and tighter collaboration with the developers of other **OpenFE** ecosystem tools.

## where we can go next

As we near the end of 2024, it makes sense to set a vision for what comes next for **alchemiscale**, and how we can continue to build on its strengths.
Our goal is for **alchemiscale** to become the *de facto* standard execution system for high-throughput alchemical free energy calculations, enabling both industry and academia to perform their work in ways previously impossible or cost-prohibitive.

We've identified 7 areas that present ripe opportunities for advancing **alchemiscale** in the next year.
Most of these areas can be tackled independently from one another, but many can benefit from progress made in others:

1. [**visualization**]({{< ref "#visualization" >}})
2. [**scalability**]({{< ref "#scalability" >}})
3. [**living networks**]({{< ref "#living-networks" >}})
4. [**compute efficiency**]({{< ref "#compute-efficiency" >}})
5. [**compute introspection**]({{< ref "#compute-introspection" >}})
6. [**compute cost**]({{< ref "#compute-cost" >}})
7. [**operations**]({{< ref "#operations" >}})


Do any of these speak to your needs?
Is one of these blocking your use of **alchemiscale** today?
Get in touch on our [Discussions thread]()!
We'd love to hear about your needs and how our development activity can help **alchemiscale** to meet them.

Are you a developer interested in contributing to **alchemiscale**?
If any of these areas sound appealing to you, your help is more than welcome!
Get in touch on our [Discussions thread](), and we'd be happy to help get you started.


### visualization

**alchemiscale** features a powerful Python client that enables users to submit `AlchemicalNetwork`s, action and prioritize `Transformation`s for compute, and pull results as they become available.
However, rich visualization of the state of **alchemiscale** and its calculations is not something the client will ever be capable of, given its nature as a simple HTTP interface.

Administrators are even worse-off currently, as managing users on an **alchemiscale** instance requires execution of CLI commands against the server, which is often awkward and tedious. Tracking compute throughput also requires direct [Cypher](https://en.wikipedia.org/wiki/Cypher_(query_language)) queries on the Neo4j database backend, requiring knowledge of Cypher to do this effectively, while also presenting the risk of destructive actions that could put the system in an unrecoverable, inconsistent state.

To address these shortcoming, deployable web UIs that provide missing functionality for users and admin alike could be developed, offering alternative ways to interact with an **alchemiscale** deployment.


#### user-facing visualization and introspection UI

A user-facing web UI that allows users to do at least the following would be of high value:
1. visually represent `AlchemicalNetwork`s in a performant, informative, and interactive way
2. graphically illustrate degree of `AlchemicalNetwork` results coverage, for example by color coding `Transformation`s based on `Task` status counts
3. `Transformation` result estimates, lazily computed and cached
4. detailed `Task` compute status

This same web UI could later be extended to allow users more than just read-only operations like those above, such as:
1. creating new `Task`s, as well as the ability to:
	- set `Task` status
	- set `Task` priority
	- set actioned `weight`
	- allow selection of multiple `Task`s at once to do the above in bulk
2. adding or altering the execution `Strategy`(s) applied to a given `AlchemicalNetwork`
3. changing the `state` of an `AlchemicalNetwork`
4. submitting serialized `AlchemicalNetwork`s produced with e.g. the `openfe` CLI

This is an area where could use substantial help.
None of our current core developers are experienced in web UI development, and though building a read-only UI/dashboard might be possible for us using frameworks like [Plotly Dash](http://dash.plotly.com) or [Streamlit](https://streamlit.io), building a more full-featured UI will likely be more involved and require more expertise.


#### admin-facing management UI

An admin-facing web UI that allows for the following would be of great use for anyone deploying or administering **alchemiscale**:
1. user creation/removal, with the ability to modify user `Scope` access
2. compute throughput and individual compute service metrics

Such an interface would seek to replace an admin's need for using the **alchemiscale** CLI for user management, as well as the need to directly interrogate the Neo4j database with Cypher queries to understand and investigate system state.


### scalability

**alchemiscale** can currently orchestrate compute for hundreds of `AlchemicalNetwork`s at once, each with thousands of `Transformation`s.
However, as these capabilities enable users to make heavier use of alchemical free energy calculations (FECs) at increasing scales, new barriers have emerged for efficiently analyzing results, provisioning sufficient compute, and dynamically managing that compute.


#### analysis bottlenecks

Users of `alchemiscale.org`, in particular **ASAP Discovery**, have noted that as their `AlchemicalNetwork`s grow larger in size, it becomes increasingly painful to pull results for whole-network analyses, such such as MLE estimators featured in `cinnabar`.

There are several independent optimizations that could be implemented to address this, which taken together would yield a much-improved user experience for analysis activity:
1. client `ProtocolDAGResult` caching : [alchemiscale#59](https://github.com/OpenFreeEnergy/alchemiscale/issues/58)
2. pre-signed URL `ProtocolDAGResult` retrieval : [alchemiscale#45](https://github.com/OpenFreeEnergy/alchemiscale/issues/45)
3. server-side `ProtocolResult` assembly
4. automated online estimates for `Transformation`s, whole-network estimators
5. at-rest `ProtocolDAGResult` compression : [alchemiscale#220](https://github.com/OpenFreeEnergy/alchemiscale/issues/220)
6. easy creation of archival extracts for `AlchemicalNetwork`s and their results : [alchemiscale#246](https://github.com/OpenFreeEnergy/alchemiscale/issues/246)


#### Folding@Home Protocols

The `alchemiscale.org` instance is capable of performing **Folding@Home**-based `Protocol`s via [alchemiscale-fah](https://github.com/OpenFreeEnergy/alchemiscale-fah), and this affords that instance and others with access to the **Folding@Home** network capable of "planetery-scale" compute.
However, we are currently limited to a single `Protocol` implementation, namely `FahNonEquilibriumCycling`, which limits the domain of applicability of **Folding@Home** for us.

Other `Protocol`s are likely possible, and are of interest to us to increase the utility of **Folding@Home** as a compute resource:
1. F@H Times Square Sampling : [alchemiscale-fah#6](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/6)
2. F@H Independent Lambdas : [alchemiscale-fah#4](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/4)
3. F@H Non-Equilibrium Switching : [alchemiscale-fah#2](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/2)


#### autoscaling compute

Conventional compute, such as that provided by HPC or GPU-enabled Kubernetes clusters, is far more accessible than **Folding@Home**, and most `Protocol`s are written to run on it.
Today it is possible to provision compute on these resources *statically*, meaning:
- on HPC compute, submitting `SynchronousComputeService` instances as individual jobs to the queuing system (e.g. SLURM, LFS, PBS), configured to perform a finite number of `Task`s or to terminate after some time has passed with no `Task` in progress
- on Kubernetes, submitting `SynchronousComputeService` instances as individual containers within a `Pod`, orchestrated as a finite set of `Job`s as for an HPC system, or as a set of ongoing services as a `Deployment`

These work *okay*, but there are several pain points with this situation:
- as new `Task`s become available, we often have to manually spin up more compute services to burst, and as `Task`s exhaust, we may need to manually spin those services down
- using utilization-based metrics to spin up and down compute services as one could do on e.g. Kubernetes via a `HorizontalPodAutoscaler` is too blunt an instrument: different `Protocol`s will utilize the GPU and CPU resources differently, making thresholds for scaling up and down difficult to set, and when resources are scaled down no distinction is made between those services doing work and those idling, wasting potentially hours of expensive GPU compute from indiscriminate deletion of running containers

To alleviate this, we propose several areas where effort could yield automated approaches to scaling compute up and down, eliminating the need for a human in the loop while improving efficiency and reducing cost of expensive GPU use:
1. `alchemiscale-hpc` : autoscaling compute on HPC
	- an autoscaling service that could be a lightweight job launcher to the local queueing system, *a la* `dask-jobqueue`, either claiming `Task`s itself and feeding them to these jobs or simply launching `SynchronousComputeService`s as jobs
	- would need to be runnable in both service/daemon mode and as a single-shot script, since on many HPC systems long-running processes are not allowed by administrators
2. `alchemiscale-k8s` : autoscaling compute on Kubernetes
	- an **alchemiscale**-specific variant of a `HorizontalPodAutoscaler` that periodically polls the **alchemiscale** server for available `Task`s, then launches `SynchronousComputeService` pods as `Job`s to meet this demand
	- could alternatively feature its own compute service variant that takes `Task`(s) the autoscaler claims as inputs
	- cloud-based Kubernetes clusters on which this autoscaler is deployed can be configured to provision and de-provision compute in response to `Pod` demand, allowing the system to scale up and down (within limits) autonomously
3. `alchemiscale-metascale` : meta-autoscaler with policies for feeding multiple compute backends
	- an additional service deployed alongside the state store, configured with policies for how to prioritize `Task` allocation across multiple compute resources
	- given potentially multiple compute resources, such as HPC clusters and Kubernetes clusters, this would allow one to prioritize `Task` allocation on cheaper (e.g. HPC that is not pay-per-use) resources before using more expensive ones (e.g. a cloud-based Kubernetes cluster with GPUs billed by the minute)
		- in other words: "baseload" compute can be performed on owned compute, while "burst" compute can make use of dynamically-scalable, rented compute
        - the details as to *how* this could work is yet to be determined; possible solutions could include soft and hard thresholds for the number of `Task`s claimed by certain compute service resource identifiers before claims are allowed from others


### living networks

**ASAP Discovery** via the **Chodera Lab** is trialing the concept of *living networks* as a novel approach to enabling drug discovery via alchemical binding free energy calculations (FECs).
As a discovery program progresses, new rounds of synthetic designs are "added" to the same `AlchemicalNetwork` (technically creating new `AlchemicalNetwork`s that are supersets of prior ones), iteratively growing it along with results for the `Transformation`s present.
In principle this allows new designs to take advantage of existing results for similar designs already present in the network, and can be combined with experimental assay data via e.g. `cinnabar` to produce increasingly accurate binding affinity estimates at lower additional computational cost for new FECs.

This usage pattern is already possible to some extent today.
However, there are areas where additional effort could enable more flexibility for users leveraging **alchemiscale** in this way.

#### merging and copying `AlchemicalNetwork`s server-side

The *living networks* pattern currently requires some discipline to make effective use of.
An `AlchemicalNetwork` that aims to take advantage of existing `Transformation` results should be submitted to the same `Scope` as the `AlchemicalNetwork`(s) those results correspond to.
Two related `AlchemicalNetwork`s cannot later be "merged" in such a way to take advantage of the available results from either one.

To address this, we propose adding additional `AlchemiscaleClient` methods that allow for server-side copying and merging of `AlchemicalNetwork`s from one or more `Scope`s to another.

See [alchemiscale#221](https://github.com/OpenFreeEnergy/alchemiscale/issues/221) for more details.


#### expanding living `AlchemicalNetwork`s with new protein structures

A current pain point with the *living networks* pattern in practice is incorporating new protein structures as these become available, which is the case for structurally-enabled discovery programs.
Many alchemical `Protocol`s assume that a `Transformation` features the same `ProteinComponent` within the `ChemicalSystem`s it spans, and a consequence of this is that it is not really possible to incorporate new protein structures with `Transformation` connections to old ones in the same `AlchemicalNetwork`.

This isn't strictly an **alchemiscale** issue, but is instead a problem that will require solutions in [**gufe**](https://github.com/OpenFreeEnergy/gufe) and most `Protocol`s to take into account differences in `ProteinComponent`s across a `Transformation`.


### compute efficiency

Complementary to [**scalability**]({{< ref "#scalability" >}}), there are several areas in which we may be able to make better use of the compute we are already using, requiring less need to scale up or out to deliver the same result throughput.

#### parallel execution of `ProtocolDAG`s for GPU saturation

The `SynchronousComputeService` is our current workhorse for executing the `ProtocolDAG`s defined by alchemical `Protocol`s.
This service is the simplest possible implementation of an **alchemiscale** compute service, functioning as our reference implementation, but it leaves a lot of potential performance on the table given its simplicity.

The `SynchronousComputeService` executes `ProtocolDAG`s sequentially ("synchronously", as opposed to "asynchronously"), and therefore does not take any advantage of the opportunities for parallelism some `ProtocolDAG`s may offer by way of their structure.
A compute service that instead performs several `ProtocolUnit`s of a `ProtocolDAG` in parallel could make better use of the resources it is deployed on, saturating its available GPU(s) and CPU(s).
Such a compute service could also be written to perform *multiple* `ProtocolDAG`s at once, which could work to ensure high GPU saturation for many `ProtocolDAG`s with low intrinsic parallelism.

One obstacle to implementing this is that individual `ProtocolUnit`s within a `ProtocolDAG` don't indicate to an executor the kind or quantity of compute resources they will require.
A compute service that runs multiple `ProtocolUnit`s in parallel could very well *oversaturate* its compute resources, killing throughput gains by causing those resources to thrash or even crash.
Enhancements to the **gufe** `Protocol` system will be needed to add resource requirements to the `ProtocolUnit`s they generate;
this will allow more complex executors to optimally schedule `ProtocolUnit`s for parallel execution and avoid oversaturation.


#### immediate `Task` cancellation on a compute service when not actioned anywhere

After a compute service claims an actioned `Task`, it never checks whether this `Task` is still actioned before or during execution of its corresponding `ProtocolDAG`.
This means that a `Task` that a user has since cancelled, and is perhaps no longer actioned at all on *any* `AlchemicalNetwork`, may still consume hours of expensive compute, wasting time and money that would be better spent on `Task`s that are currently actioned.

A relatively easy way to avoid this is for the compute service to periodically check that its claimed `Task`s are still actioned on at least one `AlchemicalNetwork`, and if they are not, halt execution immediately and drop the claims.

See [alchemiscale#301](https://github.com/OpenFreeEnergy/alchemiscale/issues/301) for more details.

#### server-side memory of compute services that consistently fail jobs

Compute services claim `Task`s from the set of all actioned and `waiting` `Task`s within their visible `Scope`s.
If a compute service is operating on a resource that is poorly behaved (e.g. filesystem issues/timeouts, poorly configured GPU, etc.), it could consistently and quickly fail any `Task` it claims, exhausting the available `Task`s before other "healthy" compute services can claim them.
This can be incredibly annoying to users, who then have to vigilantly set their `Task`s to rerun, or set aggressive [restart policies](https://github.com/openforcefield/alchemiscale/issues/277) in the hope this compensates.

As a way to mitigate this, we would like to give the server "short-term memory" of compute services that consistently fail jobs.
The server would deny claims from a compute service that has failed some threshold of jobs, up to some expiry time, effectively slowing down the rate at which an unhealthy service can claim new `Task`s.
It would also give the unhealthy service chances to redeem itself if the issue that's causing consistent failure is temporary.

See [alchemiscale#258](https://github.com/OpenFreeEnergy/alchemiscale/issues/258) for more details.


#### additional `Strategy` implementations

Beyond [NetBFE](https://pubs.acs.org/doi/10.1021/acs.jctc.1c00703), there are other `Strategy`s one could implement that optimize for different things.
These include choosing to allocate compute based on:

1. `Transformation`/`Mapping` score
2. critical connectivity in the `AlchemicalNetwork`

Exploring this space of possibilities for different `Strategy`s would add richness to the portfolio of adaptive sampling approaches available.
Users can also experiment with `Strategy`s of their own locally, and enabling this via the `AlchemiscaleClient` is something we would like to spend effort on.


#### `Strategy` stacking

We are currently working on initial support for `Strategy`s (see [**where we are**]({{< ref "#where-we-are" >}})), but beyond this there may be a good case for being able to *stack* multiple `Strategy`s on a single `AlchemicalNetwork`.

Instead of being limited to assigning a single parameterized `Strategy` to an `AlchemicalNetwork`, one could instead assign a (limited) set of them.
These `Strategy`s would then each propose weights for which `Transformation`s effort should be applied next given current results, and these proposal weights will be aggregated to form the overall weights on which action is taken.
The `Strategy`s effectively function as a committee, and in a way "vote" on what should be done next.

One scenario in which this could work particularly well: stacking two `Strategies`, where one is more opinionated when few results exist and the other when many results exist.
The first `Strategy` would dominate driving the agenda early on, such as optimizing for connectivity coverage.
As connectivity improves or is fully covered, the other `Strategy` may be more opinionated given the uncertainties that exist for individual `Transformation`s.
The combination of these two can thus drive overall result collection along a trajectory that is more useful to the user.


### compute introspection

**alchemiscale** by design abstracts away the compute resources used to evaluate the `Transformation`s within an `AlchemicalNetwork`.
However, when problems occur with `Protocol` execution, users currently have limited mechanisms for introspecting what is going wrong compute-side.

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


#### stdout, stderr retention

In addition to result files, some `Protocol`s also emit [`stdout` and `stderr`](https://en.wikipedia.org/wiki/Standard_streams) outputs that feature valuable information that isn't caught in log streams.
This may be especially true for `Protocol`s that run executables via subprocess and do not actively capture `stdout` or `stderr` themselves.

Preserving this information in a form retrievable by users could help in failure cases where neither the `ProtocolDAGResult` object nor the result files provide sufficient information on what is going wrong.

Complementary to this, adding the ability for compute services to preserve the logging streams of a `ProtocolDAG` and its `ProtocolUnit`s would also give another mechanism for user introspection.


#### host provenance

As a way to understand performance issues, or to later produce throughput/usage metrics across different compute resources, it would be especially valuable to hold on to hardware and some software information from the host on which a `ProtocolDAG` was executed.

See [alchemiscale#106](https://github.com/OpenFreeEnergy/alchemiscale/issues/106) for more information.


### compute cost

When users prepare an `AlchemicalNetwork`, it isn't clear *a priori* how expensive compute-wise it will likely be to achieve actionable results.
At best users must guess, and won't really know until they have performed enough `Task`s on the `AlchemicalNetwork` to satisfy their needs.

It could be possible for **alchemiscale** to provide *a priori* estimates of an `AlchemicalNetwork`'s computational costs based on previously-computed ones, and this could also be made to account for existing results on matching `Transformation`s.


#### prediction of `AlchemicalNetwork` computational cost based on compute consumed by previously-computed `AlchemicalNetwork`s

Given additional [**host provenance**]({{< ref "#host-provenance" >}}) preserved from individual `ProtocolDAGResult`s, it could be possible to
assemble samples on the GPU-hr requirements for `Transformation`s of varying complexity, system sizes, and settings over time within a given **alchemiscale** instance.
These samples could then be used to train an estimator that could predict the computational costs (with uncertainties) of `Transformation`s in new `AlchemicalNetwork`s before they are even submitted, giving users some sense of how expensive the calculations they are about to launch are likely to be.

This could be implemented as an additional service that iteratively trains its estimator(s) as results continue to accumulate, increasing its accuracy over time.
This would also be performed server-side, with the only latency from user `AlchemiscaleClient` requests coming from inference with the estimator.


#### prediction of `AlchemicalNetwork` computational cost accounting for existing `Transformation` results

In addition to the above, since `AlchemicalNetwork`s submitted to the same `Scope` share `Transformation`s, and therefore results, the estimator could be made to only consider `Transformation`s that don't exist in the `Scope` a user intends to submit their `AlchemicalNetwork` into.
This could help to give more accurate predictions of cost, especially for highly-iterative usage patterns like [**living networks**]({{< ref "#living-networks" >}}).


### operations

In addition to the other areas detailed above, there are several key areas that could significantly enhance **alchemiscale**'s operations model.

#### tooling for performing data model migrations

**alchemiscale** is an *execution system*, not an *archival system*, and this distinction loosely encodes our guarantees to users on result retrievability as the data models **alchemiscale** depends on evolve.
We currently have very little if any migration machinery in place for transitioning data models in an existing **alchemiscale** instance to new versions featured in e.g. [**openfe**](https://github.com/OpenFreeEnergy/openfe) or [**feflow**](https://github.com/OpenFreeEnergy/feflow).

We should formalize the boundaries of our guarantees around support for data model updates in **alchemiscale** itself and common packages deployed with it, then build a framework for updating data models on deployed systems in compliance with those guarantees.

#### admin client/API for remote user management

When an operator needs to add a new user to an existing **alchemiscale** instance, currently they must [run the `alchemiscale` CLI tool](https://docs.alchemiscale.org/en/latest/operations.html#adding-users) in an environment that can connect directly to the instance's Neo4j database.
Since containerized deployments are the standard approach, this tends to require running these commands with `docker exec` or equivalent, adding complexity.

Instead, we would like to introduce a new admin-facing client and API service that can be used for remotely performing user management.
This would work the same way as the user-facing and compute-facing APIs, and would feature its own `admin` identity type as a way to separate permissioning from `user` and `compute` identities.
The `alchemiscale` CLI could then make use of this admin client and API for its user management calls, removing the need for direct access to the database.

An [**admin-facing management UI**]({{< ref "#admin-facing-management-ui" >}}) would also make use of the same `admin` identities for authentication.


#### user read, write, domain permissions

Currently, any user with access to a given `Scope` can do whatever they like in that `Scope`: accessing results, creating new `AlchemicalNetwork`s and `Task`s, actioning `Task`s, etc.
We would like to add more granular permissioning on top of simple `Scope` access, in particular `read`, `write`, and `domain` permission sets.

The `write` permission set would be equivalent to the current permissions a user has on `Scope`s they have access to, while `read` would permit only API calls that make no modifications to the state of objects on the server.
On top of `write`, the `domain` permission set would include the ability to add or remove access permissions to that `Scope` for other users, effectively allowing existing users to self-organize access to the `Scope`s they have `domain` access to.

See [alchemiscale#43](https://github.com/OpenFreeEnergy/alchemiscale/issues/43) for more information.


## how do we do it?

All of this sounds amazing!
How do we do it?

**alchemiscale** development is coordinated via [two-week sprints](https://github.com/orgs/OpenFreeEnergy/projects/45/views/1) within the **OpenFE** organization, with development currently led by [**Datryllic**](https://datryllic.com/).
The **OpenFE** industry-funded project currently does not allocate its developer resources directly to **alchemiscale**, so resourcing for the possibilities detailed above can occur by at least the following modes:
- service contracts with **Datryllic** from entities that depend on **alchemiscale**, either a [**bespoke**](https://datryllic.com/services/) engagement for building specific features, or a [**plug-and-play**](https://datryllic.com/services/#plug-alchemiscale) support engagement that funds continuous overall improvement of **alchemiscale** 
- contributions of internal developer effort from organizations that are invested in **alchemiscale**'s future for their own operations
- individual developer effort, volunteered for personal or professional reasons

We are happy to coordinate effort across any or all of these modes.
If you're interested in engaging in any of these ways, get in touch on our [Discussions thread]()!
We're grateful for your interest, and eager to support your contributions to **alchemiscale**.

Together, we can make **alchemiscale** the premier execution system for alchemical free energy calculations now and into the future.
Cheers to an exciting 2025!
