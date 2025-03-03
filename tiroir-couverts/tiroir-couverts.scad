external_width = 300;
external_height = 440;
external_depth = 65;
wall_thickness = 1.5;
width = external_width - wall_thickness * 2;
height = external_height - wall_thickness * 2;
depth = external_depth - wall_thickness;

part = 0;

$fn = 30;

module compartiments()
{
    difference()
    {
        translate([ wall_thickness, wall_thickness, wall_thickness ])
        {
            difference()
            {
                translate([ -wall_thickness + .1, -wall_thickness + .1, -wall_thickness + .1 ])
                    cube([ external_width, external_height, external_depth ]);
                cube([ width, height, depth + 1 ]);
            }

            w = (width - wall_thickness * 3) / 4;
            h = height / 4 - wall_thickness;
            for (i = [1:3])
            {
                translate([ w * i + wall_thickness * (i - 1), 0, 0 ])
                {
                    cube([ wall_thickness, i == 1 ? height : height - h, depth ]);
                }
            }

            translate([ w, height - h, 0 ])
            {
                cube([ width - w, wall_thickness, depth ]);
            }
        }
        chanfrein = wall_thickness * 0;
        rotate([ 0, 45, 0 ]) translate([ -chanfrein / 2, 0, -chanfrein / 2 ])
            cube([ chanfrein, external_height + 1, chanfrein ]);
        rotate([ 0, 45, 90 ]) translate([ -chanfrein / 2, -external_width, -chanfrein / 2 ])
            cube([ chanfrein, external_width + 1, chanfrein ]);
        translate([ external_width, 0, 0 ]) rotate([ 0, 45, 0 ]) translate([ -chanfrein / 2, 0, -chanfrein / 2 ])
            cube([ chanfrein, external_height + 1, chanfrein ]);
        translate([ 0, external_height, 0 ]) rotate([ 0, 45, 90 ])
            translate([ -chanfrein / 2, -external_width, -chanfrein / 2 ])
                cube([ chanfrein, external_width + 1, chanfrein ]);
    }
}

// compartiments();
if (part < 3)
{
    intersection()
    {
        translate([ 0, -external_height / 3 * part, 0 ]) #compartiments();
        cube([ external_width * .45, external_height / 3, external_depth ]);
    }
}
else
{
    intersection()
    {
        translate([ -external_width * .45, -external_height / 3 * (part - 3), 0 ]) #compartiments();
        cube([ external_width * .65, external_height / 3, external_depth ]);
    }
}