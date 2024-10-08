---
title: 'advancement opportunities in 2025'
date: "2024-10-07T00:00:00-00:00"
authors: ["dotsdl"]
draft: true
---


## where we've been

We've come a long way since the **alchemiscale** project kicked off in early 2022.
Originally concieved as a wrapper around Folding@Home for performing alchemical binding free energy calculations routinely and at scale, the project co-evolved with the **OpenFE** data model to become a general-purpose, high-throughput execution system that can take advantage of a variety of distributed compute.
**alchemiscale** abstracts this compute away from users with a uniform interface, and is fully compatible with the **OpenFE** data model encoded in **gufe**.

In April 2023, we deployed the first **alchemiscale** instance to `alchemiscale.org`.
This instance saw joint use by **OpenFF**, **OpenFE**, and **ASAP Discovery**, accelerating their work:
- **OpenFF** : benchmarking of new molecular mechanics force fields via protein-ligand binding free energy calculations
- **OpenFE** : methods development for alchemical network definition and execution, including atom mapping and scoring, network planning, and alchemical protocols
- **ASAP Discovery** : fast and accurate binding affinity predictions supporting open science + open data antiviral discovery programs targeting viruses of pandemic potential

The `alchemiscale.org` instance has to date orchestrated ~`<estimate>` GPU-hours of alchemical binding free energy calculations, and continues to perform large-scale compute for these organizations today.

## where we are
<!-- add details on what we've done this year, our current activities, how advancement is organized-->




## where we can go next

As we near the end of 2024, it makes sense to set a vision for what comes next for **alchemiscale**, and how we can continue to build on its strengths.
Our goal is for **alchemiscale** to become the *de facto* standard execution system for high-throughput alchemical free energy calculations, enabling both industry and academia to perform their work in ways previously impossible or cost-prohibitive.

We've identified 7 areas that present ripe opportunities for advancing **alchemiscale** in the next year.
Most of these areas can be tackled independently from one another, but many can benefit from progress made in others.

<!-- consider adding top-level graphic -->

<!-- consider reorganizing as single level headings with nested numbered lists -->

Do any of these speak to your needs?
Is one of these blocking your use of **alchemiscale** today?
Get in touch on our [Discussions thread]()!
We'd love to hear about your needs and how our development activity can help **alchemiscale** to meet them.

Are you a developer interested in contributing to **alchemiscale**?
If any of these areas sound appealing to you, your help is more than welcome!
Get in touch on our [Discussions thread](), and we'd be happy to help get you started.

<!-- link to corresponding issues where applicable -->

### visualization
**alchemiscale** features a powerful Python client that enables users to submit `AlchemicalNetwork`s, action and prioritize `Transformation`s for compute, and pull results as they become available.
However, rich visualization of the state of **alchemiscale** and its calculations is not something the client will ever be capable of, given its nature as a simple HTTP interface.

Administrators are even worse-off currently, as managing users on an **alchemiscale** instance requires execution of CLI commands against the server, which is often awkward and tedious. Tracking compute throughput also requires direct Cypher queries on the Neo4j database backend, requiring knowledge of Cypher to do this effectively, while also presenting the risk of destructive actions that could put the system in an unrecoverable, inconsistent state.

To address these shortcoming, deployable web UIs that provide missing functionality for users and admin alike could be developed, offering alternative ways to interact with an **alchemiscale** deployment.
#### user-facing visualization and introspection UI
A user-facing web UI that allows users to do at least the following would be of high value:
1. visually represent `AlchemicalNetwork`s in a performant, informative, and interactive way
2. graphically illustrate degree of `AlchemicalNetwork` results coverage, for example by color coding `Transformation`s base on `Task` status counts
3. `Transformation` result estimates
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
None of our current core developers are experienced in web UI development, and though building a read-only UI/dashboard might be possible for us using frameworks like Plotly Dash or ..., building a more full-featured UI will likely be more involved and require more expertise.
#### admin-facing management UI
An admin-facing web UI that allows for the following would be of great use for anyone deploying or administering **alchemiscale**:
1. user creation/removal, with the ability to modify user `Scope` access
2. compute throughput and individual compute service metrics

Such an interface would seek to replace an admin's need for using the **alchemiscale** CLI for user management, as well as the need to directly interrogate the Neo4j database with Cypher queries to understand and investigate system state.

### scalability
**alchemiscale** can currently orchestrate compute for hundreds of `AlchemicalNetwork`s at once, each with thousands of `Transformation`s.
However, as these capabilities enable users to make heavier use of alchemical FECs at increasing scales, new barriers have emerged for efficiently analyzing results, provisioning sufficient compute, and dynamically managing that compute.
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
The `alchemiscale.org` instance is capable of performing Folding@Home-based `Protocol`s via [alchemiscale-fah](https://github.com/OpenFreeEnergy/alchemiscale-fah), and this affords that instance and others with access to the Folding@Home network capable of "planetery-scale" compute.
However, we are currently limited to a single `Protocol` implementation, namely `FahNonEquilibriumCycling`, which limits the domain of applicability of Folding@Home for us.

Other `Protocol`s are likely possible, and are of interest to us to increase the utility of Folding@Home as a compute resource:
1. F@H Times Square Sampling : [alchemiscale-fah#6](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/6)
2. F@H Independent Lambdas : [alchemiscale-fah#4](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/4)
3. F@H Non-Equilibrium Switching : [alchemiscale-fah#2](https://github.com/OpenFreeEnergy/alchemiscale-fah/issues/2)

#### autoscaling compute
Conventional compute, such as that provided by HPC or GPU-enabled Kubernetes clusters, is far more accessible than Folding@Home, and most `Protocol`s are written to run on it.
Today it is possible to provision compute on these resources *statically*, meaning:
- on HPC compute, submitting `SynchronousComputeService` instances as individual jobs to the queuing system (e.g. SLURM, LFS, PBS), configured to perform a finite number of `Task`s or to terminate after some time has passed with no `Task` in progress
- on Kubernetes, submitting `SynchronousComputeService` instances as individual containers within a `Pod`, orchestrated as a finite set of `Job`s as for an HPC system, or as a set of ongoing services as a `Deployment`

These work *okay*, but there are several pain points with this situation:
- as new `Task`s become available, we often have to manually spin up more compute services to burst, and as `Task`s exhaust, we may need to manually spin those services down
- using utilization-based metrics to spin up and down compute services as one could do on e.g. Kubernetes via a `HorizontalPodAutoscaler` is too blunt an instrument: different protocols will utilize the GPU and CPU resources differently, making thresholds for scaling up and down difficult to set, and when resources are scaled down no distinction is made between those doing work and those idling, wasting potentially hours of expensive GPU compute each from indiscriminate deletion of running containers

To alleviate this, we propose several areas where effort could yield automated approaches to scaling compute up and down, eliminating the need for a human in the loop while improving efficiency and reducing cost of expensive GPU use:
1. `alchemiscale-hpc` : autoscaling compute on HPC
	- an autoscaling service that could be a *lightweight* launcher of jobs to the local queueing system, *a la* `dask-jobqueue`, either claiming `Task`s itself and feeding them to these jobs or simply launching `SynchronousComputeService`s as jobs
	- would need to be runnable in both service/daemon mode and as a single-shot script, since on many HPC systems long-running processes are not allowed by administrators
2. `alchemiscale-k8s` : autoscaling compute on Kubernetes
	- an **alchemiscale**-specific variant of a `HorizontalPodAutoscaler` that periodically polls the **alchemiscale** server for available `Task`s, then launches `SynchronousComputeService` pods as `Job`s to meet this demand
	- could alternatively feature its own compute service variant that takes `Task`(s) the autoscaler claims as inputs
	- cloud-based Kubernetes clusters on which this autoscaler is deployed can be configured to provision and de-provision compute in response to `Pod` demand, allowing the system to scale up and down (within limits) autonomously
3. `alchemiscale-metascale` : meta-autoscaler with policies for feeding multiple compute backends
	- an additional service deployed alongside the state store, configured with policies for how to prioritize `Task` allocation across multiple compute resources
	- given potentially multiple compute resources, such as HPC clusters and Kubernetes clusters, this would allow one to prioritize `Task` allocation on cheaper (e.g. HPC that is not pay-per-use) resources before using more expensive ones (e.g. a cloud-based Kubernetes cluster with GPUs billed by the minute)
		- in other words: "baseload" compute can be performed on owned compute, while "burst" compute can make use of dynamically-scalable, rented compute

### living networks
**ASAP Discovery** via the **Chodera Lab** is trialing the concept of "living networks" as a novel approach to enabling drug discovery via alchemical binding free energy calculations.
Over the course of a discovery program, 

#### merging and copying `AlchemicalNetwork`s server-side

#### expanding living `AlchemicalNetwork`s with new protein structures


### compute efficiency
Somewhat related to **scalability**, there are several areas in which we may be able to make better use of compute, requiring less need to scale to deliver the same value.

#### parallel execution of `ProtocolDAG`s for GPU saturation


#### immediate `Task` cancellation on compute service when not actioned anywhere


#### `Strategy` stacking


#### additional `Strategy` implementations

1. choices based on `Transformation`/`Mapping` score
2. choices based on critical connectivity in the `AlchemicalNetwork`

#### server-side memory of compute services that consistently fail jobs



### compute cost

#### prediction of `AlchemicalNetwork` computational cost based on compute consumed by previously-computed `AlchemicalNetwork`s

#### prediction of `AlchemicalNetwork` computational cost accounting for existing `Transformation` results


### compute introspection

#### result file retention and retrieval

#### stdout, stderr retention

#### host provenance


### operations

#### tooling for performing data model migrations

#### admin client/API for remote user management

#### user read, write, domain permissions


## how do we do it?
