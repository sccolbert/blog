+++
title = "A little more care, a little less clever"
slug = "things-that-last"
date = 2026-09-06
summary = "On building things that are easy to understand, pleasant to use, and worth looking after. In software and elsewhere."
tags = ["engineering", "development", "life"]
draft = true
[params]
sample = true
format = "Essay"
subtitle = "A few thoughts about the work we leave behind."
+++
There is a particular kind of satisfaction in opening something and finding that
it makes sense. A neatly wired panel. A well-organized drawer. A small piece of
software whose names tell you what it does.

None of these things has to be impressive at first glance. Their quality becomes
apparent when you need to use them, repair them, or hand them to someone else.

That seems like a useful ambition for work: make something that continues to be
good company after the novelty wears off.

## The person who comes next

Imagine inheriting two small programs. Both produce the same result. One has a
few ordinary functions, a readable configuration file, and a short explanation
of its assumptions. The other manages the same job with an elegant arrangement
of abstractions that takes an afternoon to untangle.

The second program may have been more enjoyable to write. The first might be
more generous to receive.

{{% columns %}}
{{% column %}}
### At the workbench

Leave room to reach the fastener. Mark the part that needs a particular
orientation. Use a joint that someone can inspect.

These are small choices made on behalf of a future pair of hands.
{{% /column %}}
{{% column %}}
### In the codebase

Give the operation a plain name. Keep related decisions close together. Explain
why the unusual constraint exists.

These are small choices made on behalf of a future reader.
{{% /column %}}
{{% /columns %}}

## Room for judgment

Simplicity isn't a contest to use the fewest parts. Sometimes another brace makes
the table steadier. Sometimes another function makes the program easier to read.
The question is whether the extra piece earns its place.

That requires attention to the actual situation. A temporary fixture and a
dining table do not need the same finish. A script used once and a service used
every day deserve different investments.

{{% callout title="A question worth asking" %}}
Will this choice make the next person's work easier, or will they have to
rediscover what I already know?
{{% /callout %}}

Care often looks ordinary. It is the label, the smoothed edge, the example that
actually runs. It is stopping for ten minutes to leave things in a comprehensible
state before moving on.

There is plenty of room for invention in that kind of work. There is also room
for the quieter pleasure of making something dependable.
