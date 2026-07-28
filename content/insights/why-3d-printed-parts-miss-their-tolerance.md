---
title: "Why 3D-Printed Parts Miss Their Tolerance"
date: 2026-07-27
description: "Dimensional drift in FDM and SLA parts traces back to a specific chain of thermal and cure kinetics — not just printer calibration — and understanding it changes how tolerances should be specified."
featured_image: "/images/insights/why-3d-printed-parts-miss-their-tolerance/hero.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["polymer AM", "dimensional accuracy", "FDM", "SLA", "tolerancing"]
ai_level: "All Machine"
ai_functions: ["Ideation", "Data Collection", "Writing"]
draft: false
---

![Dimensional drift from CAD nominal to as-built polymer part](/images/insights/why-3d-printed-parts-miss-their-tolerance/hero.jpg)
*A part that matches its CAD file in every dimension leaves the printer rarely — shrinkage and warpage are built into the process, not defects in it.*

A polymer part that comes off a printer within a few tenths of a millimeter of its CAD dimensions is often treated as evidence of a well-tuned machine. More often it reflects a favorable geometry. Dimensional error in material extrusion (FDM) and vat photopolymerization (SLA) is not primarily a calibration problem. It is the accumulated output of thermal and cure kinetics, and the two processes differ fundamentally in both. A recent comparative study across FDM, vat photopolymerization, and electron beam melting confirms this. It found that the *pattern* of variability, not just its average magnitude, differs enough between processes that a single tolerance table cannot describe both ([Papazetis et al., 2025](https://www.mdpi.com/2227-9717/13/12/3825)).

In FDM, error accumulates through a thermal history. Each extruded layer cools from near the polymer's glass transition temperature toward ambient. Subsequent layers deposit on top of it, reheating the interface and re-softening a thin band of material before it fully vitrifies. That band then cools again and contracts against material that has already solidified. This generates internal strain that does not relax — it locks in as the layer count grows. The strain is not uniform. It concentrates near the build plate, where the earliest layers are mechanically constrained while later layers above them are still shrinking. That is why warpage in FDM parts characteristically shows up as edge lift and bowing on the first and last few layers, rather than as uniform shrinkage. This mechanism is also why hole diameters, wall thickness, and thermal exposure history show measurably different feature-level accuracy depending on printing direction and geometry — even from a single machine and material ([Rimašauskas et al., 2025](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC11766861/)).

SLA follows a different error path. A vat photopolymerization part cures through a photochemical reaction, not a thermal transition. Its dominant source of dimensional error is cure shrinkage — the volumetric contraction that occurs as monomer converts to a cross-linked polymer network. Light-source optics add a second factor: laser or projector spot size sets a physical floor on achievable feature resolution, one that nozzle geometry does not impose on FDM. That is part of why SLA typically holds tolerances of ±0.05–0.1 mm, versus ±0.2–0.5 mm for FDM. But cure shrinkage still compounds through the build in a directionally dependent way. Comparative mechanical testing of ABS and ABS-like resins across both process families shows the resulting anisotropy in dimension and stiffness is systematic, not incidental — it tracks build orientation and layer interface density in predictable ways ([Bhandari et al., 2023](https://www.ncbi.nlm.nih.gov/pmc/articles/PMC10647641/)).

![Thermal history and cumulative residual strain by layer in FDM printing](/images/insights/why-3d-printed-parts-miss-their-tolerance/figure1.jpg)
*Top: a single FDM layer is repeatedly reheated above its glass transition as subsequent layers deposit, then cools and contracts against already-solid material. Bottom: this contraction accumulates non-uniformly with build height, concentrating strain near the constrained baseplate region — the mechanism behind bottom-edge warpage.*

Tolerance specification in polymer AM is shifting because of this. It is becoming a process-and-geometry-dependent output, not a fixed machine capability. The [ISO/ASTM 52920](https://www.iso.org/standard/76911.html) qualification-principles standard already treats quality assurance as built into the process, not inspected afterward. A newer standard, [ISO/ASTM FDIS 52966](https://www.iso.org/standard/89300.html), pushes further: it categorizes process capability by resource and geometry class instead of issuing one blanket accuracy claim per machine. The implication for engineers is concrete. A drawing tolerance only means something when it is paired with the process, material, orientation, and feature type it was measured against. The same nominal dimension on the same printer can carry a different achievable tolerance depending on where it sits in the build, and on which mechanism — thermal contraction or cure shrinkage — governs that region of the part.

None of this argues that dimensional accuracy in polymer AM is unmanageable. It argues the opposite: accuracy is predictable once the governing mechanism is identified. That is a more useful starting point for design-for-tolerance decisions than treating deviation as machine noise to be calibrated away.
