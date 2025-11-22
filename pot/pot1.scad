$fn = 60;

internal_radius = 50;
bottom_thickness = 10;
fillet_radius = 12;
height = 120;

module base_2d(main_radius = 50, bump_count = 60) {
            gap = 360 / bump_count;
            bump_radius = 130 / bump_count;
            off = bump_radius / 2;
            echo(gap);
            for (i = [0 : gap : 360]) {
                offset(-off) offset(off) offset(off) offset(-off) {
                    translate([main_radius * sin(i + gap), main_radius * cos(i + gap)])
                        circle(bump_radius);
                    translate([main_radius * sin(i - gap), main_radius * cos(i - gap)])
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
                base_2d(main_radius = internal_radius, bump_count = 40);
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
        cylinder(r1 = internal_radius, r2 = internal_radius + height, h = height);
        cylinder(r1 = internal_radius + height + 1, r2 = internal_radius + 1, h = height);
    }
    // cube(10000);
}
