$fn = 30;

// From: http://forum.openscad.org/rounded-corners-td3843.html
module fillet(r, h) {
  translate([r / 2, r / 2, 0])
  difference() {
    cube([r + 0.01, r + 0.01, h], center = true);
    translate([r/2, r/2, 0])
    cylinder(r = r, h = h + 1, center = true);
  }
}

module bracket() {
  difference() {
    cube([15, 33, 15]);

    union() {
      translate([0, 0, 8])
        fillet(4, 17);
      translate([0, 33, 8])
      rotate([0, 0, -90])
        fillet(4, 17);
    }
  }
}

bracket();
