+++
title = "A function you can read before coffee"
slug = "a-readable-function"
date = 2026-08-17
summary = "Naming, small decisions, and the overlooked kindness of code that tells you what it means."
tags = ["development", "engineering"]
draft = true
[params]
sample = true
format = "Workshop"
+++
Readable code gives the reader a place to stand. Before they understand every
detail, they can usually tell what is happening and where to look next.

Consider a small operation that decides whether a task is ready to start:

```python
def ready_to_start(task):
    if task.is_complete:
        return False

    return all(dependency.is_complete for dependency in task.dependencies)
```

There is nothing novel here. The name offers a question, the first condition
handles an obvious exception, and the last line gives the remaining rule.

## Put the question in the name

The caller can use that rule without carrying all its details around:

```python
ready_tasks = [task for task in tasks if ready_to_start(task)]
```

This is illustrative Python, not a complete scheduling system. A real one would
need to decide how failures, cycles, and concurrent changes affect readiness.
Those decisions deserve explicit names too.

| A useful question | A place to make it visible |
| --- | --- |
| What does this operation decide? | The function name |
| What can the caller rely on? | The interface and examples |
| Why does an odd constraint exist? | A short explanatory comment |

The goal is to spend attention on the actual problem. A reader should not need
to solve a naming puzzle before they can begin.
