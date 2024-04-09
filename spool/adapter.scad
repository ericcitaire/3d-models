H = 10;
INNER_W = 50;
OUTER_W = 72;
THICKNESS = 3;
X = 30;
ANGLES = [0:120:360];

VASE = true;

$fn = 60;

module tube(d, o)
{
    if (VASE)
    {
        cylinder(h = H, d = d);
    }
    else
    {
        difference()
        {
            cylinder(h = H, d = d + (o > 0 ? o : 0));
            cylinder(h = H, d = d + (o < 0 ? o : 0));
        }
    }
}

// inner
difference()
{
    tube(d = INNER_W, o = +THICKNESS);
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
    tube(d = OUTER_W, o = -THICKNESS);
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
    cylinder(h = H, d = INNER_W);
    difference()
    {
        cylinder(h = H, d = 500);
        cylinder(h = H, d = OUTER_W);
    }
}