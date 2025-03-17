$fn = $preview ? 30 : 80;


d1 = 5;
d2 = 10;
r1 = d1 / 2;
r2 = d2 / 2;
h = 3 * (r2 - r1);
ss = 1.1;
tt = .25;

/*
module a(s = 1) {
    translate([0, 0, -(h / 3) * s]) cylinder(d1 = d1 * s, d2 = d2 * s, h = (h / 3) * s, center = true);
    cylinder(d = d2 * s, h = (h / 3) * s, center = true);
    translate([0, 0, +(h / 3) * s]) cylinder(d1 = d2 * s, d2 = d1 * s, h = (h / 3) * s, center = true);
}

module b(s = 1) {
    hull() {
        translate([-(d2 / 2 + t), 0, 0]) cylinder(d = d2 * s, h = (h / 3) - .05, center = true);
        translate([+(d2 / 2 + t), 0, 0]) cylinder(d = d2 * s, h = (h / 3) - .05, center = true);
    }
}

translate([-(d2 / 2 + t), 0, 0]) a();
translate([+(d2 / 2 + t), 0, 0]) a();

difference() {
    union() {
        translate([0, 0, -(h / 3 + .05)]) b(s = ss * ss);
        translate([0, 0, +(h / 3 + .05)]) b(s = ss * ss);
        hull() {
            translate([0, -3, 0]) cylinder(d = d1, h = h, center = true);
            translate([-3, -3, 0]) cylinder(d = .001, h = h, center = true);
            translate([+3, -3, 0]) cylinder(d = .001, h = h, center = true);
        }
    }
    translate([-(d2 / 2 + t), 0, 0]) a(s = ss);
    translate([+(d2 / 2 + t), 0, 0]) a(s = ss);
}

translate([-(d2 / 2 + t), 0, 0]) a();
translate([+(d2 / 2 + t), 0, 0]) a();

hull() {
    translate([-d2, (d2 * ss * ss) / 4, 0]) cube([10, (d2 * ss * ss) / 2, h / 3 - 1], center = true);
    translate([-(d2 / 2 + t), 0, 0]) cylinder(d = d2, h = h / 3, center = true);
}
hull() {
    translate([+d2, (d2 * ss * ss) / 4, 0]) cube([10, (d2 * ss * ss) / 2, h / 3 - 1], center = true);
    translate([+(d2 / 2 + t), 0, 0]) cylinder(d = d2, h = h / 3, center = true);
}
*/



module in(t = 0) {
    rotate_extrude() {
        polygon([
            [0, 0],
            [0, h],
            [r1 + t, h],
            [r2 + t, h * 2 / 3],
            [r2 + t, h * 1 / 3],
            [r1 + t, 0],
        ]);
    }
}


module out(t = 0) {
    rotate_extrude() {
        union() {
            polygon([
                [0, h],
                [r2, h],
                [r2, h * 2 / 3 + t],
                [0, h * 2 / 3 + t],
            ]);
            polygon([
                [0, h / 3 - t],
                [r2, h / 3 - t],
                [r2, 0],
                [0, 0],
            ]);
        }
    }
}

sp = .8;

translate([+(r2 + sp), 0, 0]) in();
translate([-(r2 + sp), 0, 0]) in();
difference() {
    union() {
        translate([+(r2 + sp), 0, 0]) out(t = tt);
        translate([-(r2 + sp), 0, 0]) out(t = tt);
        translate([-(r2 + sp), -r2, 0]) cube([d2 + sp * 2, d2, h / 3 - tt]);
        translate([-(r2 + sp), -r2, h * 2 / 3 + tt]) cube([d2 + sp * 2, d2, h / 3 - tt]);
        cylinder(d = d2, h = h, $fn = 4);
    }
    translate([+(r2 + sp), 0, 0]) in(t = tt);
    translate([-(r2 + sp), 0, 0]) in(t = tt);
    // translate([-d2, 0, (h / 6) * 3]) rotate([0, 90, 0]) cylinder(d = h / 3 + tt * 2, h = d2 * 2, $fn = 4);
}



difference() { 
    translate([+(r2 + sp), 0, h / 3]) rotate([0, 0, 45]) linear_extrude(h / 3)
        polygon([
            [tt, sp],
            [r2 + tt, r2 + sp],
            [d2 * 1.5, r2 + sp],
            [d2 * 1.5, -r2],
            [0, -r2],
        ]);
    translate([r2 + sp, 0, 0]) cylinder(r = r2 + tt, h = h / 3);
    translate([r2 + sp, 0, h * 2 / 3]) cylinder(r = r2 + tt, h = h / 3);
}

difference() { 
    translate([-(r2 + sp), 0, h / 3]) rotate([0, 0, 135]) linear_extrude(h / 3)
        polygon([
            [0, -sp],
            [0, r2],
            [d2 * 1.5, r2],
            [d2 * 1.5, -(r2 + sp)],
            [r2 + tt, -(r2 + sp)],
        ]);
    translate([r2 + sp, 0, 0]) cylinder(r = r2 + tt, h = h / 3);
    translate([r2 + sp, 0, h * 2 / 3]) cylinder(r = r2 + tt, h = h / 3);
}

