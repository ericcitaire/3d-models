
tolerance = .25;

module tube(d, o, h) {
    linear_extrude(height = h) {
        offset(r = o / 2) {
            difference() {
                circle(d = d + o + tolerance + .001);
                circle(d = d + o + tolerance);
                rotate([0, 0, -45]) square(100);
            }
        }
    }
}

angle = -10;

module obj() {
    difference() {
        rotate([0, angle, 0]) translate([0, 0, -10]) tube(d = 22, o = 2.5, h = 50);
        translate([0, 0, -10]) cube([100, 100, 20], center = true);
        translate([0, 0, 40]) cube([100, 100, 20], center = true);
    }
}

module leg_base(offset = 10) {
    offset(offset)
    polygon([[0, 0], [130, -20], [150, 0], [130, 20]]);
}

module leg() {
    difference() {
        union() {
            linear_extrude(height = 1, scale = 1)
            leg_base();
            translate([0, 0, 1])
            linear_extrude(height = 10, scale = 0)
            leg_base();
        }
        translate([0, 0, -1]) linear_extrude(height = 15, scale = 1.2)
        translate([25, 0, 0]) scale([.7, .7, 1]) leg_base(5);
    }
}

$fn = 30;

o = 2;

obj();
difference() {
    union() {
        rotate([0, 0, -210]) leg();
        rotate([0, 0, 210]) leg();
    }
    rotate([0, angle, 0]) translate([0, 0, -10]) cylinder(d = 22 + tolerance * 2, h = 50);
}
//rotate([0, 0, -220]) leg();
//rotate([0, 0, 220]) leg();

//obj();

// translate([10, -50, 0]) hook();
