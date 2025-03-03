$fn = 100;

difference()
{
    union()
    {
        cylinder(h = .6, r = 24);
        cylinder(h = 1.6, r1 = 20, r2 = 18);
        cylinder(h = 5.5, r = 17);
        translate([ 0, 0, 5.5 ]) cylinder(h = 5, r1 = 17, r2 = 11);
    }
    translate([ 0, 0, 5 ]) cylinder(h = 5, r1 = 16, r2 = 10);
    cylinder(h = 5, r = 16);
    translate([ 0, 0, 9 ]) cylinder(h = 5, r = 10);
}