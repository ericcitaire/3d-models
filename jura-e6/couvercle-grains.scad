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

module ellipsoid(p_offset = 0) {
    radius = 30.0;
    ratio_x = 1.9;
    ratio_y = 1.0;
    ratio_z = 1.0;
    scaled_radius_x = radius * ratio_x + p_offset;
    scaled_radius_y = radius * ratio_y + p_offset;
    scaled_radius_z = radius * ratio_z + p_offset;
    translate([0, 0, 20]) scale([scaled_radius_x / radius, scaled_radius_y / radius, scaled_radius_z / radius]) sphere(radius);
}

module handle() {
    intersection() {
        translate([0, 0, -38]) ellipsoid();
        cube([100, 10, 50], center = true);
    }
}


difference() {
    translate([0, 0, thickness / 2]) intersection() {
        cube([width, height, thickness], center = true);
        translate([0, 524, 0]) cylinder(r=600, h=thickness, center=true);
        translate([0, -524, 0]) cylinder(r=600, h=thickness, center=true);
    }
    ellipsoid(-thickness);
}

difference() {
    intersection() {
        handle();
        ellipsoid(-thickness);
    }
    translate([0, 0, -1]) scale([1, .8, .8]) handle();
}

// #translate([0, 0, 5]) cube([85, 45, 10], center = true);
difference() {
    ellipsoid();
    ellipsoid(-thickness);
    translate([0, 0, 100 + thickness]) cube(200, center = true);
    scale([1, .8, 1]) handle();
}
