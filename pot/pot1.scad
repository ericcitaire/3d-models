$fn = $preview ? 30 : 200;

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

module inside(r = 10, b = 10, f = 10, h = 10) {
    cylinder(h = h - b + f + 1, r = r);
    rotate_extrude()
        translate([r - f, 0, 0])
        circle(r = f);
    cylinder(r = r - f, h = f * 2, center = true);
}

module cup(r = 10, b = 10, f = 10, h = 10) {
    intersection() {
        difference() {
            translate([0, 0, b + f])
                inside(r = r + 1, b = b + 1, f = f + 1, h = h);
            translate([0, 0, b + f])
                inside(r = r, b = b, f = f, h = h);
        }
        cylinder(r = r + 1, h = h);
    }
}

difference() {
    intersection() {
        difference() {
            linear_extrude(scale = 1, twist = 0, height = height) {
                base_2d(main_radius = internal_radius, bump_count = 40);
            }
            translate([0, 0, bottom_thickness + fillet_radius])
                inside(r = internal_radius, b = bottom_thickness, f = fillet_radius, h = height);
        }
        cylinder(r1 = internal_radius, r2 = internal_radius + height, h = height);
        cylinder(r1 = internal_radius + height + 1, r2 = internal_radius + 1, h = height);
    }
    difference() {
        translate([0, 0, .5]) infill(r = internal_radius, h = 20);
        cup(r = internal_radius, b = bottom_thickness, f = fillet_radius, h = height);
    }
    if ($preview) cube(10000);
}

module infill(r = 100, h = 100) {
    linear_extrude(scale = 1, twist = 0, height = h)
    offset(-1) offset(1) offset(1) offset(-1)
        for (i = [0 : 15 : 360]) {
            if (i % 2 == 0) {
                hull() {
                    translate([(r - 5) * sin(i), (r - 5) * cos(i), 0])
                        circle(r = 5);
                    circle(r = .5);
                }
            }
        }
}
