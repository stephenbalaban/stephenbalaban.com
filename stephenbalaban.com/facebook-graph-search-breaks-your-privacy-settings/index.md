---
title: "Facebook Graph Search Breaks Your Privacy Settings"
date: "2013-02-04"
---

**Facebook's new Graph Search is broken.**

It was a sunny afternoon in Chinatown. I was taking my new Graph Search invite for a spin. After exhausting the—surprisingly long—list of _females_ under _30_ living in _San Francisco_, who went to _MIT_ and like _Seinfeld_, I went for something more mundane, but far more sinister. "Photos of My Brother".

Pesky privacy-conscious sibling not letting you view their photos? _There's a Graph Search for that.™ _ Lo and behold, despite my brother's draconian privacy settings, despite his profile advertising to me "No photos to show", that simple search provided dozens of never before seen photos of my fraternal twin. He was outraged.

![Facebook Graph Search "Photos of"](./images/Screen-Shot-2013-02-04-at-3.23.49-AM.png)

Luckily, a single predicate can realign the current implementation with my brother's, and others', expectations. _If Mallory can't see a photo on Alice's profile, don't show it to Mallory in a "Photos of Alice" Graph Search._ This would have prevented the disabling of my brother's Facebook account and untagging of his photos that ensued. **This would fix Graph Search.**

You may argue, "Even before Graph Search, Mallory could manually browse the public photos of Alice's friends and view those photos of Alice." While this is true, Graph Search makes this formerly Sisyphean task a matter of a few keystrokes. It broke my brother's privacy settings.

"The new Request Removal Tool!", you may cry. I've used it myself and assisted multiple friends in untagging their newly searchable photos. Here's the interface and a photo of me enjoying a cup of coffee:

[![Facebook Request Removal Tool](./images/Screen-Shot-2013-02-04-at-3.46.57-AM.png)](./images/Screen-Shot-2013-02-04-at-3.46.57-AM.png)

A "removal" tool that requires you to scroll through your timeline for 15+ minutes, mindlessly clicking check box after check box, is not a removal tool. It's a digital torture device. We want one-click Graph Search opt-out.

I don't blame Facebook. The majority of their users don't seem to care about privacy, and that's fine for them. But some of us, like my brother, do care. Some of us have every possible privacy setting set to "Only Me". We expect that to mean _only_ me, not me and people with Graph Search. Regardless of your sharing preferences, you must agree: we deserve a system that respects our privacy. **Facebook, please fix Graph Search.**

Summary (for those at Facebook working on Graph Search, feel free to bring these points up in your next meeting or standup):

1. Graph Search, in it's current implementation, breaks the privacy model
2. If a photo can't be seen on my profile, don't show it in a Graph Search
3. Make tools and settings which allow us to easily manage our Graph Search privacy

Your thoughts and feelings are welcome. I'd especially like to hear from those currently working on the product.
