$thickness=3.175;
$detail=64;
$bit_diam=3.5;

$inch=25.4;

$outer_r = $inch;
$inner_r = $inch/4;

module bushing() {
    translate([$outer_r, $outer_r, 0]) {
        difference() {
            cylinder(r=$outer_r, h=4, $fn=$detail);
            translate([0,0,-1]) {
                cylinder(r=$inner_r, h=6, $fn=$detail);
            }
        }
    }
}

// lay out
module layout() {  
    for ($ii = [0:4]) {
        for ($jj = [0:4]) {
        translate([(2*$outer_r + $bit_diam)*$ii,
                   (2*$outer_r + $bit_diam)*$jj,
                    0]) {
            bushing();
            }
        }
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
           layout();
       }
    }
} else {
    layout();
}


translate([292,0,0]) {
    cube([1,304,10]);
}
translate([0,304,0]) {
    cube([292,1,10]);
}

