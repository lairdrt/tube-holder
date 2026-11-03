// Tube Holder: 2 x 5 medicine/ointment tube organizer
// Units: millimeters. Designed for FDM printing flat on its base.
// SPDX-License-Identifier: GPL-3.0-or-later

/* [Overall dimensions] */
width = 155;             // X: left to right
depth = 85;             // Y: front to back
height = 65;             // Total external height, INCLUDING base
base_thickness = 10;     // Solid, unperforated base geometry

/* [Compartments and walls] */
column_widths = [35, 30, 25, 25, 25]; // Clear inside widths, left to right
rows = 2;
wall_thickness = 2;     // Internal divider and front/back wall thickness
slot_fraction = 0.25;   // Fraction of each cell-facing wall span omitted

/* [Fit checks] */
maximum_tube_diameter = 33; // Fits in 35-mm columns only
minimum_tube_diameter = 23; // Fits in 25-mm columns
minimum_fit_clearance = 1.5;  // Minimum clearance across a suitable cell

/* [Preview only] */
show_tube_proxies = false;   // Ghost reference tubes in OpenSCAD preview; never exported

/* [Hidden] */
$fn = 48;
_eps = 0.02;
function widths_sum(i = 0) = i >= len(column_widths) ? 0 : column_widths[i] + widths_sum(i + 1);
function widths_before(c, i = 0) = i >= c ? 0 : column_widths[i] + widths_before(c, i + 1);
columns = len(column_widths);
// Distribute the extra 3 mm to the two side walls, keeping cell sizes exact.
side_wall_thickness = (width - widths_sum() - (columns - 1) * wall_thickness) / 2;
cell_depth = (depth - (rows + 1) * wall_thickness) / rows;
wall_height = height - base_thickness;

assert(columns >= 1 && rows >= 1, "At least one row and column are required");
assert(wall_thickness > 0 && base_thickness > 0 && wall_height > 0,
       "All thicknesses and exposed wall height must be positive");
assert(slot_fraction >= 0 && slot_fraction < 0.8,
       "Slot fraction must be between 0 and 0.8");
assert(side_wall_thickness >= wall_thickness,
       "Overall width too small for these cells and walls");
assert(min(column_widths) >= minimum_tube_diameter + minimum_fit_clearance &&
       max(column_widths) >= maximum_tube_diameter + minimum_fit_clearance &&
       cell_depth >= maximum_tube_diameter + minimum_fit_clearance,
       "Compartments too small for intended tube diameters and clearance");

function cell_width(c) = column_widths[c];
function cell_left(c) = side_wall_thickness + widths_before(c) + c * wall_thickness;
function cell_front(r) = wall_thickness + r * (cell_depth + wall_thickness);
function cell_center_x(c) = cell_left(c) + cell_width(c) / 2;
function cell_center_y(r) = cell_front(r) + cell_depth / 2;

// An uninterrupted plate supports the tubes; all other structures grow upward.
module solid_base() {
    cube([width, depth, base_thickness]);
}

module wall_grid() {
    // Outer boundaries
    translate([0, 0, base_thickness])
        cube([width, wall_thickness, wall_height]);
    translate([0, depth - wall_thickness, base_thickness])
        cube([width, wall_thickness, wall_height]);
    translate([0, 0, base_thickness])
        cube([side_wall_thickness, depth, wall_height]);
    translate([width - side_wall_thickness, 0, base_thickness])
        cube([side_wall_thickness, depth, wall_height]);

    // Four dividers across the width and one across the depth (with 5 x 2 defaults).
    if (columns > 1)
        for (c = [1 : columns - 1])
            translate([cell_left(c) - wall_thickness, 0, base_thickness])
                cube([wall_thickness, depth, wall_height]);

    if (rows > 1)
        for (r = [1 : rows - 1])
            translate([0, cell_front(r) - wall_thickness, base_thickness])
                cube([width, wall_thickness, wall_height]);
}

// Remove one top-open vertical slot in every cell span, from every wall.
// Each slot is 25% of that cell's free span, leaving substantial rail material
// on both sides. Cuts stop at the top of the intact base.
module wall_slots() {
    // Slots in front/back perimeter walls and every front/back divider.
    for (c = [0 : columns - 1]) {
        x_center = cell_center_x(c);
        slot_width = cell_width(c) * slot_fraction;

        translate([x_center - slot_width / 2, -_eps, base_thickness])
            cube([slot_width, wall_thickness + 2*_eps, wall_height + _eps]);
        translate([x_center - slot_width / 2, depth-wall_thickness-_eps, base_thickness])
            cube([slot_width, wall_thickness + 2*_eps, wall_height + _eps]);

        if (rows > 1)
            for (r = [1 : rows - 1])
                translate([x_center - slot_width / 2,
                           cell_front(r) - wall_thickness - _eps, base_thickness])
                    cube([slot_width, wall_thickness + 2*_eps, wall_height + _eps]);
    }

    // Slots in left/right perimeter walls and every left/right divider.
    for (r = [0 : rows - 1]) {
        y_center = cell_center_y(r);
        slot_depth = cell_depth * slot_fraction;

        translate([-_eps, y_center-slot_depth/2, base_thickness])
            cube([side_wall_thickness + 2*_eps, slot_depth, wall_height + _eps]);
        translate([width-side_wall_thickness-_eps, y_center-slot_depth/2, base_thickness])
            cube([side_wall_thickness + 2*_eps, slot_depth, wall_height + _eps]);

        if (columns > 1)
            for (c = [1 : columns - 1])
                translate([cell_left(c) - wall_thickness - _eps,
                           y_center-slot_depth/2, base_thickness])
                    cube([wall_thickness + 2*_eps, slot_depth, wall_height + _eps]);
    }
}

module tube_holder() {
    union() {
        solid_base();
        difference() {
            wall_grid();
            wall_slots();
        }
    }
}

// Non-printing translucent references for checking max/min tube fit in F5 preview.
module reference_tubes() {
    for (r = [0 : rows - 1], c = [0 : columns - 1]) {
        // Show representative round tubes with 2 mm diameter clearance.
        proxy_diameter = min(maximum_tube_diameter, cell_width(c) - 2);
        color(c == 0 ? [0.15, 0.55, 0.85, 0.3] : [0.9, 0.55, 0.18, 0.3])
            translate([cell_center_x(c), cell_center_y(r), base_thickness])
                cylinder(h = r == 0 ? 140 : 105, d = proxy_diameter);
    }
}

tube_holder();
if ($preview && show_tube_proxies)
    reference_tubes();

// Expected defaults: outside 155 x 85 x 65; 2 rows of 35/30/25/25/25 x 39.5 mm.
// Side walls: 3.5 mm each; interior walls: 2 mm.
