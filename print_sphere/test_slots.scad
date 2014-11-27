$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$slot_width = 1;
$slot_length = 5 + 1; // offset to always use.

$depth = 1;
$start = 2;

$sq_side=30;

$fn=128;
$2d = 0; // set "$2d = 1;" for profiles

module make_slotted_flat () {
    difference () {
       cube([$sq_side,$sq_side, $depth]);
       translate([$start,-1,-0.1]) {
          cube([$slot_width,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+5,-1,-0.1]) {
          cube([$slot_width + (0.2),
                $slot_length,$depth + 0.2]);
       }
       translate([$start+10,-1,-0.1]) {
          cube([$slot_width + 0.22,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+15,-1,-0.1]) {
          cube([$slot_width + 0.24,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+20,-1,-0.1]) {
          cube([$slot_width,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+25,-1,-0.1]) {
          cube([$slot_width+0.26,
                $slot_length,$depth + 0.2]);
       }
// far side
       translate([$start,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+5,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width + (0.2),
                $slot_length,$depth + 0.2]);
       }
       translate([$start+10,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width + 0.22,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+15,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width + 0.24,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+20,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width,
                $slot_length,$depth + 0.2]);
       }
       translate([$start+25,$sq_side - $slot_length+1,-0.1]) {
          cube([$slot_width + 0.26,
                $slot_length,$depth + 0.2]);
       }
    }
}

module make_parts() {

    translate([0,0,0]) {
        make_slotted_flat();
    }
    translate([$sq_side+5,0,0]) {
        make_slotted_flat();
    }
}


if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
}
} else {
    make_parts();
//  for measuring and calibrating
//    translate([60,40,0]) {
//      cube([20,5,1]);
//    }
}