$fn = 120;

width = 133;
height = 152; // 144
thickness = 1;

/*
w = 50;
h = 200;
translate([0, 0, h]) rotate([-90, 0, 0]) linear_extrude(1) polygon([[0, 0], [-w / 2, h], [w /2, h], [0, 0]]);
cube([w, 20, 1], center = true);
*/


module handle() {
    intersection() {
        translate([0, 0, -35]) scale([1.9, 1, 1]) sphere(42);
        cube([100, 10, 50], center = true);
    }
}

difference() {
    translate([0, 0, thickness / 2]) intersection() {
        cube([width, height, thickness], center = true);
        translate([0, 524, 0]) cylinder(r=600, h=thickness, center=true);
        translate([0, -524, 0]) cylinder(r=600, h=thickness, center=true);
    }
    scale(.95) translate([0, 0, 20]) scale([1.9, 1, 1]) sphere(x);
}

difference() {
    intersection() {
        handle();
        scale(.95) translate([0, 0, 20]) scale([1.9, 1, 1]) sphere(x);
    }
    translate([0, 0, -1]) scale([1, .8, .8]) handle();
}

// #translate([0, 0, 5]) cube([85, 45, 10], center = true);
x = 30;
difference() {
    translate([0, 0, 20]) scale([1.9, 1, 1]) sphere(x);
    scale(.95) translate([0, 0, 20]) scale([1.9, 1, 1]) sphere(x);
    translate([0, 0, 100 + thickness]) cube(200, center = true);
    scale([1, .8, 1]) handle();
}
