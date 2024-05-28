hole_d = 3;
esp32_holes_spacing_w = 23;
esp32_holes_spacing_h = 47;
led = 8.2;

$fn = 50;

difference ()
{
  translate ([ 5, 5, 0 ]) minkowski ()
  {
    cube ([ 50, 50, .4 ]);
    cylinder (h = .4, r = 5);
  }
  x = 2.8;
  translate ([ -x, -x, 0 ]) for (i = [ 1, 4, 7 ])
  {
    translate ([ i * led, led, -1 ]) cylinder (h = 5, r = 1, $fn = 8);
    translate ([ i * led, led * 7, -1 ]) cylinder (h = 5, r = 1, $fn = 8);
  }
}
module
entretoise ()
{
  difference ()
  {
    cylinder (h = 2.5, d = hole_d + 3);
    translate ([ 0, 0, .1 ]) cylinder (h = 2.5, d = 2, $fn = 8);
  }
}

difference ()
{
  union ()
  {
    gap = 3;
    translate ([ gap, 30 - esp32_holes_spacing_w / 2, .8 ]) entretoise ();
    translate ([ gap, 30 + esp32_holes_spacing_w / 2, .8 ]) entretoise ();
    translate (
        [ gap + esp32_holes_spacing_h, 30 - esp32_holes_spacing_w / 2, .8 ])
        entretoise ();
    translate (
        [ gap + esp32_holes_spacing_h, 30 + esp32_holes_spacing_w / 2, .8 ])
        entretoise ();
  }
  translate ([ 0, 30 - 9, .8 ]) cube ([ 60, 18, 3 ]);
}