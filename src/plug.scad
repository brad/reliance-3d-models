d = [12.1, 11.5, 7.6, 7.2, 6.3, 6];
h = [2.6, 6.4, 6.4, 2.4, 13, 4.6];
stem = [3, 2, 8.3];
small = 0.1;

$fn = 50;

cylinder(h=h[0], d1=d[0], d2=d[1]);
translate([0, 0, h[0]]) {
  cylinder(h=h[1], d1=d[2], d2=d[3]);
  translate([0, 0, h[1]]) {
    cylinder(h=h[2], d1=d[4], d2=d[5]);
    translate([0, 0, h[2]]) {
      hull() {
        translate([0, 0, -0.1]) cylinder(h=small, d=d[5]);
        translate([-stem[0] / 2, -stem[1] / 2, h[3] - small]) {
          cube([stem[0], stem[1], small]);
        }
      }
      translate([0, -stem[1] / 2, h[3]]) {
        translate([-stem[0] / 2, 0, 0]) {
          cube([stem[0], stem[1], h[4]]);
        }
        translate([-stem[2] / 2, 0, h[4]])
        hull() {
          cube([stem[2], stem[1], small]);
          translate([stem[2] / 2 - small / 2, 0, h[5] - small]) {
            cube([small, stem[1], small]);
          }
        }
      }
    }
  }
}
