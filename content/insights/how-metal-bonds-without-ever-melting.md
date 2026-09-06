---
title: "How Metal Bonds Without Ever Melting"
date: 2026-09-04
description: "Cold spray fires metal powder fast enough to fuse on impact alone, letting shops rebuild titanium and aluminum aircraft parts without a heat-affected zone, but proving that impact actually produced a sound bond is still the harder half of the problem."
featured_image: "/images/insights/how-metal-bonds-without-ever-melting/image1.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["Cold Spray", "Metal Additive Manufacturing", "Bonding Mechanism", "Nondestructive Testing", "Aerospace Repair"]
ai_level: "All Machine"
ai_functions: ["Ideation", "Data Collection", "Writing"]
draft: false
---

![Horizontal bar chart titled "The Same Powder, Two Very Different Speeds" comparing particle impact velocities: aluminum particles at 300 to 600-plus meters per second, 316L stainless with helium carrier gas at approximately 750 meters per second, and 316L stainless with nitrogen carrier gas at under 500 meters per second](/images/insights/how-metal-bonds-without-ever-melting/image1.jpg)
*Whether a particle bonds or bounces off comes down almost entirely to how fast it was moving when it hit.*

A repair technician can now rebuild a corroded landing-gear housing or a worn turbine casing in metal that never once got hot enough to melt. The process is cold spray: metal powder accelerated through a supersonic nozzle and fired at a surface, where it bonds on impact through sheer mechanical force. No arc, no laser, no furnace. It sounds like it shouldn't work, and for a wide band of velocities, it doesn't.

Fire the powder too slowly and the particles simply bounce off, leaving nothing behind. Fire it fast enough and something else happens: on impact, according to a review of cold spray's material dynamics in the [MDPI journal *Metals*](https://www.mdpi.com/2079-6412/13/2/267), the outer oxide layer on both the particle and the substrate shatters under the strain, and the freshly exposed metal underneath gets pressed into intimate contact. That's the entire bonding mechanism: adiabatic shear instability, not melting. Every particle has to clear this critical velocity to stick at all, and go too far past it and the impact starts eroding the surface instead of building on it. The margin between "bounces off" and "erodes the part" is narrower than it sounds.

Getting particles into that window depends heavily on which gas is doing the pushing. The same 316L stainless steel powder accelerated with nitrogen tops out under 500 meters per second; switch the carrier gas to helium, which is far lighter and expands faster through the nozzle, and the same powder reaches roughly 750 meters per second, per the same review. Aluminum particles in the 5 to 50 micrometer range land somewhere between 300 and 600-plus meters per second depending on size. None of this happens anywhere near melting temperature. Chamber gas can run around 1,100°C, but the particles themselves, per the review, stay "much lower than 800 K", well under the point where the metal's own microstructure would start to change. That's the entire appeal: no heat-affected zone, no thermal residual stress, and no reason a repair to a temperature-sensitive titanium or magnesium aircraft part has to risk the surrounding material the way welding does.

That appeal is already showing up in maintenance hangars. [VRC Metal Systems](https://vrcmetalsystems.com/aerospace-repairs-cold-spray-technology/) describes cold spray restoring rotors, blades, shafts, gearboxes, and turbine components back to their original blueprint dimension rather than scrapping and replacing them, on alloys the company notes are especially sensitive to heat. The equipment is portable enough to reach large airframe structures directly, and the process skips the combustible fuels and hazardous chemical treatments that some traditional repair methods still rely on.

![Diagram titled "Where Cold Spray Inspection Actually Looks" showing four inspection methods as two-segment bars: fluorescent penetrant inspection reaching only the surface, and eddy current, ultrasonic testing, and CT radiology each extending further to reach the bonded interface below](/images/insights/how-metal-bonds-without-ever-melting/image2.jpg)
*Confirming a cold-sprayed bond took hold below the surface is a different problem than confirming it looks fine on top.*

What's less settled is how a shop proves, after the fact, that a given repair actually bonded the way it was supposed to. The standard inspection tool in the field, fluorescent penetrant inspection, only ever examines the surface. A [SBIR solicitation on cold spray nondestructive evaluation](https://www.sbir.gov/node/1696703) is blunt about the gap this leaves: subsurface flaws at the bonded interface, exactly where a weak spray would show up, can go undetected and seed a fatigue crack later. The methods being developed to close that gap, eddy current, ultrasonic testing, and CT radiology, are still being characterized against an ambitious target: a 90 percent probability of detection at 95 percent confidence, not yet a routine guarantee.

Qualification frameworks are catching up to the same limit. A recent aerospace testing program described in [MDPI's *Applied Sciences and Engineering Progress*](https://www.mdpi.com/2673-4591/133/1/178) leaned on pull-off tests under ASTM C633 and cross-section hardness profiling under EN ISO 6507, both of which mean cutting into the part, to demonstrate compliance with EASA repair requirements. The authors are candid that a full picture of what governs bond quality is still missing, calling out "the lack of universal understanding on the CS bonding mechanism" even as their own results held up.

None of that undercuts what cold spray has already proven it can do. It has turned a purely kinetic impact into a repeatable, code-compliant way to put metal back where it belongs, without a melt pool anywhere in the process. What it hasn't done yet is let an inspector trust that bond from the outside looking in.
