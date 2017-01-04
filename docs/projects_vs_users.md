Projects vs users
=================

In general, anything that a build or runtime dependency belongs in a project.
Anything that is preferential to a user belongs in a user's config.

Simple examples:

| Dependency        | Prefered location |
| ----------------- | ------------------|
| intellij          | user              |
| atom              | user              |
| docker            | project           |
| python            | project           |
| PATH modification | user              |

In general, something like `PATH` modification should be restricted to user's personal config,
however in some cases could be appropriate with projects. For instance, if a project requires NPM
to work a certain way, but projects should not be used to simply update PATH for testing reasons.
