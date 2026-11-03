# Tube Holder

Parametric OpenSCAD 3D-printable holder for medicine and ointment tubes in a cabinet.

## Version 1 geometry

| Property | Value |
| --- | ---: |
| Outside dimensions | 150 mm wide × 85 mm deep × 65 mm tall |
| Compartments | 4 columns × 2 rows (8 tubes) |
| Clear interior of each compartment | 35 mm wide × 39.5 mm deep |
| Supported tube cross-section | Up to 33 mm across, with 2 mm width clearance |
| Solid unperforated base | 10 mm tall |
| Walls above base | 55 mm tall (65 mm total height) |
| Wall thickness | 2 mm, perimeter and dividers |
| Slots | One top-open vertical slot centered in each cell-facing wall span; 25% of that span omitted |

Slots continue to the base's top surface, with the base itself completely intact. All elements form one piece.

**Height interpretation:** Height 65 mm is the *total external height*, including the 10 mm base. If 65 mm of wall above the base is desired, change the height parameter to 75.

## Editing and printing

1. Open tube-holder.scad in OpenSCAD.
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

OpenSCAD source is in tube-holder.scad. The repository's existing GPL-3.0 license applies.
