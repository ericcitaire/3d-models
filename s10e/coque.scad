x = 142;
y = 70;
z = 8;

$fn = 30;

module main()
{
    cube([ x - z, y - z, z ], center = true);
    for (xx = [ -(x - z), +(x - z) ])
    {
        rotate([ 90, 0, 0 ]) translate([ xx / 2, 0, -(y - z) / 2 ]) cylinder(h = y - z, d = z);
    }
    for (yy = [ -(y - z), +(y - z) ])
    {
        rotate([ 0, 90, 0 ]) translate([ 0, yy / 2, -(x - z) / 2 ]) cylinder(h = x - z, d = z);
    }
    for (xx = [ -(x - z), +(x - z) ])
    {
        for (yy = [ -(y - z), +(y - z) ])
        {
            translate([ xx / 2, yy / 2, 0 ]) sphere(d = z);
        }
    }
}

module front_camera()
{
    linear_extrude(height = z + 5) translate([ 142 / 2 - 25, 0, 0 ]) minkowski()
    {
        square([ 10, 30 ], center = true);
        circle(d = 5);
    }
}

module usb_plug()
{
    translate([ 10, 0, 1 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -x / 2 - 10 ])
    {
        cube([ 6, 7, 20 ], center = true);
        translate([ 0, -3.5, -10 ]) cylinder(d = 6, h = 20);
        translate([ 0, 3.5, -10 ]) cylinder(d = 6, h = 20);
    }
}

module audio_plug()
{
    translate([ -70, -17.5, 0 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -10 ]) cylinder(d = 8, h = 20);
}

module mic()
{
    translate([ 0, 20, 0 ]) rotate([ 0, 90, 0 ]) translate([ 0, 0, -x / 2 - 10 ])
    {
        translate([ 0, 0, 5 ]) cube([ 6, 10, 30 ], center = true);
        translate([ 0, -5, -10 ]) cylinder(d = 6, h = 30);
        translate([ 0, 5, -10 ]) cylinder(d = 6, h = 30);
    }
}

module thumb()
{
    translate([ 45, 53, 0 ]) scale([ 1.5, 1, .7 ]) sphere(20);
}

difference()
{
    scale([ (x + 3) / x, (y + 3) / y, (z + 3) / z ]) main();
    translate([ 0, 0, -5 ]) scale([ (x - 5) / x, (y - 5) / y, 1.1 ]) main();
    main();
    front_camera();
    usb_plug();
    audio_plug();
    mic();
    thumb();
}