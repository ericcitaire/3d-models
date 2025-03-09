$fn = $preview ? 15 : 50;

// embossed text
embossed_text = "";
// handle length
length = 125; // [50:250]
/* [Hidden] */
small_length = 20;
/* [Hidden] */
_diameter0 = 25;
/* [Hidden] */
_diameter1 = 18;
/* [Hidden] */
_diameter2 = 15;
/* [Hidden] */
corner_radius = 3;
/* [Hidden] */
big_hole_diameter = 15;
/* [Hidden] */
big_hole_depth = 15;
/* [Hidden] */
small_hole_diameter = 7; 

module skipping_rope_handle_out(d0, d1, d2) {
    minkowski() {
        union() {
            cylinder(d = d0 - corner_radius * 2, h = small_length - corner_radius);
            cylinder(d1 = d1 - corner_radius * 2, d2 = d2 - corner_radius * 2, h = length - corner_radius);
        }
        sphere(r = corner_radius);
    }
}

module skipping_rope_handle_in() {
    translate([0, 0, -corner_radius]) cylinder(d = big_hole_diameter, h = big_hole_depth);
    translate([0, 0, big_hole_depth - corner_radius - .1]) cylinder(d1 = big_hole_diameter, d2 = small_hole_diameter, h = 5);
    cylinder(d = small_hole_diameter, h = length + 5);
}

module skipping_rope_handle(d0, d1, d2) {
    difference() {
        skipping_rope_handle_out(d0, d1, d2);
        skipping_rope_handle_in();
    }
}

skipping_rope_handle(d0 = _diameter0, d1 = _diameter1, d2 = _diameter2);
intersection() {
    translate([0, 0, 50]) rotate([0, 270, 0]) linear_extrude(15, scale = 1.2) text(embossed_text, size = 8, valign = "center", halign = "center");
    skipping_rope_handle(d0 = _diameter0 + 1, d1 = _diameter1 + 1, d2 = _diameter2 + 1);
}
