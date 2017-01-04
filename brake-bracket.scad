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

// The outermost shape
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

// A single channel in the bracket for one brake line
module brakeline() {
  translate([5, 2.5, 0])
  union() {
    translate([-(1.25 + 2.5), 0, 0])
      cylinder(r = 1.25, h = 15);

    translate([(-2.5 - 1.25), (-2.5/2), 0])
      cube([2.5, 2.5, 15]);

    cylinder(r = 2.5, h = 15);

    translate([0, -2.5, 0])
      cube([6, 5, 15]);
  }
}

// The four channels in the bracket
module channels() {
  for (i = [0:3]) {
    offset = i * (2.5 + 5) + 2.5;
    translate([0, offset, 0])
      brakeline();
  }
}

module tab() {
  // The vertical support
  difference() {
    cube([7, 1.5, 10.5]);

    scale([1, 1.1, 1]) translate([0, -.1, 0]) rotate([0, 55, 0])
      cube([7, 1.5, 10.5]);

    scale([1, 1.1, 1]) translate([7.5, -.1, 8]) rotate([0, -65, 0])
      cube([7, 1.5, 10.5]);
  }

  // The clippy tabs
  translate([7.75, 0.75, 5]) rotate([0, 0, 135])
  union() {
    rotate([0, 0, -7.5])
      cube([1, 6, 3]);
    rotate([0, 0, 7.5])
      cube([6, 1, 3]);
  }

  translate([0, 0.75, 4.5]) rotate([0, 90, 0])
  intersection() {
    translate([0, -3, 0])
      cube([6, 6, 2]);
    cylinder(r = 3, h = 2);
  }
}

// rotate([0, 0, 180])
tab();

/*
difference() {
  bracket();
  translate([5, 0, -0.1]) scale([1, 1, 1.1])
    channels();
}
*/
