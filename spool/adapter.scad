H = 10;
INNER_W = 50;
OUTER_W = 72;
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

// inner
difference()
{
    tube(d1 = INNER_W, d2 = INNER_W, o = +THICKNESS);
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
    tube(d1 = OUTER_W, d2 = OUTER_W, o = -THICKNESS);
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
    cylinder(h = H, r1 = INNER_W / 2, r2 = INNER_W / 2);
    difference()
    {
        cylinder(h = H, d = 500);
        cylinder(h = H, r1 = OUTER_W / 2, r2 = OUTER_W / 2);
    }
}