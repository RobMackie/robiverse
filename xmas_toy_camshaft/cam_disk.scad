
$inch = 25.4;
$thickness=4;

$shaft_diam=$inch/4;

$detail=64;

$bit_diam=3.175;

$cam_r=1*$inch;
$displacement=0.5;
$cam_offs=$cam_r*$displacement;

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


translate([$cam_r, $cam_r, 0]) {
    for (count_x = [0:4]) {
        for (count_y = [0:4]) {
            translate([($cam_r*2 + $bit_diam) * count_x,
                       ($cam_r*2 + $bit_diam) * count_y, 
                       0]) {
                cam_disk($cam_r,$cam_offs);
            }
        }
    }
}

/*
translate([292,0,0]) {
    cube([1,304,10]);
}
translate([0,304,0]) {
    cube([292,1,10]);
}
*/
