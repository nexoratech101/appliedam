---
title: "Printing the Circuit Into the Part"
date: 2026-09-10
description: "A decade after Voxel8 promised a single printer that could wire itself, 3D printed electronics settled into three narrower, more durable techniques instead of the one-machine dream it started from."
featured_image: "/images/insights/printing-the-circuit-into-the-part/featured.jpg"
photo_credit_type: "Image credits"
photo_credit_label: "Photo by"
photo_credit_name: "Embarcados"
photo_credit_source: "Embarcados"
photo_credit_source_url: "https://embarcados.com.br/voltera-imprima-sua-pcb/"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["3D Printed Electronics", "Conductive Filament", "Direct Ink Writing", "Embedded Electronics", "Additive Manufacturing History"]
ai_level: "Oversight"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
---

![A branching diagram traces direct ink writing research at Harvard through Voxel8's 2015 single-machine electronics printer, its later pivot to footwear printing, and the three separate techniques that took its place: embedding real components, printing signal-only conductive traces, and printing multilayer circuit boards](/images/insights/printing-the-circuit-into-the-part/image1.jpg)
*The single-machine promise of 2015 didn't scale. What replaced it was three narrower techniques, each solving a different piece of the same problem.*

At CES in January 2015, a startup called Voxel8 wheeled out a quadcopter that had never touched a soldering iron. Its printer laid down PLA plastic and a silver conductive ink from the same printhead, pausing at intervals so an operator could drop in a motor or a chip, then resuming until the frame, the wiring, and the electronics came off the build plate together, according to coverage of the machine's [debut](https://www.3dprintingindustry.com/news/voxel8-unleashes-electronics-3d-printer-ces-world-39060/). The pitch was straightforward: one machine, one job, a fully wired device with no separate wiring harness at all.

The idea didn't come from nowhere. Voxel8 spun out of the Harvard lab of Jennifer Lewis, whose earlier research had already used the same extrusion principle, a functional ink dispensed layer by layer through a fine nozzle, to print a working lithium-ion microbattery. Direct ink writing was already a proven way to deposit a material that needed to do something besides hold a shape, and conductive silver ink was simply the next material in that lineage. Pairing it with a structural thermoplastic in a single dual-material printhead looked, in 2015, like the obvious next step.

It didn't become the field's default machine. Voxel8's own trajectory says more than any spec sheet could: the company that opened by promising to print working circuits eventually [redirected almost entirely toward footwear and fabric](https://3dprint.com/283963/fabric-and-electronics-3d-printing-firm-voxel8-bought-by-kornit-digital/), printing textile uppers rather than wired electronics, before Kornit Digital acquired it outright for that textile work. The single-machine, single-job vision from CES never became how the field actually builds printed electronics a decade later. What replaced it wasn't one winning successor but three separate lanes, each narrower than Voxel8's original pitch and each built around a different piece of the same underlying problem.

The first lane sidesteps printed conductors almost entirely. Rather than depositing ink, a print pauses mid-job so an operator can drop a genuine resistor, LED, or microcontroller into a cavity designed into the model, then resumes and prints over it. [Markforged's own documentation](https://markforged.com/resources/blog/embedding-components-in-3d-printed-parts) treats this as routine: a cavity needs roughly 0.08mm of clearance per face to account for print tolerance, and the component has to go in quickly, since a bed that's had time to cool loses layer adhesion at that seam. It is unglamorous next to printing a working circuit outright, but it has become the hobbyist and prototyping default, because it uses electronics that are already known to work.

The second lane does print the conductor, and runs straight into the limit Voxel8's ink was quietly trying to get around. Carbon-loaded conductive PLA measures somewhere around 10 to 30 ohm-centimeters, against roughly 0.0000017 ohm-centimeters for solid copper wire, a gap of seven orders of magnitude that [filament resistivity data compiled this year](https://filamentfeed.com/article/conductive-filament-electronics-3d-printing-june-2026) puts in concrete terms: a modest 100-milliamp signal through a 500-ohm printed trace drops 50 volts and dissipates 5 watts, enough to melt the part carrying it.

![A horizontal bar chart on a logarithmic scale compares bulk resistivity: copper wire at 1.7 times 10 to the negative 6 ohm-centimeters, carbon nanotube composite at 0.1, graphene-doped filament at 1, and carbon-black conductive PLA at 10 ohm-centimeters](/images/insights/printing-the-circuit-into-the-part/image2.jpg)
*Seven orders of magnitude separate a printed trace from a piece of wire, which is why printed conductors carry signals and copper still carries power.*

Printed conductive traces do real work in capacitive touch panels, flex sensors, and LED signal lines, but nobody routes motor power or relay current through them. The material was never going to close a seven-order-of-magnitude gap, and the field stopped pretending it would.

The third lane skipped the resistivity problem by printing something closer to an actual circuit board. Aerosol jet and inkjet systems from companies including Optomec and Nano Dimension deposit dielectric and conductive layers in alternating passes, building genuine multilayer boards with plated interconnects instead of a single conductive trace on a plastic shell, a capability [surveyed early in the field's industrial phase](https://www.digitalengineering247.com/article/state-electronic-3d-printing) already supporting production work like conformal smartphone antennas and printed strain sensors on turbine blades. It is the closest thing to Voxel8's original ambition, minus the print-it-in-one-job-with-ordinary-plastic part. A Nano Dimension DragonFly system runs [roughly $400,000](https://www.aniwaa.com/guide/3d-printers/electronics-3d-printing-explained/), a professional circuit-board-house investment, not a desktop one.

A decade on, the field never converged on Voxel8's one-machine answer, and there is little sign it is about to. What it converged on instead is specialization: embed a real component where one already exists, print a signal trace where the current stays low, and reach for a purpose-built PCB printer where the circuit genuinely has to carry power. That is a quieter story than a quadcopter that wired itself at CES, but it is the one that kept working after the demo ended.
