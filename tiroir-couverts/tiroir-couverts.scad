external_width = 300;
external_height = 440;
external_depth = 65;
wall_thickness = 5;
width = external_width - wall_thickness * 2;
height = external_height - wall_thickness * 2;
depth = external_depth - wall_thickness;

part = 3;

$fn = 30;

module compartiments() {
    difference() {
        translate([wall_thickness, wall_thickness, wall_thickness]) {
            difference() {
                translate([-wall_thickness + .1, -wall_thickness + .1, -wall_thickness / 2 + .1]) cube([external_width, external_height, external_depth]);
                cube([width, height, depth + 1]);
            }

            w = (width - wall_thickness * 3) / 4;
            h = height / 4 - wall_thickness;
            for (i = [1 : 3]) {
                translate([w * i + wall_thickness * (i - 1), 0, 0]) {
                    cube([wall_thickness, i == 1 ? height : height - h, depth - wall_thickness]);
                    translate([wall_thickness / 2, 0, depth - wall_thickness]) rotate([-90, 0, 0]) cylinder(h = i == 1 ? height : height - h, d = wall_thickness);
                }
            }

            translate([w, height - h, 0]) {
                cube([width - w, wall_thickness, depth - wall_thickness]);
                translate([wall_thickness / 2, wall_thickness / 2, depth - wall_thickness]) rotate([-90, 0, -90]) cylinder(h = width - w - wall_thickness / 2, d = wall_thickness);
            }
        }
        rotate([0, 45, 0]) translate([-5, 0, -5]) cube([10, external_height + 1, 10]);
        rotate([0, 45, 90]) translate([-5, -external_width, -5]) cube([10, external_width + 1, 10]);
        translate([external_width, 0, 0]) rotate([0, 45, 0]) translate([-5, 0, -5]) cube([10, external_height + 1, 10]);
        translate([0, external_height, 0]) rotate([0, 45, 90]) translate([-5, -external_width, -5]) cube([10, external_width + 1, 10]);
    }
}

if (part < 3) {
    rotate(a = [0, -45, 0]) 
    intersection() {
        translate([0, -external_height / 3 * part, 0]) #compartiments();
        cube([external_width * .45, external_height / 3, external_depth]);
    }
} else {
    rotate(a = [0, 45, 0]) 
    intersection() {
        translate([-external_width * .45, -external_height / 3 * (part - 3), 0]) #compartiments();
        cube([external_width * .65, external_height / 3, external_depth]);
    }
}
