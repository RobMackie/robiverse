
// Conveniences: (since a raw number is always mm)
$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$fn=128; // controls how round circles are, bigger num is rounder

// servo mount parameters
$base_pad = 5; // thinkness of baseplate of mount, must be 5 or  
               // greater due to the subtraction constant below
               // To make the base plate thicker, change $base_pad 
               // to 8 or 10 or something, this parameter should
               // generally self-adjust other things in the file
$base_pad_offset = $base_pad - 5;

// Not sure that any of the below really are coded so that a 
// change properly adjusts all the related values.
$arm_len = 110; // length of mount in the X dimension
$arm_h = 30;    // height of mount
$arm_w = 22.25; // front to back of mount (match to 8020 dim?)

// This is how you adjust the servo holes distance, one from another
$vertical_hole_distance = 10.17;
$horizontal_hole_distance = 47.26;

    $servohorn_length = 70;
    $servohorn_mid_off = 5;
    $servohorn_end_r = 1;
    $servohorn_mid_r = 4;
    $servohorn_h = 2;


module make_servo_pattern(hole_radius, hole_w, hole_l) {
   $body_h = hole_w + 6;
   $body_l = hole_l - 3.69 * 2;
   translate ([0,0,-2+4.825]) {
	   union() {
	      translate([0,7,0]) {
	         rotate([90,0,0]) {
	            translate([0,0,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([0,hole_w,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([hole_l,0,0]) {
	               cylinder(r=hole_radius, h=8);
	            }
	            translate([hole_l,hole_w,0]) {
	               cylinder(r=hole_radius, h=9);
	            }
	         }
	      }
	      translate([3.69,-1,-4.825]) {
	         cube([$body_l,7, $body_h+4.825]);
	      }
	   }
	}
}

$triangle=3;
module make_one_arm(length, height, width) {
   translate([0,11.68+(3.05*2),0]) {
      difference() {
          union() {
              difference() {
    
                cube([length, width, height-5 + $base_pad_offset]);
                translate([-1,5,$base_pad]) {
                   cube([length + 2, width - 4, height-1]);
                }
                // center the servo cut out along the length
                translate([length/2-($horizontal_hole_distance/2),0,7+$base_pad_offset]) {
                   make_servo_pattern(2,
                                      $vertical_hole_distance,
                                      $horizontal_hole_distance);
                }
    
                // bolt hole for 8020
                translate([length-12,12.5,-1]) {
                   cylinder(r=$eigth, h=7+$base_pad_offset);
                }
                // bolt hole for mounting to plate
                /*
                translate([length-70,12.5,-1]) {
                   cylinder(r=$eigth, h=7 + $base_pad_offset);
                }
                */
                // bolt hole for mounting to plate
                translate([length-96,12.5,-1]) {
                   cylinder(r=$eigth, h=7+$base_pad_offset);
                }
              }
             // triangle next to servo cut out
             translate([length/2-($horizontal_hole_distance/2)-6,2,2+$base_pad_offset]) {
                hull() {
                   translate([0,2,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,width-4,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,2,height-10]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                }
             }          
                // triangle next to servo cut out
                translate([length/2+($horizontal_hole_distance/2)+3,2,2+$base_pad_offset]){
                hull() {
                   translate([0,2,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,width-4,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,2,height-10]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                }
             }
             // outer triangle
             translate([length-3,2,2+$base_pad_offset]) {
                hull() {
                   translate([0,2,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,width-4,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,2,height-10]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                }
             }
          
             // inner triangle
             translate([0,2,2+$base_pad_offset]) {
                hull() {
                   translate([0,2,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,width-4,2]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                   translate([0,2,height-10]) {
                      rotate([0,90,0]) {
                         cylinder(r=2, h=$triangle);
                      }
                   }
                }
             }
          }
          translate([length/2-$servohorn_length/2,
               width/2-$servohorn_mid_r/2+5/2, // the base is offset by a constant of 5 up above for some reason
               0]) {
             servo_horn_approximation();
          }
       }
   }    
}


module servo_horn_approximation() {
    hull() {
        translate([$servohorn_end_r,0,0]) {
            cylinder(r=$servohorn_end_r, h=$servohorn_h);
        }
        translate([$servohorn_length/2-$servohorn_mid_off,0,0]) {
            cylinder(r=$servohorn_mid_r, h=$servohorn_h);
        }
        translate([$servohorn_length/2+$servohorn_mid_off,0,0]) {
            cylinder(r=$servohorn_mid_r, h=$servohorn_h);
        }
        translate([$servohorn_length - $servohorn_end_r,0,0]) {
            cylinder(r=$servohorn_end_r, h=$servohorn_h);
        }        
    }
    
}

module make_parts() {
   translate([0,0,0]) {
      make_one_arm($arm_len, $arm_h, $arm_w);
   }
   /*
   translate([0,-20,0]) {
       servo_horn_approximation();
   }
   */
}

translate([0,-18,0]) {
   make_parts();
}
