$fn = 100;

width = 133;
height = 152; // 144
thickness = 1.2;

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

module handle(p_offset = 0) {
    intersection() {
        translate([0, 0, -40]) ellipsoid(p_offset);
        cube([100, 12 + p_offset * 2, 50], center = true);
    }
}

module lid() {
    difference() {
        translate([0, 0, thickness / 2]) intersection() {
            cube([width, height, thickness], center = true);
            translate([0, 524, 0]) cylinder(r=600, h=thickness, center=true);
            translate([0, -524, 0]) cylinder(r=600, h=thickness, center=true);
        }
        ellipsoid();
    }

    difference() {
        intersection() {
            handle(+thickness);
            ellipsoid();
        }
        handle();
    }

    // #translate([0, 0, 5]) cube([85, 45, 10], center = true);
    difference() {
        ellipsoid();
        ellipsoid(-thickness);
        translate([0, 0, 100 + thickness]) cube(200, center = true);
        handle();
    }
}

module supports(angle) {
    num = 5;
    supports_width = 35;
    touch_width = 1.2;
    thickness = .6;
    touch_thickness = .6;
    z_offset = -7.3;
    y_offset = 6.6;
    difference() {
        union() {
            translate([0, -y_offset, z_offset]) cube([supports_width, thickness, 100], center = true);
            translate([0, +y_offset, z_offset]) cube([supports_width, thickness, 100], center = true);
        }
        rotate([0, angle, 0]) ellipsoid(+2);
    }
    difference() {
        union() {
            s = supports_width / num;
            for (i = [0 : num]) {
                translate([-supports_width / 2 + s * i, -y_offset, z_offset]) cube([touch_width, touch_thickness, 100], center = true);
                translate([-supports_width / 2 + s * i, +y_offset, z_offset]) cube([touch_width, touch_thickness, 100], center = true);
            }
        }
        rotate([0, angle, 0]) ellipsoid(-.5);
    }
    translate([0, 0, -50 + z_offset]) cube([supports_width * 1.1, y_offset * 2 * 1.1, .6], center = true);
}

angle = 60;
rotate([0, angle, 0]) lid();
#supports(angle);

/*
difference() {
    lid();
    cube(100);
}
*/