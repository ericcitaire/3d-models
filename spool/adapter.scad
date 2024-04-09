spool_width = 12;
box_diameter = 50 + 1;
spool_inner_width = 72 + 1;
thickness = 3;
leg_width = 30;
angles = [0:120:360];

$fn = 80;

module m(inner1, inner2, outer1, outer2, height)
{
    // inner
    difference()
    {
        cylinder(h = height, r1 = inner1 / 2, r2 = inner2 / 2);
        for (a = angles)
        {
            rotate(a) translate([ 20, 20, 0 ]) cylinder(h = height, d = leg_width + thickness, $fn = 4);
        }
    }

    // outer
    intersection()
    {
        cylinder(h = height, r1 = outer1 / 2, r2 = outer2 / 2);
        for (a = angles)
        {
            rotate(a) translate([ 20, 20, 0 ]) cylinder(h = height, d = leg_width + thickness, $fn = 4);
        }
    }
}

translate([ 0, 0, spool_width * 0 ])
    m(spool_inner_width, spool_inner_width, spool_inner_width, spool_inner_width, spool_width / 2);
translate([ 0, 0, spool_width * 0.5 ])
    m(spool_inner_width, box_diameter, spool_inner_width, spool_inner_width, spool_width);
translate([ 0, 0, spool_width * 1.5 ]) m(box_diameter, box_diameter, spool_inner_width, spool_inner_width, spool_width);
translate([ 0, 0, spool_width * 2.5 ])
    m(box_diameter, spool_inner_width, spool_inner_width, spool_inner_width, spool_width);
translate([ 0, 0, spool_width * 3.5 ])
    m(spool_inner_width, spool_inner_width, spool_inner_width, spool_inner_width, spool_width / 2);