
$inch = 25.4;
$corner_r = $inch;
$h = 1;
$length = 8*$inch;
$width = 3*$inch; 

$len = $length - 2*$corner_r;
$wid = $width - 2 * $corner_r;
module makeit() {
    union() {
        difference() {
            hull() {
                //origin
                translate([$corner_r, $corner_r,,0]) {
                    cylinder(r=$inch, h=$h);
                }
                // out the y axis
                translate([$corner_r,$corner_r+$wid,0]) {
                    cylinder(r=$inch, h=$h);
                }
                // out the x axis
                translate([$corner_r+$len,$corner_r,0]) {
                    cylinder(r=$inch, h=$h);
                }
                // kitty corner to the origin
                translate([$corner_r+$len,$corner_r+$wid,0]) {
                    cylinder(r=$inch, h=$h);
                }
            }
            
            translate([$corner_r,$corner_r,-1]) {
                linear_extrude(height = fanwidth, center = true, convexity = 10, twist = -fanrot, slices = 20, scale = 1.0) {
                    scale([3,3,1]) text("Mail Box");
                }
            }
            translate([$corner_r/2,$corner_r/2,-1]) {
                cylinder(r=4, h=5);
            }
        }
        translate([69,25,0]) {
            cube([3, 30, 5]);
        }
        translate([123,25,0]) {
            cube([3, 30, 5]);
        } 
        translate([149,25,0]) {
            cube([3, 30, 5]);
        }  
    }
}
$2d = 1;
if ($2d) {
    projection(cut=true) {
        makeit();
    }
} else {
    makeit();
}
