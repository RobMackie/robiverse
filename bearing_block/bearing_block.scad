$fn=64;

$inset = 4.26;
$radius = 2;
$llx = $inset+$radius;
$lly = $inset+$radius;


$tlx = $llx;
$tly = $lly + 28;

$lrx = $llx + 25.25;
$lry = $lly;

$trx = $tlx + 25.25;
$try = $tly;

module make_parts() {
    difference() {
        cube([39,40,1]);
        
        translate([$llx, $lly,-1]) {
            cylinder(r=2, h=3);
        }
        translate([$tlx, $tly,-1]) {
            cylinder(r=2, h=3);
        }
        
        translate([$lrx, $lry,-1]) {
            cylinder(r=2, h=3);
        }
        
        translate([$trx, $try,-1]) {
            cylinder(r=2, h=3);
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