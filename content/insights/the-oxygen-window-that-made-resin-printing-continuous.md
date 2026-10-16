---
title: "The Oxygen Window That Made Resin Printing Continuous"
date: 2026-10-13
description: "How a precisely engineered 'dead zone' of still-liquid resin, held open by a thin film of oxygen, let one printing process trade stop-and-go curing for one unbroken pull."
featured_image: "/images/insights/the-oxygen-window-that-made-resin-printing-continuous/image1.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["Resin 3D Printing", "Photopolymerization", "Process Engineering", "Digital Light Synthesis"]
ai_level: "All Machine"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
aliases:
  - /insights/the-oxygen-window-that-made-resin-printing-continuous/
---

![Side-by-side schematic comparing stepwise vat photopolymerization, which peels and reflows resin between every layer, against continuous liquid interface production, which pulls a part upward in one unbroken motion above a thin oxygen-held dead zone.](/images/insights/the-oxygen-window-that-made-resin-printing-continuous/image1.jpg)
*Stepwise printing stops to peel and reflow resin after every layer. CLIP removes the stop entirely by keeping a thin band of resin permanently uncured.*

Stereolithography prints by brute repetition. A UV image cures one cross-section against the floor of a resin vat, the build platform peels away so fresh resin can flood back in, and the light fires again. The peel step, not the cure itself, is what limits speed: every layer means separating the part from the vat window, waiting for resin to reflow, and reseating before the next exposure. A team working across the University of North Carolina at Chapel Hill, North Carolina State University, and the startup Carbon3D found a way to remove the peel step entirely, and the fix came down to a few microns of oxygen.

Oxygen is a radical scavenger. In a standard acrylate resin, UV light generates free radicals that drive the chain reaction turning liquid monomer into solid polymer, and oxygen reacts with those radicals before a chain can propagate. [Tumbleston and colleagues](https://www.laserfocusworld.com/lasers-sources/article/16551673/3d-printing-without-layers-takes-minutes-not-hours) built the vat floor as a UV-transparent window that also lets oxygen diffuse through it, and let that oxygen saturate a thin layer of resin sitting right against the glass. That layer, tens of microns thick, never cures. It stays liquid the way a lit match goes out an inch above a pool of gasoline vapor: the chemistry needed to propagate the reaction gets quenched before it can take hold. The team called this the dead zone, and it does the job a release coating or a peel cycle used to do, without any moving parts at all.

With a persistent liquid layer separating the hardening part from the window, the printer never has to let go of anything. A digital light processing unit projects a continuous sequence of cross-sectional images through the window, the build platform draws the part upward at a steady rate, and suction pulls fresh resin in beneath it as the gap opens. [Published in Science in March 2015](https://en.wikipedia.org/wiki/Continuous_liquid_interface_production), the technique demonstrated parts tens of centimeters tall, built at 100-micron resolution, in minutes.

![Two stat tiles: a demonstrated vertical build rate of 500 millimeters per hour, and a reported speed advantage of up to 100 times over conventional stepwise photopolymerization.](/images/insights/the-oxygen-window-that-made-resin-printing-continuous/image2.jpg)
*The numbers behind "continuous": a measured build rate and a public demonstration, both from the technique's 2015 debut.*

Joseph DeSimone, the project's lead inventor, later showed a geometrically intricate part finished in under ten minutes at a public demo, and the inventors described builds running up to 100 times faster than the stepwise methods they were compared against.

The dead zone's thickness isn't a fixed property of the window, it's a balance. Oxygen diffuses in from below at one rate; UV light consumes radicals above it at another. Photon flux, photoinitiator concentration, and a given resin's own reactivity all have to be tuned against each other to hold that balance. Push the light too hard and the dead zone collapses, the part fuses to the window, and the print fails outright. Leave the zone too thick and resolution suffers, because the window no longer anchors a sharp cure front just above it. Getting that balance right, resin by resin, is most of what separates a working machine from a lab demo.

Carbon commercialized the process as Digital Light Synthesis and extended the chemistry past a single cure step. [Most DLS resins cure twice](https://www.additivemanufacturing.media/articles/am-101-continuous-liquid-interface-production-clip): light locks in the part's shape on the printer, then an oven bake of four to thirteen hours drives a second, slower reaction that links the polymer network more densely in every direction, something Carbon describes as molecular weaving. That second cure is why DLS parts come out isotropic rather than layer-dependent, with mechanical behavior closer to an injection-molded part than to a typical stepwise print. That property is what moved the process past prototyping and into production: [adidas's 4DFWD midsoles](https://www.carbon3d.com/carbon-dls-technology), flexible partial dentures and clear aligners built for dental labs, and a cyanate ester bracket flying on NASA's Seeker free-flying robot all depend on a lattice or thin wall holding up the same way no matter which direction the load comes from.

The mechanism has a ceiling worth naming plainly. Dead-zone printing only works for resin chemistries that tolerate oxygen inhibition in the first place, which rules out some fast-curing or oxygen-insensitive formulations outright, and the thermal post-cure adds hours back into a process built to remove waiting. What CLIP actually eliminated was the mechanical bottleneck: the peel-and-reflow cycle that scales with layer count, not with part size. It didn't eliminate cure chemistry's own limits. A decade on, most of the interesting work in this space is still about fitting new resin formulations to the dead zone, rather than reshaping the dead zone to fit the resin.
