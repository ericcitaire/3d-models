import("Flexi-Rex-improved.stl");

$fn = 80;

translate([ 15, 35, 0 ])
{
    intersection()
    {
        translate([ 0, 1, 1.5 ]) difference()
        {
            cylinder(h = 20, r = 5);
            cylinder(h = 20, r = 2);
        }
        translate([ -10, -6, 6 ]) rotate(a = [ -30, 0, 0 ]) rotate(a = [ -15, 80, 0 ])
            cylinder(h = 30, r = 10, $fn = 3);
        translate([ 0, 0, 6 ]) cube(size = [ 100, 100, 10 ], center = true);
    }
}