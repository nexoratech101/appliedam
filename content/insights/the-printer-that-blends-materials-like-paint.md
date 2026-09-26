---
title: "The Printer That Blends Materials Like Paint"
date: 2026-09-25
description: "A PolyJet printer does not commit to one plastic and stay there. It jets multiple photopolymer resins droplet by droplet under UV light, so a single part can shift from rubber-soft to hard as it prints, the way a paint mixer blends two cans into every shade in between."
featured_image: "/images/insights/the-printer-that-blends-materials-like-paint/featured.jpg"
photo_credit_type: "Image credits"
photo_credit_label: "Image courtesy of"
photo_credit_name: "Stratasys"
photo_credit_url: "https://www.stratasys.com/en/materials/materials-catalog/polyjet-materials/verovivid/"
photo_credit_source: "VeroVivid Materials Catalog"
photo_credit_source_url: "https://www.stratasys.com/en/materials/materials-catalog/polyjet-materials/verovivid/"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["PolyJet", "Material Jetting", "Digital Materials", "Prosthetics", "Multi-Material Printing"]
ai_level: "All Machine"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
aliases:
  - /insights/the-printer-that-blends-materials-like-paint/
---

Mixing paint is a familiar trick. Blend a can of white with a can of red and you get some shade of pink in between, chosen by how much of each you pour. A PolyJet 3D printer does something close to that, except it pours photopolymer resin instead of paint, and it decides the ratio droplet by droplet as it prints ([Stratasys](https://www.stratasys.com/en/materials/material-types/polyjet/)). Rather than loading one plastic and committing to it for an entire part, the printhead jets tiny drops of two or more liquid resins side by side, then cures them instantly with a pass of ultraviolet light. That single move, mixing first and curing immediately, is what lets one printed object range from rubber-soft in one spot to hard and rigid in another, with no visible seam where the two meet.

![A gradient bar chart shows PolyJet digital material hardness spanning from Agilus30 at Shore A 30 to Vero White Plus at Shore D 83, illustrating the continuous range achievable by blending resins](/images/insights/the-printer-that-blends-materials-like-paint/image1.jpg)
*Between a fully rubber resin and a fully rigid one sits every hardness a designer could ask for, chosen droplet by droplet rather than picked from a catalog.*

Each pass lays down a layer between 14 and 55 microns thick, thinner than a human hair at the fine end, and the printhead places droplets at an XY resolution near 42 microns ([Wevolver](https://www.wevolver.com/article/polyjet-3d-printing)). That resolution is what makes the blending look smooth instead of blocky. Instead of an abrupt border between a soft region and a stiff one, the printer can step the ink ratio across dozens of droplets, so a hinge or a joint fades from one material property into another much like a photograph fades from one color to the next, tiny dot by tiny dot. Held to tolerances around ±0.127 mm, those graded transitions land close enough to their design intent that the part behaves the way its digital model predicted, not just the way it looks.

What happens when a printer can hold two entirely different resins in the same printhead at once? Agilus30, one of Stratasys's rubber-like resins, measures around Shore A 30 to 35 on its own, soft enough to flex like a phone case ([GoEngineer](https://www.goengineer.com/blog/stratasys-agilus30-material-guide)). Vero White Plus, a rigid opaque resin, sits near Shore D 83, closer to a hard hairbrush handle ([iamRapid](https://www.iamrapid.com/vero-white-plus-material/)). Blend the two in different ratios and the printer generates dozens of intermediate "digital materials," with properties landing anywhere between those extremes. A machine like the J850 can hold up to seven materials at once, combining them within a single build the way a desktop printer mixes a handful of ink colors into a full photograph.

![A dumbbell chart on a log scale compares elastic modulus and tensile strength ranges achieved through voxel-level material grading in a Duke University study, from 5 megapascals to nearly 1,900 megapascals](/images/insights/the-printer-that-blends-materials-like-paint/image2.jpg)
*Three orders of magnitude in stiffness, produced without swapping a single cartridge, only by changing what gets decided at each voxel.*

Researchers at Duke University pushed that idea down to the smallest unit a jetting printer can control: the individual voxel, the three-dimensional equivalent of a pixel ([Plastics Engineering](https://www.plasticstoday.com/3d-printing/duke-researchers-3d-print-voxel-level-material-properties)). By varying material composition voxel by voxel rather than region by region, their printed samples spanned an elastic modulus from about 5 MPa up to nearly 1,900 MPa, tensile strength as high as 44 MPa, and roughly twice the toughness of parts built from a single uniform resin. That spread, three orders of magnitude in stiffness alone, is not something a printer with one nozzle and one resin could produce. It is only possible because material choice gets decided fresh at every voxel instead of staying fixed for the whole part.

Voxel-level control has already found a genuinely practical home in prosthetic sockets, the interface between a residual limb and its device. A study published through Springer built sockets whose wall stiffness grades continuously from a rigid 75D shell down through the crossover into an 85A inner surface, using voxel-graded TPU rather than a sharp material swap partway through the wall ([Springer](https://link.springer.com/)). That gradient was not cosmetic. Earlier multi-material sockets that bonded a hard shell directly to a soft liner tended to concentrate stress right at that boundary, the exact seam most prone to delaminating under a limb's daily loading. Spreading the transition across many voxels instead of one sharp line distributed that stress over a wider zone rather than letting it pile up at a single interface.

None of this requires a materials science background to notice. Look closely at a PolyJet part built from digital materials and you can sometimes see the transition zone as a faint gradient in color or texture, the same way a well-blended paint job fades between two shades instead of switching abruptly. The printer is doing at the resin level what a photo printer does at the pixel level: choosing a value for every small unit of the object rather than filling in broad, flat regions. That is the real shift PolyJet represents, printing not just an object's shape but its material properties as a continuous, computable surface in their own right.
