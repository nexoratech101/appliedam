---
title: "Design for Additive Manufacturing: What Actually Changes When You Print"
date: 2026-06-28
description: "DfAM is not about avoiding print failures. It is about making decisions upstream - orientation, overhangs, wall thickness, support strategy - before the slicer is ever opened."
featured_image: "/images/design-for-additive-manufacturing-what-actually-changes-when-you-print-hero.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["DfAM", "FDM", "topology optimisation", "overhang", "wall thickness", "support structures"]
ai_level: "Oversight"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
---

Most engineers learn to design for the constraint. In machining, it is tool access. In injection moulding, it is draft angles and split lines. In additive manufacturing, the constraints are different - and so is the opportunity.

Design for Additive Manufacturing (DfAM) is the practice of designing parts with the layer-by-layer build process in mind from the start, rather than adapting a design conceived for a different method. Done well, it is not just about avoiding print failures. It is about unlocking geometry that would be impossible any other way.

## Orientation is a Structural Decision

Most practitioners think about orientation in the slicer, when they are trying to minimise supports or fit the part on the build plate. That is the wrong point in the process.

Orientation determines the direction of layer lines relative to the load path of the part in use. In FDM, the bond between layers is consistently weaker than the bond within a layer. A part printed with its critical load path running perpendicular to the layer lines will underperform compared to the same part oriented correctly.

The practical rule: identify the primary stress direction first, then orient the part so that layers stack parallel to it. Treat orientation as a structural decision, then check the support and surface quality implications of that choice.

## Overhang Angles and the 45-Degree Rule

The commonly cited threshold for self-supporting overhangs is 45 degrees from vertical. This holds reasonably well for FDM with standard settings, but several variables shift it - layer height, print speed, material, and part cooling all affect how steep an overhang can go before it needs support.

Design to stay within 45 degrees where possible, and run a simple overhang test on your specific printer and material before relying on the threshold in a functional part. Twenty minutes of testing removes a lot of guesswork.

For SLS the rules shift entirely - unfused powder supports the part throughout the build, so overhangs are not a constraint at all. Process matters; the 45-degree rule is an FDM heuristic, not a universal principle.

## Wall Thickness and Minimum Feature Size

Two constraints that catch designers out more than almost any other.

Wall thickness below roughly 1.2 times the nozzle diameter produces walls the slicer either skips or fills with a single structureless pass. For a 0.4mm nozzle, the practical minimum for a load-bearing wall is around 1.2mm - and 2mm or more for anything structural.

Small holes tend to print undersized because extruded material encroaches inward. For holes that need to fit a fastener, design them 0.2-0.3mm oversize and test fit before finalising. For precision fits, print slightly undersized and drill to final dimension.

## Design Your Way Out of Supports

Support structures carry real costs: material, print time, and post-processing. The better approach is to eliminate the need for them in the design.

Chamfer instead of sharp horizontal overhangs. A 45-degree chamfer is self-supporting; a sharp right-angle ledge is not.

Teardrop profiles for horizontal holes. The pointed top of a teardrop bridges cleanly where a circle would sag.

Split and assemble. Complex parts can often be split into two pieces that each print without supports, then bonded together. This adds one assembly step but produces a cleaner result than extensive support removal.

Where supports are unavoidable, a small air gap between support tip and part surface (0.1-0.2mm) makes removal cleaner at a slight cost to surface quality on the supported face.

## Topology Optimisation and Part Consolidation

These are the two DfAM strategies that most clearly separate additive from subtractive manufacturing.

Topology optimisation removes material from low-stress regions, leaving an organic structure that follows the load path. The geometry it produces - branching, bone-like forms - cannot be machined. It requires simulation tools and careful definition of load cases; the optimised form is only valid for the loads you defined.

Part consolidation redesigns a multi-component assembly as a single printed part. Every joint and fastener in an assembly is a potential failure point and an assembly cost. Before starting any DfAM project on an existing assembly, map which interfaces exist because the manufacturing method required them - those are candidates for elimination.

## The Upstream Mindset

All of these decisions - orientation, overhang angle, wall thickness, support strategy, consolidation - need to be on the table at the concept stage, not the slicer stage.

DfAM choices made early are cheap. The same choices made after a part has been printed and failed cost material, time, and credibility.

The slicer is where you confirm a good design works. It is a poor place to rescue one that was not conceived with the process in mind.