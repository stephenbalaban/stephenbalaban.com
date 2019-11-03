---
title: "Caching with NSCache, or, The most underrated Objective-C Class"
date: "2013-01-19"
---

> _"There are only two hard things in Computer Science: cache invalidation and naming things." —Phil Karlton_

There are four things you need to know about NSCache. The first, and most important: **NSCache exists**. I recently wrote a cache object in Objective-C, this was a mistake. I Google'd "objective-c cache class":

[![NSCache](./images/Screen-Shot-2013-01-19-at-4.02.28-AM-300x222.png)](./images/Screen-Shot-2013-01-19-at-4.02.28-AM.png)
Unhelpful Google results for "objective-c cache class".

Top results looked uninteresting and I was feeling saucy; so I implemented one from scratch. I will be happy if this post serves no other purpose than to prevent you from making the same mistake. Now that you know the most important thing about NSCache, here are three more things you should know (especially if you still want to implement your own cache, which I recommend as an exercise). \[1\]

1. Apple does not publish NSCache's auto-removal policy, it is subject to change. I would guess it's caching algorithm is something like LRU (which is what GNUStep's implementation uses). \[3\]
2. NSCache is thread-safe, no need to @synchronize access.
3. NSCache does not copy the objects put into it, it keeps (and retains in non-ARC) pointers to cached objects. \[1\]

So put down that thread-unsafe NSMutableDictionary, pick up your NSCache, and stop reinventing the wheel. Or, at least know that it exists before you go making improvements.

**Sources & Further Reading:**

\[0\] [Phil Karlton](http://karlton.hamilton.com/) (Who deserves a Wikipedia page but that's another story)

\[1\] [Apple's Documentation on the NSCache Object](https://developer.apple.com/library/mac/#documentation/Cocoa/Reference/NSCache_Class/Reference/Reference.html "NSCache docs")

\[2\] [http://en.wikipedia.org/wiki/Cache\_algorithms#Least\_Recently\_Used](http://en.wikipedia.org/wiki/Cache_algorithms#Least_Recently_Used "LRU")

\[3\] [GNUStep's implementation of NSCache - NSCache.m](https://github.com/gnustep/libs-base/blob/master/Source/NSCache.m)
