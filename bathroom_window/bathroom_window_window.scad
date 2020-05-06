$inch = 25.4;
function inches(mm) = ($inch*mm);


// offsets of section we will cut this time
$section_x = 0;
$section_y = 0;

// shape of window
$x = inches(39.25);
$y = inches(27.5);

// size of cutting area
$cut_x = inches(90);
$cut_y = inches(100);


$bottom_reveal=inches(2  + 1/16);
$top_reveal=inches(5 + 1/16);

$h = 6;
$fn=64;          
            
module oval(x,y, height, center = true) {
   scale([1, y/x, 1]) cylinder(h=height, r=x, center=center);
}

module cutting_template(x_offset, y_offset) {
    translate([0,0,-1]) {
        difference()  {
            cube([inches(100), inches(100), $h*5]);
            translate([x_offset, y_offset, -1]) {
                cube([$cut_x, $cut_y, $h*5 + 2]);
            }
        }  
    }
}

module grab_cuttable_area(x,y) {
    difference() {
        make_window_surround();
        cutting_template(x,y);  
    }   
}

module make_window_surround() {
    union() {
        translate([0,$bottom_reveal,0]) {
            difference() {
                cube([$x, $y, $h]);
                translate([$x/2, $y/2, -1]) {
                    oval($x/2,$y/2, $h+2, false);
                }
            }
        }
        cube([$x, $bottom_reveal, $h]);
        translate([0,$y+$bottom_reveal,0]) {
            cube([$x, $top_reveal, $h]);
        }
    }
}

grab_cuttable_area($cut_x*$section_x,0);


