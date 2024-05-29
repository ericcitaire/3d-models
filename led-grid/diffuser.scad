$fn = 50;

walls = 1.2;
screen = .4;
led_x = 8.4;
led_y = 8.0;
led_d = sqrt (led_x * led_x + led_y * led_y);
led_scale_x = 1;
led_scale_y = led_y / led_x;

module
led_slot ()
{
  difference ()
  {
    translate ([ led_x / 2, led_y / 2, screen ])
        scale ([ led_scale_x, led_scale_y, 1 ]) rotate (45) cylinder (
            h = 3, d1 = led_d - walls * 3, d2 = led_d - walls / 3, $fn = 4);
  }
}

module
magnet_holder ()
{
  difference ()
  {
    cylinder (h = 4, r = 7.5);
    translate ([ 0, 0, 1 ]) cylinder (h = 4, r = 5.5);
  }
}

difference ()
{
  translate ([ -.4, -.4, 0 ])
      cube ([ led_x * 8 + walls, led_y * 8 + walls, 3 ]);

  for (x = [0:7])
    {
      for (y = [0:7])
        {
          translate ([ x * led_x, y * led_y, 0 ]) { led_slot (); }
        }
    }

  for (i = [ 1, 4, 7 ])
    {
      translate ([ i * led_x, led_y, screen ])
          cylinder (h = 5, r = 1, $fn = 8);
      translate ([ i * led_x, led_y * 7, screen ])
          cylinder (h = 5, r = 1, $fn = 8);
    }
}

difference ()
{
  translate ([ -walls, -walls, 0 ])
      cube (size = [ 8 * led_x + walls * 2.5, 8 * led_y + walls * 2.5, 4 ]);
  translate ([ -.4, -.4, screen ])
      cube (size = [ 8 * led_x + walls, 8 * led_y + walls, 4 ]);
}

translate ([ 4 * led_x, -7.2 - walls, 0 ]) magnet_holder ();
translate ([ 4 * led_x, 8 * led_y + walls + 7.6, 0 ]) magnet_holder ();

translate ([ led_x * 4 + walls / 5, led_y * 4 + walls / 5, 0 ])
    cylinder (h = screen, d = led_d * 8 + 2);
difference ()
{
  translate ([ led_x * 4 + walls / 5, led_y * 4 + walls / 5, 0 ])
      cylinder (h = 4, d = led_d * 8 + 5);
  translate ([ led_x * 4 + walls / 5, led_y * 4 + walls / 5, screen ])
      cylinder (h = 4, d = led_d * 8 + 3);
}