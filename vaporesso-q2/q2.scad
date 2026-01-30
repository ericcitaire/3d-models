$fn = $preview ? 40 : 100;

// scale(0.7) translate([-12.4, -21, 0]) #import("/home/ericcitaire/perso/3d-models/q2.svg");


//square([11, 32], center = true);
module in(h = 75) {
    linear_extrude(h) {
        intersection() {
            scale([1, 1.6]) circle(r = 9.5);
            circle(r = 13.5);
        }
    }
}

module charge_indicator() {
    z = 40;
    w = 3;
    h = 30;
    translate([10, 5, z + h / 2])
        rotate([0, 90, 0]) {
            translate([h / 2, 0, 0])
                cylinder(h = 10, d = w, center = true);
            translate([-h / 2, 0, 0])
                cylinder(h = 10, d = w, center = true);
            cube([h, w, 10], center = true);
        }
    translate([13, 5.5, z]) {
        d = 7;
        cylinder(h = h, d = d);
        sphere(d = d);
        translate([0, 0, h]) sphere(d = d);
    }
}

module air_flow() {
    z = 42;
    w = 7;
    h = 20;
    translate([0, -15, z + h / 2])
        rotate([90, 90, 0]) {
            translate([h / 2, 0, 0])
                cylinder(h = 20, d = w, center = true);
            translate([-h / 2, 0, 0])
                cylinder(h = 20, d = w, center = true);
            cube([h, w, 20], center = true);
        }
    translate([0, -20, z]) {
        d = 15;
        cylinder(h = h, d = d);
        sphere(d = d);
        translate([0, 0, h]) sphere(d = d);
    }
}

module usb_port_old() {
    cube([7, 7, 7], center = true);
    translate([0, 4, 0]) cylinder(h = 50, d = 7, center = true);
    translate([0, -4, 0]) cylinder(h = 50, d = 7, center = true);
}

module usb_port() {
    rotate([0, 180, 0]) translate([0, 0, -2]) linear_extrude(height = 5, scale = 1.5) {
        square([7, 7], center = true);
        translate([0, 4, 0]) circle(d = 7);
        translate([0, -4, 0]) circle(d = 7);
    }
}

ear_hole_d = 5;

difference() {
    minkowski() {
        in();
        sphere(3);
    }
    translate([0, 0, 1.2]) in(200);

    charge_indicator();
    
    air_flow();
    
    usb_port();
    
    translate([0, 20, 70]) rotate([0, 90, 35]) cylinder(d = ear_hole_d, h = 100, center = true);
    translate([0, -20, 70]) rotate([0, 90, -35]) cylinder(d = ear_hole_d, h = 100, center = true);
}

module ear(direction) {
    rotate([0, 90, 0]) difference() {
        minkowski() {
            union() {
                cylinder(d = 10, h = 1, center = true);
                translate([7.5, -5 * direction, 0]) cylinder(d = 22, h = 1, center = true, $fn = 3);
            }
            sphere(d = 3);
        }
        cylinder(d = ear_hole_d, h = 100, center = true);
    }
}

difference() {
union() {
#rotate([0, 0, 35]) translate([2, 16, 70]) ear(1);
#rotate([0, 0, -35]) translate([2, -16, 70]) ear(-1);
}
in(200);
}
