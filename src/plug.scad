// Diameters
d = [12.1, 11.5, 7.6, 7.2, 6.6, 6.3];
// Heights
h = [2.6, 6.4, 6.4, 2.4, 13, 4.6];
// x and y dimensions for the stem, plus width of the barb
stem = [3, 2, 9];
// Match the original design or use the more robust design
original = false;
// A very small amount, used in hulls mainly
small = 0.1;
// Resolution of circular objects
$fn = 50;

module plug(d=d, h=h, stem=stem, original=original, small=small, $fn=$fn) {
  cylinder(h=h[0], d1=d[0], d2=d[1]);
  translate([0, 0, h[0]]) {
    cylinder(h=h[1], d1=d[2], d2=d[3]);
    translate([0, 0, h[1]]) {
      cylinder(h=h[2], d1=d[4], d2=d[5]);
      translate([0, 0, h[2]]) {
        hull() {
          translate([0, 0, -0.1]) cylinder(h=small, d=d[5]);
          translate([0, 0, h[3] - small + (original ? 0 : h[4])]) {
            translate([-stem[0] / 2, -stem[1] / 2, 0]) {
              cube([stem[0], stem[1], small]);
            }
            if (!original)
            for(i=[-1:2:1])
            translate([0, i * (stem[1] / 2 - small / 2), 0]) {
              cylinder(h=h[5] + small, d=small);
            }
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
}

plug(d, h, stem, original, small, $fn);
