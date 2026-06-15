---
title: "Lightweight Drone Frame Using Topology-Optimized FDM Parts"
date: 2024-01-20
description: "A student project using topology optimization and FDM to build a drone frame 40% lighter than a standard design."
featured_image: "/images/drone-frame-project.jpg"
author: "Marcus Chen"
categories: ["Case Studies"]
tags: ["FDM", "Topology Optimization", "Drone", "Aerospace", "Student Project"]
draft: false
project_university: "Michigan State University"
project_course: "ME 471 - Advanced Manufacturing"
project_year: "2024"
---

## Project Overview

This project explores how topology optimization combined with FDM additive
manufacturing can produce a competition-grade racing drone frame that is
significantly lighter and stiffer than a conventionally designed equivalent.

The final frame weighs **87 grams** compared to 142 grams for the baseline
design - while maintaining equivalent torsional stiffness under flight loads.

---

## The Problem

Standard racing drone frames are cut from flat carbon fiber plate stock.
This limits geometry to 2.5D shapes and wastes material.

**The question:** Can FDM-printed topology-optimized geometry match the
structural performance of flat carbon fiber plate at lower weight?

---

## Design Process

### Step 1 - Define Load Cases

- Motor thrust - vertical force at each arm tip up to 800g per motor
- Crash impact - horizontal impulse load at arm tips
- Vibration - high-frequency excitation from props at 400-500Hz
- Torsion - twisting loads during aggressive maneuvers

### Step 2 - Topology Optimization

Ran SIMP optimization in nTopology with:

- Objective: Minimize compliance (maximize stiffness)
- Constraint: Retain 35% of original volume
- Load cases: All four flight scenarios weighted by frequency

### Step 3 - Material Selection

| Property | Standard PETG | CF-PETG | Improvement |
|---|---|---|---|
| Tensile Strength | 50 MPa | 78 MPa | +56% |
| Stiffness | 2.1 GPa | 5.8 GPa | +176% |
| Weight | 1.27 g/cc | 1.19 g/cc | -6% |

---

## Results

- Baseline carbon frame failed at 2.8kg per arm
- Topology-optimized FDM frame failed at 2.6kg per arm
- **93% of baseline strength at 61% of the weight**

> **Biggest advantage of FDM:** Repairability. A crashed carbon fiber
> frame is total loss. A printed frame repairs in 45 minutes.

---

## What I Would Do Differently

1. Increase wall count to 8 at arm roots
2. Embed carbon fiber rods along arm length
3. Run fatigue analysis before physical testing

---

*Want to submit your own project? [Submit to AppliedAM](/submit/)*