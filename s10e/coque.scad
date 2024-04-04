x = 142;
y = 70;
z = 8;
t = 3;

$fn = 60;

module main(offset = 0)
{
    cube([ x - z, y - z, z + offset * 2 ], center = true);
    for (xx = [ -(x - z), +(x - z) ])
    {
        rotate([ 90, 0, 0 ]) translate([ xx / 2, 0, -(y - z) / 2 ]) cylinder(h = y - z, d = z + offset * 2);
    }
    for (yy = [ -(y - z), +(y - z) ])
    {
        rotate([ 0, 90, 0 ]) translate([ 0, yy / 2, -(x - z) / 2 ]) cylinder(h = x - z, d = z + offset * 2);
    }
    for (xx = [ -(x - z), +(x - z) ])
    {
        for (yy = [ -(y - z), +(y - z) ])
        {
            translate([ xx / 2, yy / 2, 0 ]) sphere(d = z + offset * 2);
        }
    }
}

module front_camera()
{
    linear_extrude(height = z + 5) translate([ x / 2 - 25.5, 0, 0 ]) minkowski()
    {
        square([ 4, 25 ], center = true);
        circle(d = 8);
    }
}

module usb_plug()
{
    translate([ 10, 0, .5 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -x / 2 - 10 ])
    {
        cube([ 6.5, 7, 20 ], center = true);
        translate([ 0, -3.5, -10 ]) cylinder(d = 6.5, h = 20);
        translate([ 0, 3.5, -10 ]) cylinder(d = 6.5, h = 20);
    }
}

module audio_plug()
{
    translate([ -70, -17.5, 0 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -10 ]) cylinder(d = 7, h = 20);
}

module mic()
{
    translate([ 0, 18, 0 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -x / 2 - 10 ])
    {
        translate([ 0, 0, 5 ]) cube([ 7, 8, 30 ], center = true);
        translate([ 0, -4, -10 ]) cylinder(d = 7, h = 30);
        translate([ 0, 4, -10 ]) cylinder(d = 7, h = 30);
    }
}

module thumb()
{
    translate([ 45, 53, 0 ]) scale([ 1.3, 1, .6 ]) sphere(20);
}

module volume_buttons_recess()
{
    translate([ 10, -35, 0 ]) rotate([ 0, 90, 0 ]) cylinder(d = 3, h = 50);
}

module volume_buttons_excess()
{
    translate([ 15, -(34 + t), 0 ]) rotate([ 0, 90, 0 ]) cylinder(d = 5, h = 10, $fn = 10);
    translate([ 30, -(34 + t), 0 ]) rotate([ 0, 90, 0 ]) cylinder(d = 5, h = 20, $fn = 10);
}

module face()
{
    translate([ 0, 0, -9 ]) minkowski()
    {
        difference()
        {
            cube([ x, y, z ], center = true);
            translate([ -x / 2, y / 2, z / 2 ]) rotate([ 0, 90, 0 ]) cylinder(h = x, r = z, $fn = 3);
            translate([ -x / 2, -y / 2, z / 2 ]) rotate([ 0, 90, 0 ]) cylinder(h = x, r = z, $fn = 3);
            translate([ -x / 2, y / 2, z / 2 ]) rotate([ 90, 90, 0 ]) cylinder(h = y, r = z, $fn = 3);
            translate([ x / 2, y / 2, z / 2 ]) rotate([ 90, 90, 0 ]) cylinder(h = y, r = z, $fn = 3);
        }
        sphere(r = 3);
    }
}

difference()
{
    union()
    {
        main(offset = t);
        volume_buttons_excess();
    }
    face();
    main();
    front_camera();
    usb_plug();
    audio_plug();
    mic();
    thumb();
    volume_buttons_recess();
}