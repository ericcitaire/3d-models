$fn = 60;

internal_radius = 50;
bottom_thickness = 10;
fillet_radius = 3;
height = 120;

module base_2d(main_radius = 50, bump_count = 60, bump_radius = 2) {
            gap = 360 / bump_count;
            echo(gap);
            for (i = [0 : gap : 360]) {
                offset(-1) offset(1) offset(1) offset(-1) {
                    translate([main_radius * sin(i + gap), main_radius * cos(i + gap)])
                        circle(bump_radius);
                    translate([main_radius * sin(i), main_radius * cos(i)])
                        circle(bump_radius);
                }
            }
            circle(main_radius);
}

module bottom_chamfer(r) {
    z = 5;
    cylinder(r = r, h = z);
    translate([0, 0, z]) cylinder(r1 = r, r2 = r + 20, h = 20);
}

difference() {
    intersection() {
        difference() {
            linear_extrude(scale = 1, twist = 0, height = height) {
                base_2d(main_radius = internal_radius + 1);
            }
            translate([0, 0, bottom_thickness + fillet_radius])
                cylinder(h = height - bottom_thickness + fillet_radius + 1, r = internal_radius);
            translate([0, 0, bottom_thickness + fillet_radius]) {
                rotate_extrude(convexity = 10)
                translate([internal_radius - fillet_radius, 0, 0])
                    circle(r = fillet_radius);
                cylinder(r = internal_radius - fillet_radius, h = fillet_radius * 2, center = true);
            }
        }
        union() {
            cylinder(r1 = internal_radius, r2 = internal_radius + 100, h = 100);
            translate([0, 0, 100])
                cylinder(r = internal_radius + 100, h = 1000);
        }
    }
    // cube(10000);
}
