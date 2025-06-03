---
title: "advancements in alchemiscale v0.6"
date: "2025-06-02T00:00:00-00:00"
authors: ["dotsdl"]
tags: ["release"]
showTableOfContents: false
draft: false
---

In February of this year we released **alchemiscale** [v0.6.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.0), and followed this up with [v0.6.1](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.1) and [v0.6.2](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.2).
We wanted to take a moment to highlight these releases, and the improvements they bring for users!


## v0.6.0

As a major release, [v0.6.0](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.0) introduced the concept of [**`Task` restart policies**](https://github.com/OpenFreeEnergy/alchemiscale/issues/277), allowing users to automate restarts for `Task` failures based on the types of errors they are encountering.
When running on distributed, heterogeneous compute, `Task`s may encounter a variety of errors unrelated to the calculation being performed.
These could be temporary issues due to resource oversubscription from colocated jobs (the so-called "noisy neighbor problem"), filesystem issues, GPU driver mismatches, or other problems that are often outside of a user's control.

Users can now set a restart policy for the `Task`s of an `AlchemicalNetwork` with:

```python
from alchemiscale import AlchemiscaleClient, ScopedKey

asc: AlchemiscaleClient   # an existing AlchemiscaleClient instance
an_sk: ScopedKey          # an AlchemicalNetwork ScopedKey

# rerun any `Task` that failed with a `RunTimeError`
# or matched `MemoryError` at most 5 times
asc.add_task_restart_patterns(an_sk,
                              [r"RuntimeError: .+",
                               r"MemoryError: Unable to allocate \d+ GiB"],
                              5)

```

More details on usage can be found in the [User Guide](https://docs.alchemiscale.org/en/latest/user_guide.html#re-running-errored-tasks-with-task-restart-patterns).

This release also [substantially reduced the size of result objects](https://github.com/OpenFreeEnergy/alchemiscale/issues/220) pulled by users via the `AlchemiscaleClient`.
We now use the [`KeyedChain`](https://gufe.openfree.energy/en/stable/concepts/tokenizables.html#d-keyed-chain) representation for all `ProtocolDAGResult` objects produced by compute services, and these are now also *compressed-at-rest* on creation using [zstd](https://en.wikipedia.org/wiki/Zstd).

Finally, we added [user-configurable on-disk caching](https://github.com/OpenFreeEnergy/alchemiscale/issues/58) to the `AlchemiscaleClient`.
For repeated calls to e.g. `AlchemiscaleClient.get_network_results()`, this reduces the need to pull down the same `ProtocolDAGResult`s over and over, keeping the most recently-requested `ProtocolDAGResult`s on a user's local disk for retrieval instead.
The cache will only keep objects up to a size limit (default 1 GiB), and this is configurable by the user.


## v0.6.1

Release [v0.6.1](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.1) was a bugfix release, [fixing a broken codepath in the compute API](https://github.com/OpenFreeEnergy/alchemiscale/pull/370) for resolving task restarts for failed `ProtocolDAGResult`s.
This was a critical bug, in which failed `Task`s caused compute API failures.
We added additional tests to catch cases like this in the future before release.


## v0.6.2

Release [v0.6.2](https://github.com/OpenFreeEnergy/alchemiscale/releases/tag/v0.6.2) was an incremental release, offering some usability improvements based on user feedback.
Disk caching can now be disabled for [users of the `AlchemiscaleClient`](https://github.com/OpenFreeEnergy/alchemiscale/issues/366) and for [compute services](https://github.com/OpenFreeEnergy/alchemiscale/pull/392), which can be especially helpful if the cache is causing issues on network filesystems (such as on HPC resources).
Users can also now set all required arguments for the `AlchemiscaleClient` via environment variables, namely `ALCHEMISCALE_URL`, `ALCHEMISCALE_ID`, and `ALCHEMISCALE_KEY`.
Not only is this convenient: it also reduces the likelihood of accidently saving an API key in a Jupyter notebook.

## what's next?

We are currently hard at work on the major new features coming in [v0.7.0](https://github.com/OpenFreeEnergy/alchemiscale/milestone/11), so keep a look out for this release in the coming months!

If you are interested in trying **alchemiscale** out, or if you already have and want to offer ideas for improvement, please reach out!
Posting in our [Discussions](https://github.com/OpenFreeEnergy/alchemiscale/discussions) forum is the best way to get started!
