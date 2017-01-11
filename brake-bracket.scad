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
      translate([0, 0, 7.5])
        fillet(4, 15);
      translate([0, 33, 7.5])
      rotate([0, 0, -90])
        fillet(4, 15);
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

    // Brake lines are 4.75mm (cut 5mm)
    cylinder(r = 2.5, h = 15);

    translate([0, -2.5, 0])
      cube([5, 5, 15]);
  }
}

// The four channels in the bracket
module channels() {
  for (i = [0:3]) {
    offset = i * (2.5 + 5) + 2.5;

    // The three lower channels are brake lines.
    // The fourth channel is a vacuum line and it is wider.
    if (i < 3) {
      translate([0, offset, 0])
        brakeline();
    } else {
      // 1.35 * 5mm channel = 6.75. Vacuum line is 6.5mm.
      translate([-1, offset - 1, 0]) scale([1.35, 1.35, 1])
        brakeline();
    }
  }
}

module tab() {
  // The back support. The mounting hole is a rounded
  // rectangle 10mm x 5.5mm.
  translate([2.75, 2.75, 0])
    cylinder(r = 2.75, h = 4);

  translate([2.75, (10 - 2.75), 0])
    cylinder(r = 2.75, h = 4);

  translate([0, 2.75, 0])
    cube([5.5, (10 - 5.5), 4]);

  // Back support to pass through the wall
  translate([2.75, (10 - 5.5) + 0.5, 4])
    cylinder(r=2.75, h=2);
}

translate([-6, 16.5 - 5, 5.5]) rotate([0, 90, 0])
  tab();

difference() {
  bracket();

  translate([5, 0, 0])
    channels();
}
