$fn = 50;

walls = 1.2;
screen = .4;
led = 8.2;

module
led_slot ()
{
  d = sqrt (led * led * 2);
  difference ()
  {
    cube (size = [ led, led, 3 ]);
    translate ([ led / 2, led / 2, screen ]) rotate (45)
        cylinder (h = 3, d1 = d - walls * 3, d2 = d - walls / 3, $fn = 4);
  }
}

module
magnet_holder ()
{
  difference ()
  {
    cylinder (h = 4, r = 7);
    translate ([ 0, 0, 1 ]) cylinder (h = 4, r = 5.5);
  }
}

difference ()
{
  for (x = [0:7])
    {
      for (y = [0:7])
        {
          translate ([ x * led, y * led, 0 ]) { led_slot (); }
        }
    }

  for (i = [ 1, 4, 7 ])
    {
      translate ([ i * led, led, screen ]) cylinder (h = 5, r = 1, $fn = 8);
      translate ([ i * led, led * 7, screen ])
          cylinder (h = 5, r = 1, $fn = 8);
    }
}

difference ()
{
  translate ([ -walls, -walls, 0 ])
      cube (size = [ 8 * led + walls * 2, 8 * led + walls * 2, 4 ]);
  translate ([ 0, 0, screen ]) cube (size = [ 8 * led, 8 * led, 4 ]);
}

translate ([ 4 * led, -7.5, 0 ]) magnet_holder ();
translate ([ 4 * led, 8 * led + 7.5, 0 ]) magnet_holder ();

translate ([ 8 * 4 + walls / 2, 8 * 4 + walls / 2, 0 ])
    cylinder (h = screen, r = 47);
difference ()
{
  translate ([ 8 * 4 + walls / 2, 8 * 4 + walls / 2, 0 ])
      cylinder (h = 4, r = 48);
  translate ([ 8 * 4 + walls / 2, 8 * 4 + walls / 2, screen ])
      cylinder (h = 4, r = 47);
}