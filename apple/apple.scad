$fn = 60;

scale = .3;

module centered_logo() {
    translate([-425, 648, 0]) import("Apple_logo_black.svg");
}

module leaf() {
    dx = 170;
    d = 460;
    translate([0, 20, 766])
    rotate([41, 0, 0])
    rotate_extrude()
    difference() {
        translate([0, 160]) intersection() {
            translate([+dx, 0]) circle(d = d);
            translate([-dx, 0]) circle(d = d);
        }
        translate([-250, 360, 0]) square([500, 800], center = true);
    }
}

module apple_half_body() {
    intersection() {
        centered_logo();
        translate([-250, 360, 0]) square([500, 800], center = true);
    }
}

module apple_body() {
    apple_half_body();
    mirror([1, 0, 0]) apple_half_body();
}

module apple_hollow_body() {
    difference() {
        apple_body();
        offset(-1 / scale) apple_body();
    }
}

module apple_half_hollow_body() {
    difference() {
        apple_hollow_body();
        mirror([1, 0, 0]) square([500, 800]);
    }
}

module apple_3d() {
    scale(scale) leaf();
    difference() {
        scale(scale) rotate_extrude() apple_half_hollow_body();
            hole(d = 138, h = 402);
    }
    intersection() {
        scale(scale) rotate_extrude() apple_half_body();
        difference() {
            hole(d = 140, h = 400);
            hole(d = 138, h = 402);
        }
    }
}

module puck_light() {
    cylinder(d = 60, h = 9);
}

module hole(d, h) {
    translate([-h / 2, -145, 140]) rotate([0, 90, 0]) linear_extrude(h) circle(d = d);
}


apple_3d();

// color("blue") rotate([90, 0, 270]) scale(scale) centered_logo();

