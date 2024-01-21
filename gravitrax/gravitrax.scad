// Height
height = 5; // [5:5:200]
// Wall thickness
wall = 1.2; // [0.4:0.1:2]
// Tolerance
tolerance = .8; // [0:0.1:1]
type = "test"; // ["spacer", "plate"]

/* [Hidden] */

in = 34.8 / 2;
out = 54 / 2;
width = 90;
depth = 3;

x = sqrt(60 * 60 - 30 * 30);

module inset(rr, extra=0) {
    translate([0, 0, 0 - extra]) cylinder(r=rr, h=depth + extra * 2 + tolerance, $fn=6);
    translate([0, 0, depth - extra + tolerance]) cylinder(r1=rr, r2=rr - wall, h=wall + extra * 2, $fn=6);
    translate([0, 0, depth + wall - extra + tolerance]) cylinder(r=rr - wall, h=height - wall + extra * 2 - tolerance * 2, $fn=6);
}

module outset(rr, extra=0) {
    translate([0, 0, 0 - extra]) cylinder(r1=rr - wall, r2=rr, h=height + extra * 2, $fn=6);   
}

module out_wall() {
    difference() {
        outset(out);
        outset(out - wall, .01);
    }
}

module in_wall() {
    difference() {
        inset(in + wall);
        inset(in, .01);
    }
}

module top_wall() {
    difference() {
        cylinder(r=out - wall, h=wall, $fn=6);   
        inset(in, .01);
    }
}

module internal_walls() {
    intersection() {
        difference() {
            for (i = [0 : 3]) {
                rotate([0, 0, i * 60 + 30]) translate([-width / 2, -wall / 2, 0]) cube([width, wall, height]);
            }
            inset(in, .01);
        }
        outset(out);
    }
}

module notches() {
    for (i = [0 : 3]) {
        rotate([0, 0, i * 60]) translate([-150, -wall * 1.5, height]) cube([300, wall * 3, 5]);
    }
}

module spacer() {
    out_wall();
    difference() {
        in_wall();
        notches();
    }
    internal_walls();
    top_wall();
}

module plate_part() {
    difference() {
        union() {
            cylinder(r=x / 1.5, h=wall, $fn=6);   
            difference() {
                in_wall();
                notches();
            }
        }
        inset(in, .01);
    }
}

module plate() {
    ni = 2;
    nj = 2;
    for (i = [0 : ni]) {
        for (j = [0 : nj]) {
            translate([i * x, (i % 2 == 0 ? 0 : +30) + j * 60, 0]) {
                plate_part();
            }
        }
    }
}

if (type == "spacer") {
    spacer();
} else if (type == "plate") {
    plate();
} else if (type == "test") {
    plate_part();
}