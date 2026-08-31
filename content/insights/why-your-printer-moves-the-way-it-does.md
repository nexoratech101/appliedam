---
title: "Why Your Printer Moves the Way It Does"
date: 2026-08-27
description: "The frame geometry that carries a printer's nozzle around the build plate, not the nozzle itself, decides how fast it can print cleanly, and software can only compensate for so much of what geometry gets wrong."
featured_image: "/images/insights/why-your-printer-moves-the-way-it-does/featured.jpg"
photo_credit_type: "Image credits"
photo_credit_label: "Photo by"
photo_credit_name: "ZMorph All-in-One 3D Printers"
photo_credit_url: "https://unsplash.com/@zmorph3d"
photo_credit_source: "Unsplash"
photo_credit_source_url: "https://unsplash.com/photos/macbook-pro-beside-3d-printer-FB1vd3XT_zQ"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["3D Printer Kinematics", "CoreXY", "Delta Printers", "Input Shaping", "Klipper", "Hobbyist AM"]
ai_level: "All Machine"
ai_functions: ["Ideation", "Data Collection", "Writing"]
draft: false
---

![Diagram comparing three 3D printer motion systems side by side: a bedslinger with the bed sliding on the Y axis, a CoreXY printer with a stationary bed and belt-driven gantry, and a delta printer with three parallel arms suspending a central effector](/images/insights/why-your-printer-moves-the-way-it-does/image1-v2.jpg)
*Three machines, three ways of getting a hot nozzle to the same X, Y, Z coordinate. The geometry that gets it there shapes almost everything downstream.*

Print the same file on two machines running the same firmware and the same filament, and the results can still look nothing alike. One comes out with faint, repeating waves along every vertical edge. The other comes out clean at twice the speed. The nozzle did not change. The slicer settings did not change. What changed is the machine's kinematics, the physical arrangement of motors, belts, and rails that gets the nozzle from one point to the next, and it turns out to be one of the least visible decisions in a printer's design and one of the most consequential.

Most desktop printers still ship as bedslingers, where the build plate itself rides back and forth on the Y axis while the toolhead handles X and Z. It is a simple, cheap layout, and it is also the reason a tall print can wobble: the bed is dragging the entire growing part with it on every pass. CoreXY machines solve this by bolting both X and Y motors to the frame and driving the toolhead through a pair of crossed belts, so the bed only ever moves up and down. As [FlashForge's comparison explains](https://www.flashforge.com/blogs/news/corexy-vs-bed-slinger), the toolhead moves "without carrying the weight of the motors," which cuts the moving mass enough that the printer can accelerate harder without shaking itself apart, while a bedslinger's heavier, part-laden bed means "aggressive acceleration can create more vibration, ringing, or layer-shift risk."

Delta printers take a different approach entirely, and skip a Cartesian grid altogether. Three towers, each with a carriage sliding vertically, connect through diagonal rods to a single lightweight effector that carries the nozzle. Move all three carriages in coordinated fashion and the effector can reach any point in the build volume, a scheme firmware works out through inverse kinematics rather than simple axis addition. According to [3D Mag's breakdown of the geometry](https://www.3dmag.com/3d-wikipedia/delta-3d-printer-delta-kinematics-fast-3d-printing/), the original RepRap Rostock design targeted an effector under fifty grams, light enough to support genuinely startling acceleration figures on later commercial machines. The cost shows up at the edges of the build volume, where small errors in arm length or tower angle amplify fastest and calibration becomes a multi-variable problem instead of a single Z-offset.

Whatever the geometry, quick direction changes ring the frame like a bell, and that vibration prints itself into the plastic as ghosting on either side of every sharp feature. [Klipper's documentation](https://www.klipper3d.org/Resonance_Compensation.html) is blunt about the cause: "ringing is caused by mechanical vibrations in the printer due to quick changes of the printing direction," and it names loose belts, flexible frames, and heavy moving mass as the usual suspects, the same properties that separate a bedslinger from a CoreXY from a delta in the first place.

![Two overlaid waveform plots showing accelerometer readings from a 3D printer toolhead: a jagged, high-amplitude trace before input shaping is applied, and a much flatter trace at the same print speed after shaping is enabled](/images/insights/why-your-printer-moves-the-way-it-does/image2-v2.jpg)
*Same toolhead, same speed, same direction change. The difference between the two traces is a shaped motion command rather than a stiffer frame.*

So why does a CoreXY machine still ring at all, if it already sheds so much moving mass? Because mass is only one variable. Belt tension, frame stiffness, and even how well a part bed is bolted down all feed the same resonance, and every printer has some natural frequency at which it wants to vibrate once disturbed. Push the toolhead's direction changes anywhere near that frequency and the ringing gets worse regardless of how light the gantry is.

Input shaping is the software answer, and it is worth understanding as compensation rather than a cure. Klipper generates a shaped motion command built from multiple carefully timed pulses instead of one, so the resulting vibrations cancel each other out before they ever reach the frame. Different shaper profiles trade duration for robustness: the fast MZV shaper only tames vibration within a narrow band around the measured resonance frequency, while broader shapers like EI sacrifice some sharpness to tolerate more frequency drift. But [the project's own documentation is explicit](https://github.com/Klipper3d/klipper/blob/master/docs/Resonance_Compensation.md) that a genuinely loose belt or flexing frame should be fixed first, because no shaping algorithm rescues a machine that is mechanically unsound to begin with.

None of this requires a lab to observe. Print a tall test object with a sharp corner and look for faint ripples running up one face but not the other. That asymmetry usually points straight at which axis is carrying more mass, and which part of the machine's kinematics is doing the most work to keep it under control.
