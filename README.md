# Tube Holder

Parametric OpenSCAD 3D-printable holder for medicine and ointment tubes in a cabinet.

## Project layout

- `src/` — editable, parametric OpenSCAD source (`tube-holder.scad`)
- `exports/` — generated STL / 3MF files for local slicing (not committed by default)
- `photos/` — photos of printed prototypes and the finished part
- `publication/` — descriptions and assets for any eventual publication
- `reference/` — source measurements, sketches, and design references

Empty directories are tracked with `.gitkeep` placeholders.

## Version 2 geometry (155 mm, 5 columns)

| Property | Value |
| --- | ---: |
| Outside dimensions | 155 mm wide × 85 mm deep × 65 mm tall |
| Compartments | 5 columns × 2 rows (10 tubes) |
| Clear interior of each compartment | 35 / 30 / 25 / 25 / 25 mm wide (left to right), each 39.5 mm deep |
| Supported tube cross-section | 33 mm in the 35 mm column; up to 28 mm in the 30 mm column; up to 23 mm in the 25 mm columns (2 mm total width clearance) |
| Solid unperforated base | 10 mm tall |
| Walls above base | 55 mm tall (65 mm total height) |
| Wall thickness | 2 mm dividers and front/back; 3.5 mm left/right outside walls |
| Slots | One top-open vertical slot centered in each cell-facing wall span; 25% of that span omitted |

There are 10 compartments. The additional 3 mm outside the specified clear column widths and standard 2 mm walls is distributed equally to the left and right side walls (each 3.5 mm). The 25% slots are retained. Slots continue to the base's top surface, with the base itself completely intact. All elements form one piece.

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
