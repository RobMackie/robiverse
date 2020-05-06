
$petal_r = 20;

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

module flat_rosette(n) {
    projection(cut=true) {
        translate([0,0,-1]) rotate([0,0,0]) {
            rosette(n);
        }
    }
}

module curve() {
    
    difference() {
        cylinder(r=100, h=3);
        translate([0,0,-1]) {
            cylinder(r=98, h=5);
        }
        translate([00,-100,-1]) {
            cube([200,100,5]);
        }
        translate([0,0,-1]) {
            cube([200,100,5]);
        }        
        translate([-500,-5,-1]) {
            cube([500, 10, 20]);
        }
    }
}

/*
rotate_extrude(angle=360, convexity=100) {
    rotate([0,90,0]) {
        
        curve();
    }
}
*/

module 2D_curve() {
    projection(cut=true) {
        translate([100,100,-1]) rotate([0,0,0]) {
            //curve();
            rosette(14);
        }
    }   
}

rotate_extrude(angle=360, convexity=100) {
    2D_curve();
}



/*
// flat_rosette(5);
$height = 300;
translate([0,0,$height/2]) {
linear_extrude(height = $height, center = true, convexity = 10, scale=3, twist=-250)
 translate([0, 0, 0]) flat_rosette(5);
}
*/
/*
    projection(cut=true) {
        translate([0,0,-1]) rotate([0,0,0]) {
            finished();
        }
    }
*/
