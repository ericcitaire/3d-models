$fn = $preview ? 50 : 150;

scale = .15;

module centered_logo() {
    translate([-425, 648, 0]) import("Apple_logo_black.svg");
}

module flat_leaf() {
    dx = 170;
    d = 460;
    translate([0, 160]) intersection() {
        translate([+dx, 0]) circle(d = d);
        translate([-dx, 0]) circle(d = d);
    }
}

module leaf_in() {
    scale(scale)
    translate([0, 20, 766])
    rotate([41, 0, 0])
    rotate_extrude()
    difference() {
        offset(-1 / scale) flat_leaf();
        translate([-250, 360, 0]) square([500, 800], center = true);
    }
}

module leaf_out() {
    scale(scale)
    translate([0, 20, 766])
    rotate([41, 0, 0])
    rotate_extrude()
    difference() {
        flat_leaf();
        translate([-250, 360, 0]) square([500, 800], center = true);
    }
}

module leaf() {
    difference() {
        leaf_out();
        leaf_in();
    }
}

module flat_apple_half_body() {
    intersection() {
        centered_logo();
        translate([-250, 360, 0]) square([500, 800], center = true);
    }
}

module flat_apple_body() {
    flat_apple_half_body();
    mirror([1, 0, 0]) flat_apple_half_body();
}

module apple_3d_in() {
    scale(scale)
    rotate_extrude()
    difference() {
        offset(-1 / scale) flat_apple_body();
        mirror([1, 0, 0]) square([500, 800]);
    }
}

module apple_3d_out() {
    scale(scale)
    rotate_extrude()
    difference() {
        flat_apple_body();
        mirror([1, 0, 0]) square([500, 800]);
    }
}

module stem_in() {
    h = 100;
    d1 = 60;
    d2 = 50;
    scale(scale)
    translate([0, 0, 700])
    rotate([6, 0, 0])
    translate([0, 0, -.05]) cylinder(h = h + .1, d1 = d1 - 2 / scale, d2 = d2 - 2 / scale);
}

module stem_out() {
    h = 100;
    d1 = 60;
    d2 = 50;
    scale(scale)
    translate([0, 0, 700])
    rotate([6, 0, 0])
    cylinder(h = h, d1 = d1, d2 = d2);
}

module stem() {
    difference() {
        stem_out();
        stem_in();
    }
}

module apple_3d() {
    dh = 450;
    difference() {
        leaf();
        stem_in();
    }
    difference() {
        apple_3d_out();
        apple_3d_in();
        hole_in();
        stem_in();
    }
    intersection() {
        apple_3d_out();
        hole();
    }
    difference() {
        stem();
        apple_3d_in();
        leaf_in();
    }
}

module puck_light() {
    cylinder(d = 60, h = 9);
}

module hole_in() {
    h = 1000;
    d = 450;
    scale(scale)
    translate([-h / 2, -485, 470])
    rotate([0, 90, 0])
    linear_extrude(h)
    circle(d = d - 2 / scale);
}

module hole_out() {
    h = 1000;
    d = 450;
    scale(scale)
    translate([-h / 2, -485, 470])
    rotate([0, 90, 0])
    linear_extrude(h)
    circle(d = d);
}

module hole() {
    difference() {
        hole_out();
        hole_in();
    }
}

difference() {
    apple_3d();
    if ($preview)
    translate([0, -500, 0]) cube([1000, 1000, 1000]);
}


//color("blue") rotate([90, 0, 270]) scale(scale) centered_logo();

