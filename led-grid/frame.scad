$fn = 80;

walls = 1.2;
screen = .4;
led_x = 8.4;
led_y = 8.0;
led_d = sqrt (led_x * led_x + led_y * led_y);
led_scale_x = 1;
led_scale_y = led_y / led_x;

module
magnet_hole ()
{
  translate ([ 0, 0, 1 ]) cylinder (h = 2.5, r = 5.5);
}

difference ()
{
  translate ([ led_x * 4 + walls / 5, led_y * 4 + walls / 5, 0 ])
      cylinder (h = 4, d1 = led_d * 8 + 10, d2 = led_d * 8 + 5);
  translate ([ 4 * led_x, -7.2 - walls, 0 ]) magnet_hole ();
  translate ([ 4 * led_x, 8 * led_y + walls + 7.6, 0 ]) magnet_hole ();

  translate ([ led_x * 4, led_y * 4, -1 ]) rotate (45)
      cylinder (h = 6, d1 = led_d * 8, d2 = led_d * 8 + 5, $fn = 4);
}