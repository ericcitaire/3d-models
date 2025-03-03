$fn = 70;

gap = 5;

difference() {
    union() {
        cylinder(d = 42, h = 10);
        translate([-16, -16, 0]) cylinder(d = 30, h = 10);
        translate([-38 - gap, -38 - gap, 0]) cylinder(d1 = 70, d2 = 50, h = 135);
        translate([-38 - gap, -38 - gap, 135]) cylinder(d1 = 50, d2 = 20, h = 15);
    }
    translate([0, 0, -1]) cylinder(d = 37, h = 12);
    translate([0, 0, -1]) cube([25, 25, 12]);
    translate([-38 - gap, -38 - gap, -5]) cylinder(d1 = 68, d2 = 48, h = 139);
    translate([-38 - gap, -38 - gap, 134]) cylinder(d1 = 48, d2 = 20, h = 15);
    translate([0, 0, 10]) cylinder(d = 52, h = 70);
    //translate([-88, -100, -5]) cube([50, 100, 300]);
}
