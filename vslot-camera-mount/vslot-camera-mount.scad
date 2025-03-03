$fn = 60;

module vslot_profile() {
    difference() {
        square([20, 20], center = true);
        square([20 - 1.85 * 2, 20 - 1.85 * 2], center = true);
        translate([12.14, 0, 0]) rotate([0, 0, 45]) square([10, 10], center = true);
        translate([-12.14, 0, 0]) rotate([0, 0, 45]) square([10, 10], center = true);
        translate([0, 12.14, 0]) rotate([0, 0, 45]) square([10, 10], center = true);
        translate([0, -12.14, 0]) rotate([0, 0, 45]) square([10, 10], center = true);
    }

    difference() {
        square([20 - 6.2 * 2, 20 - 6.2 * 2], center = true);
        circle(d = 4.2);
    }

    difference() {
        intersection() {
            union() {
                rotate([0, 0, 45]) square([1.5, 100], center = true);
                rotate([0, 0, -45]) square([1.5, 100], center = true);
                translate([(5.5 + 4.5 / 2) * +1, (5.5 + 4.5 / 2) * +1, 0]) square([4.5, 4.5], center = true);
                translate([(5.5 + 4.5 / 2) * -1, (5.5 + 4.5 / 2) * +1, 0]) square([4.5, 4.5], center = true);
                translate([(5.5 + 4.5 / 2) * +1, (5.5 + 4.5 / 2) * -1, 0]) square([4.5, 4.5], center = true);
                translate([(5.5 + 4.5 / 2) * -1, (5.5 + 4.5 / 2) * -1, 0]) square([4.5, 4.5], center = true);
            }
            square([20, 20], center = true);
        }
        circle(d = 4.2);
    }
}

linear_extrude(30) offset(.25) difference() {
    translate([2, 2, 0]) offset(1) square([20, 20], center = true);
    offset(.6) vslot_profile();
    square([20 - 6.2 * 2, 20 - 6.2 * 2], center = true);
    rotate([0, 0, -135]) translate([0, -50, 0]) square([100, 100]);
}

difference() {
    linear_extrude(30) offset(1) union() {
        rotate([0, 0, 45]) translate([25, 0, 0]) square([20, 1], center = true);
        translate([40, 25, 0]) square([30, 1], center = true);
        translate([25, 25, 0]) circle(d = 1);
    }
    translate([40, 20, 15]) rotate([-90, 0, 0]) {
        translate([0, -3.5, 0]) rotate([0, 0, 45]) linear_extrude(10) polygon([[0, 0], [2.5, 0], [0, 2.5]]);
        cylinder(h = 10, d = 5);
    }
}
