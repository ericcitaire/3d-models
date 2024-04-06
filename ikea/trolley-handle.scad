$fn = 80;

difference()
{
    union()
    {
        // import(file = "trolley-handle-base.stl");
        difference()
        {
            union()
            {
                translate([ 0, 54, 0 ]) rotate([ 90, 0, 0 ]) cylinder(h = 108, r = 12.5);
                translate([ 0, 54, 4 ]) rotate([ 90, 0, 0 ]) cylinder(h = 108, r = 10, $fn = 6);
            }
            translate([ 0, 55, 0 ]) rotate([ 90, 0, 0 ]) cylinder(h = 110, r = 8.5);
            translate([ 0, 0, -50 ]) cube([ 1000, 1000, 100 ], center = true);
        }
        for (i = [ -46, +46 ])
        {
            translate([ 0, i, 0 ]) cylinder(h = 12, r = 3);
            translate([ 0, i, 4.5 ]) cylinder(h = 5, r1 = 0, r2 = 5);
        }
    }
    for (i = [ -46, +46 ])
    {
        translate([ 0, i, -1 ]) cylinder(h = 14, r = 1);
        translate([ 0, i, 8 ]) cylinder(h = 5, r1 = 0, r2 = 5);
    }
}