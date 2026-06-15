---
title: "Jerk, Junction Deviation & Real Jerk (Cheetah): Smarter Motion in 3D Printing"
date: 2026-06-15
description: ""
featured_image: "/images/case-studies/smart-motion-in-3d-printing/hero.png"
tags: ["3D Printing", "Education", "Innovation", "Jerk"]
author:
  name: "Randima Bandara"
  type: "General contributor"
  email: "randiam005@gmail.com"
  email_public: false
---

If we say 3D printing is an evolution of CNC technology, it wouldn't be far from the truth.

In traditional CNC machining, when the toolhead changes direction, it comes to a complete stop before moving again. But in 3D printing, this behavior causes a big problem, pausing at corners disrupts material flow, often leading to blobs, seams, or layer inconsistencies.

Jerk Control (Marlin's Classic Approach)
To solve this, early firmware like Marlin introduced a concept called "jerk".  In simple terms, jerk allows the print head to change direction without fully stopping by applying a sudden shift in speed. Technically, on a velocity vs. time graph, jerk represents how quickly acceleration changes, a measure of the slope transition.

However, in this classic model, jerk is a static value, a fixed threshold for how abruptly the print head can shift direction. While this approach enables faster prints, it also introduces sudden mechanical strain and visible print artifacts if not carefully tuned.

The Smarter Upgrade: Junction Deviation
With Marlin 2.0, the model evolved. Instead of one fixed jerk value, it introduced Junction Deviation (JD), a dynamic motion control system. JD adapts the print head's speed based on the angle of the upcoming corner. This leads to smoother directional changes, less mechanical stress, and improved surface quality with fewer ringing and ghosting issues.

But there's a trade-off: increasing JD too much can reintroduce vibration and accuracy issues. That's why many printer manufacturers and enthusiasts fine-tune JD to maximize speed while preserving quality.

Going Even Further: UltiMaker Cheetah & Real Jerk
A recent innovation from UltiMaker, called Cheetah Motion Planner, takes motion planning to the next level. Instead of relying on static or dynamic jerk values, it uses "real jerk": the actual rate of acceleration change.

> The kids were stuck in a warehouse surrounded by zombies and had to send a rescue signal using only a computer, some electronics, and a 3D printer.

![Comparison of vibrations relating to input and affecting the print head motion between Marlin and Cheetah.](/images/case-studies/smart-motion-in-3d-printing/image-1.png)
*Comparison of vibrations relating to input and affecting the print head motion between Marlin and Cheetah.*

This leads to a much more refined movement system:

Smooth curves instead of sharp angle shifts
No abrupt stops or direction changes
Lower mechanical stress and reduced vibrations
Improved dimensional accuracy, even at corners, thanks to extrusion compensation techniques like pressure advance

Why It Matters for You
Whether you're a maker, engineer, or print farm operator, these motion control advances bring tangible benefits:

Print faster without losing quality - Speed, acceleration, and jerk are balanced intelligently.
Higher reliability across machines - Motion profiles include safety margins to compensate for part weight, wear, and maintenance differences.
Insane speed potential - Tests show up to 500 mm/s print speeds and 50,000 mm/s² acceleration (with moderation).

Final Thoughts
Motion control may seem like a backend technicality, but it directly impacts your print quality, speed, and machine longevity. From classic jerk to dynamic JD, and now to real jerk via Cheetah, we're witnessing the evolution of smarter, smoother, and faster 3D printing.

> What's your experience with jerk and junction deviation? Have you seen the difference Cheetah or Klipper's smooth cornering makes? Share your insights below!

[https://www.3dmakerengineering.com/blogs/3d-printing/velocity-acceleration-jerk-and-junction-deviation](https://www.3dmakerengineering.com/blogs/3d-printing/velocity-acceleration-jerk-and-junction-deviation)

[https://makershop.co/3d-printer-jerk-and-acceleration-settings/](https://makershop.co/3d-printer-jerk-and-acceleration-settings/)

[https://support.ultimaker.com/s/article/ultimaker-cheetah](https://support.ultimaker.com/s/article/ultimaker-cheetah)

[https://reprap.org/forum/read.php?1,739819](https://reprap.org/forum/read.php?1,739819)

[https://onehossshay.wordpress.com/2011/09/24/improving_grbl_cornering_algorithm/](https://onehossshay.wordpress.com/2011/09/24/improving_grbl_cornering_algorithm/)
