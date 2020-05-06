
$petal_r = 10;

$fn=64;
module rosette(n) {
    for (ii = [0 : n] ) {
        rotate([0,0,ii*360/n]) {
            translate([$petal_r*18/15,0,0]) {
                cylinder(r=$petal_r, h=3);
            }
        }
    }
    cylinder(r=10, h=3);
}

$height = 100;
translate([0,0,$height/2]) {
linear_extrude(height = $height, center = true, convexity = 10, scale=3, twist=-100)
 translate([2, 0, 0]) flat_rosette(5);
}


module flat_rosette(n) {
    projection(cut=true) {
        translate([0,0,-1]) rotate([0,0,0]) {
            rosette(n);
        }
    }
}

// flat_rosette(5);

