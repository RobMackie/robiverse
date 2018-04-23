// ball pump wheel

/* 
  major_r - is the radius of the main body circle
  bite_r  - is the size of the ball 
              (the circle at the base of pacman's mouth)
  axle_r  - is the size of the hole for the axle
  z_dim   - is the thickness of the material
  detail  - is the $fn passed into the cylinders (face count)
*/     
module ball_pump_wheel(major_r, bite_r, axle_r, z_dim, detail) {
    $cut_z = z_dim+2;
    $bpw_peg=1;
    difference() {
        // main body
        cylinder(r=major_r, h=z_dim, $fn=detail);
        // packman mouth
        translate([major_r/2,0,-1]) {
            hull() {
                cylinder(r=bite_r, h=$cut_z, $fn=detail);
                translate([major_r, major_r/1.5,0]) {
                    cylinder(r=$bpw_peg, h=$cut_z, $fn=detail);
                }
                translate([major_r,-major_r/1.5,0]) {
                    cylinder(r=$bpw_peg, h=$cut_z, $fn=detail);
                }
            }
        }
        // axle hole
         translate([0,0,-1]) {
             cylinder(r=axle_r, h=$cut_z, $fn=detail);
         }
    }
}

//constants
$detail = 64;
$inch = 25.4;

function inch (ii) = ii * $inch;

// Variables for shape, meant to be changed.
// NOTE: "$major_r > $bite_r + $axle_r" by some amount, or the axle hole gets consumed by the "bite wedge"
$vmajor_r=inch(6);   // Size of overall piece
$vbite_r=inch(1);     // radius of nesting circle (ball radius)
$vz_dim = inch(0.5);  // material thickness
$vaxle_r = inch(0.5); // size of axle hole

ball_pump_wheel($vmajor_r, $vbite_r, $vaxle_r, $vz_dim, $detail);
