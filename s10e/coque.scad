x = 142;
y = 70;
z = 8;
t = 1.2;

$fn = 20;

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
        square([ 5, 28 ], center = true);
        circle(d = 8);
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

module volume_buttons()
{
    translate([ 10, -33, 0 ]) rotate([ 0, 90, 0 ]) cylinder(d = 5, h = 50);
}

difference()
{
    scale([ (x + t) / x, (y + t) / y, (z + t) / z ]) main();
    translate([ 0, 0, -t ]) scale([ (x - 5) / x, (y - 5) / y, (z + t) / z ]) main();
    main();
    front_camera();
    usb_plug();
    audio_plug();
    mic();
    thumb();
    volume_buttons();
}