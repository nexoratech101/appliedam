---
title: "How Dry Is Dry Enough for FDM Filament"
date: 2026-09-12
description: "The chemistry behind filament moisture absorption, and why the popular one-time drying fix holds up far better for some materials than others."
featured_image: "/images/insights/how-dry-is-dry-enough-for-fdm-filament/image1.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["Nylon", "FDM", "Materials Science", "Filament", "Hydrolysis"]
ai_level: "Oversight"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
---

![Diagram of moisture diffusing through a filament spool and flash-boiling at the hot end nozzle](/images/insights/how-dry-is-dry-enough-for-fdm-filament/image1.jpg)
*Ambient moisture diffuses into a filament spool over hours to weeks, then flash-boils the moment it reaches nozzle temperature.*

Ask a room full of FDM practitioners what "dry filament" means and most will describe a single event: a few hours in a dehydrator, done. That answer is now measurable, and the measurements are less reassuring than the ritual suggests.

Start with what the failure actually sounds like. Wet nylon in a hot end pops and crackles as trapped water flashes to steam faster than it can escape through the nozzle orifice, and the symptoms compound from there: stringing, rough surfaces, visible bubbles, and layers that separate under load rather than fuse ([FilamentFeed](https://filamentfeed.com/article/nylon-filament-complete-printing-guide-june-2026)). None of that is cosmetic. It is water doing chemistry to the polymer, not just getting in its way.

The chemistry is well characterized for polyester and polyamide backbones alike: water molecules attack the ester linkages directly, and each successful attack severs the chain and produces a fresh carboxyl end group. That end group is acidic, which accelerates the next attack, so the reaction is self-perpetuating once it starts. Critically, this hydrolytic pathway becomes significant at temperatures as low as roughly 100°C, and in the 100-120°C range it proceeds around 10,000 times faster than ordinary heat-driven thermal degradation ([Rongxin Chen, IntechOpen](https://www.intechopen.com/chapters/39405)). A typical nylon or PETG nozzle runs at 220-260°C. Any moisture that made it into the filament is not merely inconvenient at that temperature; it is reacting on a timescale that thermal degradation alone never reaches.

A 2025 study gives that mechanism actual numbers instead of a warning label. Researchers exposed PA6 nylon filament to 40°C and 80% relative humidity for up to 72 hours, tracking moisture uptake with an exponential model, M = 5.65 × (1 - e^-0.045t), that rose from roughly 1% moisture content dry to about 5.5% at 72 hours ([Gong et al., 2025, MDPI Technologies](https://www.mdpi.com/2227-7080/13/8/376)). Tensile strength and elongation both fell over the same window, and some 72-hour specimens ruptured immediately past the yield point rather than deforming normally. The shape of that curve matters as much as the endpoint: an exponential rise front-loads most of the damage into the first day, which cuts against the comfortable assumption that a spool left out overnight is still basically fine.

![Line chart showing nylon filament moisture content rising on an exponential curve from about 1 percent to 5.5 percent over 72 hours of humidity exposure](/images/insights/how-dry-is-dry-enough-for-fdm-filament/image2.jpg)
*Illustrative reconstruction of the reported PA6 absorption curve; exact study data points are not shown.*

Nylon is the extreme case, not the exception that proves a rule. It can take on close to 10% of its own weight in water, roughly ten times the moisture PLA absorbs under the same conditions ([Wevolver](https://www.wevolver.com/article/how-to-dry-filament)), which is why nylon dry boxes and vacuum bags get so much more attention than anyone gives a spool of PLA. But PETG shares the same ester backbone that the hydrolysis mechanism above describes, and it is not immune, only slower to show it, which is a distinction worth testing rather than assuming.

The part most guides skip is what happens after the dryer. Once removed into an ordinary 45% relative-humidity room, PLA and ABS take two to four weeks to reabsorb meaningful moisture, PETG about one to two weeks. Nylon does it in hours ([printpal](https://printpal.io/wiki/filament-drying-guide)). A single pre-print drying cycle, run at the commonly recommended 70-80°C for eight to twelve hours ([FilamentFeed](https://filamentfeed.com/article/nylon-filament-complete-printing-guide-june-2026)), buys nylon an afternoon of dryness, not a print job's worth, unless the spool goes straight into sealed storage with fresh desiccant afterward.

What actually holds moisture out long-term is boring by comparison: a vacuum-sealed bag or dry box kept under roughly 15% relative humidity, with silica gel desiccant that can be regenerated in an oven at 120°C for three hours once it turns from blue to pink ([printpal](https://printpal.io/wiki/filament-drying-guide)). Filament stored that way is reported to last six months or longer without redrying. The dryer fixes a spool for one job. The vacuum bag is the only step in this whole chain that actually keeps it fixed.
