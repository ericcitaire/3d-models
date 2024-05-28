











































































































































































































































$fn = 50;

module magnet_holder()
{
    difference()
    {
        cylinder(h = 4, r = 7);
        translate([ 0, 0, 4 - 2.4 ]) cylinder(h = 2.5, r = 5.5);
    }
}

walls = .8;
screen = .4;

difference()
{
    for (x = [0:7])
    {
        for (y = [0:7])
        {
            translate([ x * 8, y * 8, 0 ])
            {
                difference()
                {
                    cube(size = [ 8, 8, 3 ]);
                    translate([ 0 + walls, 0 + walls, screen ]) cube(size = [ 8 - walls * 2, 8 - walls * 2, 3 ]);
                }
            }
        }
    }

    for (i = [ 1, 4, 7 ])
    {
        translate([ i * 8, 8, screen ]) cylinder(h = 5, r = .8);
        translate([ i * 8, 8 * 7, screen ]) cylinder(h = 5, r = .8);
    }
}
difference()
{
    translate([ -walls, -walls, 0 ]) cube(size = [ 8 * 8 + walls * 2, 8 * 8 + walls * 2, 4 ]);
    translate([ 0, 0, screen ]) cube(size = [ 8 * 8, 8 * 8, 4 ]);
}

translate([ 8 * 4, -7, 0 ]) magnet_holder();
translate([ 8 * 4, 8 * 8 + 7, 0 ]) magnet_holder();

translate([ 8 * 4, 8 * 4, 0 ]) cylinder(h = screen, r = 46.5);
difference() {
translate([ 8 * 4, 8 * 4, 0 ]) cylinder(h = 4, r = 46.5);
translate([ 8 * 4, 8 * 4, screen ]) cylinder(h = 4, r = 45);}