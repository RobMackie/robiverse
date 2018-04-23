// ball pump wheel

//constants
$detail = 64;
$inch = 25.4;

// Variables for shape, meant to be changed.
// NOTE: "$major_r > $bite_r + $axle_r" by some amount, or the axle hole gets consumed by the "bite wedge"
$major_r=inch(6);   // Size of overall piece
$bite_r=inch(1);     // radius of nesting circle (ball radius)
$z_dim = inch(0.5);  // material thickness
$axle_r = inch(0.5); // size of axle hole

// utility variables
$cut_z = inch($z_dim+2);
$peg = 1;

function inch (ii) = ii * 25.4;

difference() {
    // main body
    cylinder(r=$major_r, h=$z_dim, $fn=$detail);
    // packman mouth
    translate([$major_r/2,0,-1]) {
        hull() {
            cylinder(r=$bite_r, h=$cut_z, $fn=$detail);
            translate([$major_r, $major_r/1.5,0]) {
                cylinder(r=$peg, h=$cut_z, $fn=$detail);
            }
            translate([$major_r,-$major_r/1.5,0]) {
                cylinder(r=$peg, h=$cut_z, $fn=$detail);
            }
        }
    }
    // axle hole
     translate([0,0,-1]) {
         cylinder(r=$axle_r, h=$cut_z, $fn=$detail);
     }
    
}