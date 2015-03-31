$desired_length=100; // center to center
$width = 3;
$hollow_r = 1.5;
$disk_r = 3;
$height = 1;

$fn = 64;

$length = ($desired_length - $disk_r * 6 / 4) + 2*$disk_r + 1.5;



module make_arm() {
   union () {
      translate([$disk_r,0,0]) {
         cube([$length - ($disk_r*2), $width, $height]);
      }
      translate([$disk_r/2,$width/2,0]) {
         make_ring();
      }
      translate([$length - $disk_r/2,$width/2,0]) {
         make_ring();
      }
   }
}

module make_ring() {
   difference () {
      cylinder(r=$disk_r, h=$height);
      translate([0,0,-1]) {
         cylinder(r=$hollow_r, h=$height+2);
      }
   }
}

make_arm();
translate([0,$width+4,0]) {
   make_arm();
}
translate([0,$width+12,0]) {
   make_arm();
}
translate([0,$width+20,0]) {
   make_arm();
}translate([0,$width+28,0]) {
   make_arm();
}translate([0,$width+36,0]) {
   make_arm();
}

/* // calibration
translate([$disk_r/2,0,0]) {
   cube([$desired_length, 5, 1]);
}
*/