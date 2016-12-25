
$inch = 25.4;
$thickness=4;
$shaft_diam=$inch/4;

$detail=64;

module cam_disk(radius, offset) {
    translate([0,0,0]) {
        difference() {
            cylinder(r=radius, h=$thickness, $fn=$detail);
            translate([offset,0,-1]) {
               cylinder(r=$shaft_diam/2, h=$thickness+2, $fn=$detail);
            }
        }
    }
}

$cam_r=20;
$cam_offs=15;
translate([$cam_r, $cam_r, 0]) {
    cam_disk($cam_r,$cam_offs);
}