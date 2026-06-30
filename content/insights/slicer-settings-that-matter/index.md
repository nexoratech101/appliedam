---
title: "Slicer Settings That Actually Matter"
date: 2026-06-29
description: "Your slicer has 200+ parameters. These are the handful that actually change how your part performs."
featured_image: "/images/slicer-settings-that-matter-hero.jpg"
author: "AppliedAM Team"
categories: ["Insights"]
tags: ["Slicer Settings", "FDM", "Best Practices", "Print Quality"]
ai_level: "Oversight"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
---

Open any modern slicer in advanced mode and you are looking at over 200 parameters. Most of them you will never touch. A small number actually determine whether a part looks good, fits correctly, or survives use - and most practitioners either ignore them entirely and run defaults, or tune the wrong ones first.

Here is what actually moves the needle, in the order it is worth tuning.

---

## Walls Before Infill

This is the single most common misunderstanding in slicer settings: infill is treated as the primary lever for part strength, when walls do most of the structural work. The outer shell defines the part's stiffness and impact resistance; infill mainly stops the top and bottom surfaces from sagging.

The practical implication: if a part feels weak, add a wall before you add infill. Two walls is a minimum for basic prints. Three to four walls is the standard for functional parts - brackets, mounts, tool handles. Beyond five walls, the return diminishes and you may as well be printing closer to solid.

With a 0.4mm nozzle and three perimeters, shell thickness works out to roughly 1.2mm. That number alone explains why thin-walled, sparse-infill parts crack along the shell rather than failing internally - the shell was simply too thin for the load.

---

## Infill: Percentage Matters Less Than Pattern

Once walls are dialed in, infill is a secondary lever. For most non-structural prints, 15-20% is plenty - decorative pieces and display models rarely need more. For functional parts under load, 20-40% with the right pattern outperforms higher percentages of the wrong pattern.

Pattern matters more than most practitioners assume:

- **Gyroid** - isotropic strength in all directions, the standard choice for parts under unpredictable load
- **Cubic** - similarly strong in all directions, a reliable general-purpose default
- **Grid** - fast to print but weaker along the Z-axis; fine for parts that are not loaded vertically
- **Lightning** - minimal material, only supports the top surface; appropriate for cosmetic prints with no structural requirement

Beyond roughly 50% infill, adding more walls is a more weight-efficient way to gain strength than continuing to raise infill percentage. If a part still feels weak at 40% infill, the fix is usually another wall, not more infill.

---

## Layer Height: A Detail and Time Tradeoff, Not a Strength Setting

Layer height controls vertical resolution - how visible the stepping is on curved or angled surfaces - and print time. It does not meaningfully affect part strength on its own.

For a 0.4mm nozzle, 0.20mm is the standard balance of quality and speed for most prints. Drop to 0.12-0.16mm for detail that will actually be seen - engraved text, fine surface features, display pieces. Push to 0.28-0.32mm for draft prints, functional prototypes, or test fits where surface finish does not matter. As a rule, layer height should stay between 25 and 75 percent of nozzle diameter; going outside that range risks poor layer adhesion or excessive stepping.

The mistake to avoid is using a fine layer height on a part where no one will see the surface. A large flat panel prints just as functionally at 0.28mm as it does at 0.12mm - the difference is purely print time.

---

## Speed: Split It by Feature, Not One Number for Everything

Modern slicers let you set print speed independently for outer walls, inner walls, infill, and top surfaces. Using a single uniform speed for all of them is the most common speed-related mistake, and the fix is straightforward: slow down what is visible, speed up what is not.

A reliable starting split:

- **Outer wall** - 30-50mm/s. This is what defines visible surface quality; keep it conservative.
- **Inner walls** - 60-80mm/s. Not visible, can move faster without affecting appearance.
- **Infill** - 60-100mm/s. Entirely internal; speed here has essentially no visible cost.
- **First layer** - 20mm/s, regardless of how fast the rest of the print runs. Bed adhesion depends on this layer printing slowly and consistently.

On modern high-speed hardware with input shaping (Bambu, Voron, Prusa MK4), these numbers can scale up significantly. On a standard Bowden-style printer, pushing speed past what the hardware can handle cleanly tends to show up as ringing or poor layer bonding before it shows up as a useful time savings - tune speed up incrementally rather than maxing it out on the first print.

---

## Cooling: The Setting Most Often Ignored Until Something Warps

Fan speed and minimum layer time control how much time each layer has to solidify before the next one is deposited. Get this wrong and the symptoms show up everywhere else - drooping overhangs, rounded tips on thin features, or warping on ABS.

For PLA, 80-100% fan speed after the first few layers is standard, paired with a minimum layer time of 5-10 seconds so the printer slows down automatically on small cross-sections that would otherwise overheat. For ABS, the same aggressive cooling causes the opposite problem - corners warp and layers separate, because ABS needs to cool slowly and evenly to avoid internal stress. Reduce fan speed to 50-70% for ABS rather than applying the PLA playbook by default.

If overhangs are sagging or thin features are tipping over, cooling is usually the first place to look - not layer height, not speed.

---

## Retraction: Solves Stringing, Nothing Else

Retraction pulls filament back into the nozzle slightly before a travel move, reducing the oozing that causes thin strings across a print. It has no effect on strength, surface finish, or dimensional accuracy beyond that one failure mode.

If stringing is a problem, increase retraction distance incrementally rather than jumping to an extreme value - over-retracting wastes time and can cause its own issues, like under-extrusion at the start of the next feature. Enabling combing mode, which routes travel moves over already-printed areas instead of through open air, reduces the opportunities for stringing to occur in the first place and is worth checking before tuning retraction distance aggressively.

---

## What to Leave Alone

Line width, seam placement strategy, infill overlap percentage, acceleration and jerk values - these exist, and tuning them can extract marginal gains, but they are not where print failures or weak parts come from. Default values from your slicer's built-in profiles are well-calibrated for the vast majority of prints. Chasing these settings before walls, infill pattern, cooling, and speed are dialed in is optimizing the wrong thing first.

---

## The Practical Order

If a print is not working - weak, ugly, warped, or failing - tune in this order: walls first, then infill pattern, then cooling, then speed split, then layer height last. Most print quality problems trace back to one of the first three. Layer height gets blamed disproportionately because it is the most visible setting in the slicer interface, but it is rarely the actual cause of a failed or weak part.

---

*Dialed in a slicer profile worth sharing, or found settings that solved a stubborn print problem? AppliedAM features practitioner insights from across the AM community. Use the submission form to contribute.*