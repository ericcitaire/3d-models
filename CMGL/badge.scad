$fn = 60;

width = 65;
height = 35;
depth = 1.2;
r = 10;
border = 3;

// translate([0, 0, 3]) square([86, 54], center = true);

difference() {
  union() {
    minkowski() {
      cube([width, height, depth / 3], center = true);
      cylinder(h = 1, r = r - border / 2, center = true);
    }
    difference() {
      translate([0, 0, depth / 4]) minkowski() {
        cube([width, height, depth], center = true);
        cylinder(h = 1, r = r, center = true);
      }
      minkowski() {
        cube([width, height, depth * 3], center = true);
        cylinder(h = 1, r = r - border / 2, center = true);
      }
    }
    translate([0, 20, depth / 2]) cylinder(h = depth, r = 2 + border / 2, center = true);
  }
  translate([0, 20, depth / 2]) cylinder(h = depth * 3, r = 2, center = true);
}
translate([0, 0, 0])
linear_extrude(depth) {
  text("Gabin", size = 12, halign = "center");
}
translate([0, -10, 0])
linear_extrude(depth) {
  text("C.M.G.L", size = 6, halign = "center");
}
translate([25, 5, 0])
  linear_extrude(depth) {
  scale(.05) import("snowflake.svg");
}
translate([20, -20, 0])
  linear_extrude(depth) {
  scale(.07) import("snowflake.svg");
}
translate([-35, -20, 0])
  linear_extrude(depth) {
  scale(.08) import("snowflake.svg");
}
translate([-30, 10, 0])
  linear_extrude(depth) {
  scale(.03) import("snowflake.svg");
}
