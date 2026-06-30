---
title: "Post-Processing for FDM and SLA: What Each Method Actually Does"
date: 2026-06-29
description: "Sanding, vapor smoothing, curing, painting - what each technique changes, and when it is worth the time."
featured_image: "/images/post-processing-fdm-sla-hero.jpg"
author: "AppliedAM Team"
categories: ["Insights"]
tags: ["Post-Processing", "FDM", "SLA", "Finishing", "Best Practices"]
ai_level: "Oversight"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
---

A part coming off the build plate is rarely the finished product. Whether it needs to look good, fit precisely, or survive outdoors, the gap between "printed" and "done" is post-processing - and most practitioners default to whatever they did last time rather than choosing the method that fits the part.

This is a practical breakdown of what each common post-processing technique actually does, which materials and processes it applies to, and where it can work against you.

---

## Sanding

The most accessible technique and the default for both FDM and SLA. Wet sanding with 800 to 2000 grit produces a smooth surface on PLA and PETG, and cured SLA resin sands exceptionally well given how brittle the material is in other respects.

The tradeoff is time. Sanding is labor-intensive on complex geometry and effectively impossible inside internal cavities or deep crevices. For a simple bracket, twenty minutes with a few grits gets you most of the way there. For an organic shape with internal channels, sanding alone will not reach every surface - which is the case for reaching for vapor smoothing or tumbling instead.

Sanding is also a material-removal process, which means it changes dimensions. On a part with tight tolerances, sand only the surfaces that need it and leave functional mating faces alone.

---

## Vapor Smoothing

Vapor smoothing exposes a printed part to a chemical vapor - acetone for ABS, specialized solvents for nylon - that slightly melts the surface and smooths layer lines without manual abrasion. The result can approach an injection-molded finish on FDM and SLS parts, and the effect reaches into internal channels and complex geometry that sanding cannot touch.

The catch is material specificity and equipment. Acetone vapor smoothing only works on ABS-family materials; PLA does not respond the same way. SLS nylon parts need a different solvent entirely. This is not a technique you improvise with kitchen supplies and good intentions - it requires controlled equipment and ventilation, and the chemicals involved are hazardous if handled carelessly.

The other consideration is dimensional accuracy. Vapor smoothing melts the surface layer, which can shift critical dimensions by tenths of a millimeter if the exposure is not carefully controlled. For a cosmetic part this rarely matters. For a part with a precision fit, it is worth testing on a sacrificial print first.

---

## UV Post-Curing (SLA)

SLA parts come off the printer only partially cured. The photopolymerization reaction that hardens the resin during printing is not complete at the point of removal - post-curing under UV light finishes that reaction, increasing hardness and bringing the part to its intended mechanical properties.

This step is not optional in the way sanding or painting are. A part used without post-curing will be softer and less dimensionally stable than the resin's published specifications suggest. Dedicated post-curing units control wavelength, temperature, and exposure time precisely; a few minutes under a basic UV lamp is a workable substitute for non-critical parts, but will not match the consistency of a proper cure station.

Before curing, SLA parts also need an alcohol or ether wash to remove uncured resin from the surface. Skipping the wash and curing directly tends to leave a tacky, uneven surface.

---

## Tumbling and Vibratory Finishing

Most associated with SLS and metal AM processes, tumbling places parts in a vibrating drum with abrasive media to deburr, smooth, and polish surfaces in bulk. For SLS nylon, this can produce an 80 percent reduction in surface roughness and a satiny, semi-gloss finish - without the labor cost of hand sanding each part individually.

The obvious advantage is throughput: if you are finishing a batch of parts rather than one, tumbling scales far better than manual work. The limitation is that it treats all exposed surfaces the same way - there is no targeting a specific face the way you can with sanding. For parts with features that should stay sharp (engraved text, fine edges), tumbling can soften detail you wanted to keep.

---

## Priming and Painting

For FDM parts that need a cosmetic finish, the standard workflow is sanding, then a sandable filler primer to fill remaining layer-line valleys, then a second sanding pass back to a finer grit, repeated as needed. Two or three primer coats can eliminate visible layer texture entirely on a well-prepared PLA or PETG part. This is the foundation for any painted finish - skipping it leaves layer lines visible through even multiple coats of paint.

For the topcoat itself, rattle-can spray paint works reasonably well on properly primed FDM parts. For more demanding finishes, a two-part polyurethane topcoat gives better durability and a more consistent gloss; acrylic lacquers dry faster and are easier to work with for prototypes where speed matters more than longevity.

SLA parts follow a similar sequence after curing - light sanding, primer, paint - though the smoother starting surface generally needs less prep work than FDM.

---

## Choosing the Right Combination

The decision tree is simpler than the list above might suggest. Start with what the part needs to do:

**Functional part, no cosmetic requirement** - skip most of this. Sanding for fit if there are mating surfaces; UV curing if it is SLA. Nothing else is necessary.

**Cosmetic prototype or display piece** - sanding plus primer plus paint for FDM; sanding plus paint for SLA. Vapor smoothing is an option if the geometry has internal features sanding cannot reach.

**Production-volume batch** - tumbling for throughput on SLS or metal parts; vapor smoothing for FDM/SLS batches where a consistent finish matters more than hands-on labor time per part.

**Tight tolerance part** - minimize material removal. Light sanding only on non-critical surfaces; avoid vapor smoothing unless you have validated the dimensional shift on a test part first.

Whatever the application, account for post-processing time and cost before you commit to a print orientation or process. A part that looks simple to print can become the most labor-intensive item in a batch once finishing is factored in - and that calculation belongs in the planning stage, not as an afterthought once the print is already on the bed.

---

*Working on a finishing process or post-processing workflow worth sharing? AppliedAM features practitioner case studies across the full AM pipeline. Use the submission form to contribute.*