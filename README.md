# Tube Holder

Parametric OpenSCAD 3D-printable holder for medicine and ointment tubes in a cabinet.

## Project layout

- `src/` — editable, parametric OpenSCAD source (`tube-holder.scad`)
- `exports/` — generated STL / 3MF files for local slicing (not committed by default)
- `photos/` — photos of printed prototypes and the finished part
- `publication/` — descriptions and assets for any eventual publication
- `reference/` — source measurements, sketches, and design references

Empty directories are tracked with `.gitkeep` placeholders.

## Version 3 geometry (155 mm, 5 columns and back-wall magnet slides)

| Property | Value |
| --- | ---: |
| Main organizer dimensions | 155 mm wide × 85 mm deep × 65 mm tall |
| Envelope including magnet pockets | 155 mm wide × 90 mm deep × 65 mm tall |
| Compartments | 5 columns × 2 rows (10 tubes) |
| Clear interior of each compartment | 35 / 30 / 25 / 25 / 25 mm wide (left to right), each 39.5 mm deep |
| Supported tube cross-section | 33 mm in the 35 mm column; up to 28 mm in the 30 mm column; up to 23 mm in the 25 mm columns (2 mm total width clearance) |
| Solid unperforated base | 10 mm tall |
| Walls above base | 55 mm tall (65 mm total height) |
| Wall thickness | 2 mm dividers and front/back; 3.5 mm left/right outside walls |
| Slots | One top-open vertical slot centered in each cell-facing wall span; 25% of that span omitted |

There are 10 compartments. The additional 3 mm outside the specified clear column widths and standard 2 mm walls is distributed equally to the left and right side walls (each 3.5 mm). The 25% slots are retained. Slots continue to the base's top surface, with the base itself completely intact.

## Back-wall magnet holders (V3)

Two top-loading holders are centered on the **first and last sections of the long back wall** (the rear wall at Y=85 mm). Their centerlines are 21 mm and 139 mm from the left edge. Tube compartments retain their V2 clear dimensions.

- Nominal magnets: **20 mm diameter × 3 mm thick** circular discs, oriented flat against the cabinet's steel wall (the magnet's axis points front-to-back).
- Clear sliding channels: **20.6 mm across × 3.35 mm front-to-back**. The channels are open at the top; the pocket frames are 25 mm wide.
- Offset: the holders extend **5 mm outward** from the original rear face, increasing the maximum overall depth from 85 mm to **90 mm** at only those two points.
- Vertical reach: the outside of each holder extends from Z=65 mm down to Z=37.5 mm (halfway down the 55 mm exposed wall), with a 45-degree lower supporting ramp. The slide's bottom shelf sits at Z=44 mm, so a 20 mm magnet rests with its upper edge at Z=64 mm.
- Rear capture lips: thin 0.8 mm retaining features on the sides keep magnets from popping out backward, but leave the center of the magnetic face exposed. They create approximately **0.8 mm setback** between the maximum magnet rear surface and the cabinet steel; the steel contacts the holder first.
- The new front webs partially cover the existing top-open slots in these **two** back-wall sections. Other slots and all compartment interior dimensions remain unchanged.

**Printing/fit checks:** The CAD render is manifold and a nominal 20 × 3 mm magnet CAD probe fits without interference. Physical magnet tolerances, sliding friction, attraction through the 0.8 mm gap, curved cabinet clearance, and slicer treatment of the 0.8–0.9 mm retention features have not yet been tested. Slice and inspect the pockets carefully before printing; print a short local test section first if fit is uncertain. All elements form one piece.

**Height interpretation:** Height 65 mm is the *total external height*, including the 10 mm base. If 65 mm of wall above the base is desired, change the height parameter to 75.

## Editing and printing

1. Open src/tube-holder.scad in OpenSCAD.
2. Press **F5** to preview; change dimensions at the top of the file or in the Customizer.
3. For a visual fit check, set show_tube_proxies to true; these translucent reference cylinders appear **only in F5 preview**, never in exported geometry.
4. Press **F6** to render, then export as STL. Open it in Bambu Studio.
5. Print **flat on the base**, with no supports. Start with the printer's usual PLA / 0.4 mm nozzle profile and examine the sliced preview before printing.

The 10 mm base is *geometrically solid* (no holes), but normal slicer infill is still used inside it unless you select 100% infill. A fully dense 10 mm base will consume considerably more filament than a conventional infill-based print.

## Windows working copy

Clone from a PowerShell session:

    cd C:\Users\laird\Documents\Projects
    git clone https://github.com/lairdrt/tube-holder.git
    cd tube-holder

If the local directory already contains a Git clone, use git pull --ff-only instead. Avoid overwriting existing local modifications.

## Source and license

OpenSCAD source is in src/tube-holder.scad. The repository's existing GPL-3.0 license applies.
