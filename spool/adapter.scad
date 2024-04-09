spool_width = 48;
box_diameter = 50 + 1;
spool_inner_width = 72 + 1;
thickness = 3;
leg_width = 30;
angles = [0:120:360];

$fn = 80;

x = spool_width / 8;

module part(inner1, inner2, outer1, outer2, height)
{
    cylinder(h = height, r1 = inner1 / 2, r2 = inner2 / 2);
    intersection()
    {
        cylinder(h = height, r1 = outer1 / 2, r2 = outer2 / 2);
        for (a = angles)
        {
            rotate(a) translate([ 20, 20, 0 ]) cylinder(h = height, d = leg_width + thickness, $fn = 4);
        }
    }
}

translate([ 0, 0, x * 0 ]) part(spool_inner_width, spool_inner_width, spool_inner_width, spool_inner_width, x);
translate([ 0, 0, x * 1 ]) part(spool_inner_width, box_diameter, spool_inner_width, spool_inner_width, x * 2);
translate([ 0, 0, x * 3 ]) part(box_diameter, box_diameter, spool_inner_width, spool_inner_width, x * 2);
translate([ 0, 0, x * 5 ]) part(box_diameter, spool_inner_width, spool_inner_width, spool_inner_width, x * 2);
translate([ 0, 0, x * 7 ]) part(spool_inner_width, spool_inner_width, spool_inner_width, spool_inner_width, x);