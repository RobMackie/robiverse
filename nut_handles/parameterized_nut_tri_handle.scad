/*
 * parameterizeedd bolt or nut handle
 *
 * head_height
 * bolt_diameter
 *  ______
 *  |    |  -> this vertical is head heigth
 *    ||
 *    ||    -> this is bolt_diameter
 *    ||
 *
 * wrench_size is the size of the wrench that would fit 
 *     the hex head
 * 
 * offset_into_body is the vertical distance from the bottom
 *     of the piece to where the bottom of the head rests
 *
 * 
 * hopefully doesn't need adjustment
 * hex_ratio - the ratio of the flat diameter to the pointy
 *                 diameter of a hex head
 * d1_size   - diameters
 * d2_size   - define the hexogonal cone that breaks the
 *                 edges of the hex socket
 *
 */

$inch = 25.4;

/* 
 * Start Parameters
 */

$head_height = 8; // mm
$bolt_diameter = 5/16 * $inch; 
$wrench_size = 1/2 * $inch + 0.3; //0.3mm for clearance
$offset_into_body=8;

/* 
 * End Parameters
 */
 
/* 
 * start constants (which might get adjusted)
 */

$edge_break_fudge = 0.55;
$hex_ratio = 0.866;
$d1_size = $wrench_size/$hex_ratio*0.6;
$d2_size = $wrench_size/$hex_ratio*1.4;

/* 
 * end constants
 */

module bolt_chassis(height) {
    difference() {
        hull() {
            for (nub = [0:2]) {
                rotate(nub*120, [0,0,1]) {
                    translate([2*$inch / 2, 0,0]) {
                        cylinder(d=0.5*$inch, h=height, $fn=64);
                    }
                }
            }            
        }
        cylinder(d=1.35*$inch, h=height, $fn=64);
        for (bolthole = [0:2]) {
            rotate(bolthole*120, [0,0,1]) {
                translate([2*$inch / 2, 0,-1]) {
                    cylinder(d=1/4*$inch, h=height+2, $fn=64);
                }
            }
        }
    }
}

module top_body() {
    difference() {
        translate([0,0,0]) {
            cylinder(d=1.35*$inch, h=23, $fn=64);
        }
        translate([0,0,8+$head_height]) {
            cylinder(d=1.125*$inch, h=10, $fn=64);
        }
        // hex head
        translate([0,0,8]) {
            cylinder(d=$wrench_size/$hex_ratio, h=$head_height+2, $fn=6);
        }
        // ease the edges of the hex hole
        translate([0,0, 8 + $head_height*$edge_break_fudge]) {
            cylinder(d1=$d1_size, d2=$d2_size, h=5, $fn=6);
        }
        // bolt thru hole
        translate([0,0,-1]) {
            cylinder(d=$bolt_diameter, h=31, $fn=64);
        }
    }
}

translate([25,0,0]) {
    union() {
        top_body();
        bolt_chassis(23);
    }
}
