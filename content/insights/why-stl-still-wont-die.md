---
title: "Why STL Still Won't Die"
date: 2026-09-16
description: "3D printing has had a better file format than STL for over a decade. Almost everything downloaded online still arrives in the older one, and the reason has little to do with engineering."
featured_image: "/images/insights/why-stl-still-wont-die/image1.jpg"
author: "AppliedAM Editorial Team"
categories: ["Insights"]
tags: ["File Formats", "STL", "3MF", "Slicing", "Software"]
ai_level: "All Machine"
ai_functions: ["Data Collection", "Data Interpretation", "Writing"]
draft: false
aliases:
  - /insights/why-stl-still-wont-die/
---

![Side by side comparison showing STL as geometry-only triangles versus 3MF as a bundled package containing geometry, color, material, units, and print settings](/images/insights/why-stl-still-wont-die/image1.jpg)
*STL and 3MF describe the same shape. Only one of them remembers anything else about it.*

Download almost any free model online and it lands as an STL file: geometry, and nothing else. No color, no specific material, no scale beyond an assumption someone supplies later. That would be a strange choice in 2026. It makes more sense once you know the format was written in 1987, [per Wikipedia's history of it](https://en.wikipedia.org/wiki/STL_(file_format)), by the Albert Consulting Group for Chuck Hull's newly founded 3D Systems, to describe surfaces for stereolithography machines that couldn't have used color or material data anyway. Everyone printing today inherited a file built for a machine that only ever made one material in one color.

Picture STL as a tracing of a curved object rather than a photograph of it: the outline survives, everything about material or color doesn't. STL does this with triangles instead of pencil lines. A model's entire surface, curved or flat, gets approximated as thousands, sometimes millions, of flat facets stitched edge to edge. Wikipedia notes the format carries no scale information at all, so "the units are arbitrary" until a slicer decides what a triangle's dimensions mean in millimeters. There's no field for red, no field for a specific nylon versus a specific PLA, no field for where supports belong. None of that existed for STL to describe, because in 1987 it didn't need to.

That tracing analogy has a catch a real tracing doesn't. An STL mesh has to close on itself exactly, every triangle edge shared by precisely one other triangle and no facet pointing the wrong way, which [Wikipedia documents](https://en.wikipedia.org/wiki/STL_(file_format)) as the format's baseline definition of a valid solid. Miss that by one stray triangle and a slicer either opens a hole nobody modeled or refuses to slice the file at all. [A 2020 GrabCAD blog post](https://blog.grabcad.com/blog/2020/02/10/stop-using-stl-files-for-3d-printing/) lays out the resolution tradeoff that comes with getting the mesh right: export low and a round hole shows up as a visibly faceted "stop sign" approximation of a circle; export high to smooth that out and the file size balloons, because once triangulated, a model can't regain detail it wasn't exported with. Whatever resolution someone picked at export time is the resolution everyone downstream is stuck with.

![A circular hole rendered with 8 triangles showing visible facets next to the same hole rendered with 64 triangles showing a smooth curve](/images/insights/why-stl-still-wont-die/image2.jpg)
*More triangles buy a smoother curve. They also buy a bigger file, and STL locks in whichever tradeoff was made at export.*

None of this is news to the industry. The first fix arrived in 2011, when [ASTM standardized the Additive Manufacturing File format](https://store.astm.org/f2915-11.html), adding color, material, lattice structures, and real units to a mesh-based format for the first time. It solved the technical problem and largely missed the adoption one: outside a handful of CAD packages, AMF never became something an ordinary slicer expected to open. The second attempt landed better. [3MF](https://www.3dnatives.com/en/stl-vs-3mf-280620224/), released in 2015 by a Microsoft-led consortium that grew to include Dassault Systèmes, Autodesk, Stratasys, Ultimaker, and eventually 3D Systems itself, prevents the non-manifold and self-intersecting errors that plague STL by design, and bundles color, material, orientation, and slicer settings into one compressed file. By 2026, 3Dnatives reports that PrusaSlicer, OrcaSlicer, Bambu Studio, and Cura all natively support 3MF, several already as their default save format.

So why does almost every downloaded model still arrive as a triangle soup with no memory of what it's made of? Because a format's usefulness depends on what everyone else already has saved, not just on what it can technically hold. STL's near-forty-year head start means millions of files already sit on the model-sharing sites hobbyists use every week, and nobody is reconverting a library that size. A slicer can default to saving 3MF and still happily open every STL thrown at it, but that only helps once the file being shared was made in 3MF to begin with. Formats rarely get replaced just because a better one exists; they get replaced when switching costs less than staying, and for the printable-model back catalog already online, that math hasn't flipped yet.

For industrial shops, some of that pressure gets routed around rather than waited out. [Pawel Slusarczyk argues in 3D Printing Journal](https://www.3dprintingjournal.com/p/why-we-should-abandon-the-stl-format) that the more durable fix is skipping mesh export entirely, feeding native CAD geometry straight into build-prep software the way GrabCAD Print and a handful of metal AM tools already do, so a parametric model never gets flattened into triangles in the first place. That path suits shops that can standardize on a matched software stack. For anyone printing a model downloaded tonight, the simplest way to see the gap firsthand is to check the extension on the last file you sliced. If it reads STL, you're looking at a color-blind, unit-blind description of a shape, built the way one would have been described in 1987, still doing most of the job forty years later.
