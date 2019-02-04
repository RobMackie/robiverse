$fn=64;

/*
  pentagram bolt hole center to center to cirle center makes an
  isosceles triangle. 360/5 = 72 degrees at center and 2 outside
  vertices at 54. Result is that if the measured distance between 
  centers is 64.56 (from inner edge to edge is 54.56mm + diameter
  of 10mm, then the circle inscribed through the centers of the 
  bolt holes will be sine(54) * 64.56/sine(72) => 54.918mm
*/


$p_circumrad = 54.918;
$full_rad = $p_circumrad +15;
$mount_hole_offset = 20;

module make_parts() {
    translate([$full_rad,$full_rad,0]) {
        difference() {
            cylinder(r=$full_rad, h=1);
            translate([0,0,-1]) {
                for ( i = [0 : 4] ){
                    rotate( i * 72, [0, 0, 1])
                    translate([0, $p_circumrad, 0])
                    cylinder(r=4, h=10);
                }
            }
            translate([0,0,-1]) {
                for ( i = [0 : 3] ){
                    rotate( i * 90, [0, 0, 1])
                    translate([0, $mount_hole_offset, 0])
                    cylinder(r=3.5, h=10);
                }
            }
        }
    }
}


$2d = 1;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
}
} else {
    translate([0,0,0]) rotate([0,0,0]) {
        make_parts();
    }
}