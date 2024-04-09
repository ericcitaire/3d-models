H = 10;
INNER_W = 50 - 1;
OUTER_W = 72 + 1;
THICKNESS = 3;
X = 30;
ANGLES = [0:120:360];

VASE = true;

$fn = 60;

module tube(d1, d2, o)
{
    if (VASE)
    {
        cylinder(h = H, r1 = d1 / 2, r2 = d2 / 2);
    }
    else
    {
        difference()
        {
            cylinder(h = H, r1 = d1 / 2 + (o > 0 ? o * 2 : 0), r2 = d2 / 2 + (o > 0 ? o * 2 : 0));
            cylinder(h = H, r1 = d1 / 2 + (o < 0 ? o * 2 : 0), r2 = d2 / 2 + (o < 0 ? o * 2 : 0));
        }
    }
}

module m(inner1, inner2, outer1, outer2)
{
    // inner
    difference()
    {
        tube(d1 = inner1, d2 = inner2, o = +THICKNESS);
        for (a = ANGLES)
        {
            rotate(a)
            {
                translate([ 20, 20, 0 ]) cylinder(h = H, d = X + THICKNESS, $fn = 4);
            }
        }
    }

    // outer
    intersection()
    {
        tube(d1 = outer1, d2 = outer2, o = -THICKNESS);
        for (a = ANGLES)
        {
            rotate(a)
            {
                translate([ 20, 20, 0 ]) cylinder(h = H, d = X + THICKNESS, $fn = 4);
            }
        }
    }

    difference()
    {
        for (a = ANGLES)
        {
            rotate(a) difference()
            {
                translate([ 20, 20, 0 ]) cylinder(h = H, d = X + THICKNESS, $fn = 4);
                translate([ 20, 20, 0 ]) cylinder(h = H, d = X, $fn = 4);
            }
        }
        cylinder(h = H, r1 = inner1 / 2, r2 = inner2 / 2);
        difference()
        {
            cylinder(h = H, d = 500);
            cylinder(h = H, r1 = outer1 / 2, r2 = outer2 / 2);
        }
    }
}

translate([ 0, 0, H * 0 ]) m(OUTER_W, OUTER_W, OUTER_W, OUTER_W);
translate([ 0, 0, H * 1 ]) m(OUTER_W, INNER_W, OUTER_W, OUTER_W);
translate([ 0, 0, H * 2 ]) m(INNER_W, INNER_W, OUTER_W, OUTER_W);
translate([ 0, 0, H * 3 ]) m(INNER_W, INNER_W, OUTER_W, OUTER_W);
translate([ 0, 0, H * 4 ]) m(INNER_W, OUTER_W, OUTER_W, OUTER_W);
translate([ 0, 0, H * 5 ]) m(OUTER_W, OUTER_W, OUTER_W, OUTER_W);