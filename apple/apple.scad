$fn = $preview ? 20 : 100;

scale = 0.2;
walls = .6;
supports = .4;

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
        offset(-walls / scale) flat_leaf();
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
        offset(-walls / scale) flat_apple_body();
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
    translate([0, 0, -.05]) cylinder(h = h + .1, d1 = d1 - (walls * 2) / scale, d2 = d2 - (walls * 2) / scale);
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
    light_funnel();
}

module hole_in() {
    h = 1000;
    d = 450;
    scale(scale)
    translate([-h / 2, -485, 470])
    rotate([0, 90, 0])
    linear_extrude(h)
    circle(d = d - (walls * 2) / scale);
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

module support_walls_in() {
    linear_extrude(900 * scale)
    scale([scale, scale, 1]) rounded_star();
}

module support_walls_out() {
    linear_extrude(900 * scale)
    offset(supports) scale([scale, scale, 1]) rounded_star();
}

module light_funnel() {
    translate([0, 0, 9])
    cylinder(d1 = 60, d2 = 0, h = 500 * scale);
    cylinder(d = 60, h = 9);
}

module support_walls_3d() {
    difference() {
        support_walls_out();
        support_walls_in();
    }
}

module obj() {
    difference() {
        union() {
            apple_3d();
            intersection() {
                support_walls_3d();
                difference() {
                    apple_3d_in();
                    hole_in();
                }
            }
        }
        puck_light();
        if ($preview)
        translate([0, -500, 0]) cube([1000, 1000, 1000]);
    }
}

obj();

module star() {
    c = 2;
    offset(6)
    for (angle = [0:20:360])
    rotate([0, 0, angle])
    translate([0, 0, -.5])
    polygon([
        [-c, 0],
        [+c, 0],
        [0, angle % 60 == 0 ? 180 : 250],
    ]);
}

module rounded_star() {
    difference() {
        circle(500);
        minkowski() {
            difference() {
                square([5000, 5000], center = true);
                star();
            }
            circle(3);
        }
    }
}


/*
intersection() {
    linear_extrude(714) difference() {
        rounded_star(1 / scale);
        rounded_star();
    }
    difference() {
        apple_3d_in();
        hole_in();
    }
}
$/

//#star();

//#apple_3d();
/*
difference() {
stem_in();
apple_3d_in();
}
*/
//color("blue") rotate([90, 0, 270]) scale(scale) centered_logo();

