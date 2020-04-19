
// LEGO constants
$stud_interval = 8; //mm
$P = $stud_interval;
$short_brick_h = 3.2; //mm
$tall_brick_h = 9.6; //mm

function brick_dimension(studs) = ($P * studs) - 0.2;

// Instrument Shape Constants
$wood_h = 3.125;

// stop dimensions 
// inside stop
$in_width = brick_dimension(2);
$in_reach = brick_dimension(8);
// outside stop
$out_width = brick_dimension(3);
$out_reach = brick_dimension(12);

// slider dimensions
$interlock = 3;
$caliper_scale_max = brick_dimension(48);
$caliper_body_width = brick_dimension(4);  // studs

module inside_stop_shape () {

    $trans_w = $in_width * 1.25;
    $trans_reach = $in_reach / 1.45;
    
    difference() {
        cube([$in_width, $in_reach, $wood_h],
            false);
        translate([$trans_w,           
                   $trans_reach,-1]) {
            rotate([0,0,40]) {
                cube([30, 30, $wood_h+2]);
            }
        }
    }
}


module outside_stop_shape () {

    $trans_w = $out_width * 1.05;
    $trans_reach = $out_reach / 1.3;
    
    difference() {
        cube([$out_width, $out_reach, $wood_h], false);
        translate([$trans_w, $trans_reach, -1]) {
            rotate([0,0,40]) {
                cube([30, 30, $wood_h+2]);
            }
        }
    }
}


module inside_stop_bar() {
    difference() {
        inside_stop_shape();
        translate([-0.1,-0.1,-1]) {
            scale([0.2,0.2,2]) inside_stop_shape();    
        }
    }
}

module outside_stop_bar() {
    difference() {
        outside_stop_shape();
        translate([-0.1,-0.1,-1]) {
            scale([0.2,0.2,2]) outside_stop_shape();    
        }
    }
}


/*
 * 2 layers - of the total of 4 layers deep
 *  end view                     |\
 *  __------__       top view   ||||||||||||||||------
 *                              \|
 */

module top_slide_bottom() {
    union() {
        translate([0,0,0]) {
            cube([$caliper_scale_max, 
                  $caliper_body_width,
                  $wood_h]);
        }
        // head piece
        
        translate([$out_width,$caliper_body_width-0.1,0]) {
            inside_stop_bar();
        }
        translate([$out_width,0,0]) {
            rotate([0,0,180]) {
            outside_stop_bar();
            }
        }  
    }  
}
module top_slide_top() {
    difference() {
        translate([0,$interlock,0]) {
            cube([$caliper_scale_max, 
                  $caliper_body_width-2*$interlock,
                  $wood_h]);
        }
        translate([$out_width*2+4.7,$interlock,0]) {
            cube([0.25,0.3,$wood_h]);
        }
    }
}

module top_slide() {
    // sliding body
    translate([0,0,$wood_h]) {
        top_slide_top();
    }   
    translate([0,0,0]) {
        top_slide_bottom();
    }
}
    


/* 
 * 2 layers of the total  of 3 layers
 *  end view                    /|
 *                   top view   ||||||||||||||||||||||
 *                               |/
 * 
 */
$bottom_len_div = 2.5;
module bottom_slide_bottom() {
    difference() {
        union() {
            translate([0,0,0]) {
                cube([$caliper_scale_max/$bottom_len_div,
                      $caliper_body_width+$interlock*2,
                      $wood_h]);
            }
            translate([0,$interlock+$caliper_body_width/4,0]) {
                cube([$caliper_scale_max,
                      $caliper_body_width/2,
                      $wood_h]);
            }
            
            translate([$out_width,$caliper_body_width+$interlock,$wood_h]) {
                rotate([0,180,-0.1]) {
                    inside_stop_bar();
                }
            }
            translate([$out_width,$interlock,$wood_h]) {
                rotate([0,180,180]) {
                    outside_stop_bar();
                }
            }
        }
        translate([52,-0.01,-$wood_h]) {
            cube([1, 0.5, 3*$wood_h]);
        } 
        translate([52,$caliper_body_width+2*$interlock-0.5,-$wood_h]) {
            cube([1, 0.6, 3*$wood_h]);
        }         
    }
}
module bottom_slide_middle_right() {
    difference() {
        cube([$caliper_scale_max/$bottom_len_div-2*$out_width, $interlock, $wood_h]);
        translate([4.4,-0.01,-$wood_h]) {
            cube([1, 0.5, 3*$wood_h]);
        }   
    }
}

module bottom_slide_middle_left() {
    difference() {
        cube([$caliper_scale_max/$bottom_len_div-2*$out_width, $interlock, $wood_h]);
        translate([4.4,1*$interlock-0.5,-$wood_h]) {
            cube([1, 1, 3*$wood_h]);
        }  
    }
}

module bottom_slide_top_right() {
    difference() {
        cube([$caliper_scale_max/$bottom_len_div-2*$out_width, 
              $interlock*2, 
              $wood_h]);
        translate([4.4,-0.01,-1]) {
            cube([1, 0.5, 5*$wood_h]);
        }
    }
}
module bottom_slide_top_left() {
    difference() {
        cube([$caliper_scale_max/$bottom_len_div-2*$out_width, 
              $interlock*2, 
              $wood_h]);
        translate([4.4,2*$interlock-0.49,-1]) {
            cube([1, 0.5, 5*$wood_h]);
        }        
    }
}

module bottom_slide() {
    difference() {
        union() {
            translate([0,0,0]) {
                bottom_slide_bottom();
            }    
            // left
            translate([2*$out_width,0,$wood_h]) {
                bottom_slide_middle_right();
            }
            translate([2*$out_width,0,$wood_h*2]) {
                bottom_slide_top_right();
            } 
            //right
            translate([2*$out_width,
                      $caliper_body_width+$interlock,
                      $wood_h]) {
                bottom_slide_middle_left();
            }
            translate([2*$out_width,
                       $caliper_body_width,
                       $wood_h*2]) {
                bottom_slide_top_left();
            }
        }
    }  
}

module single_mark() {  
   translate([4,0,0]) 
        //text mark on bottom_slide_top
        color("black") text("|", size=5, font="Liberation Sans");
}

module scales() {
    translate([0,0,0]) {
        // text scale on top_side_top
        
        /* stud side */
        translate([15,3*$interlock+1,3*$wood_h]) {
             color("black") text("STUDS", size=5, font="Liberation Sans");
        }
        for($step = [0 : 1 : $caliper_scale_max/$P-7]) {
            if(! $step%5) {
                translate([2*$out_width+4+$step*$P-2,4*$interlock+1,3*$wood_h]) {  
                    color("black") text(str($step), size=5, font="Liberation Sans");
            } 
            translate([2*$out_width+4+$step*$P,1.5*$interlock+1,3*$wood_h]) {  
                    color("black") text("|", size=5, font="Liberation Sans");
            }               
        } else {
            translate([2*$out_width+4+$step*$P,1.5*$interlock+1,3*$wood_h]) {  
                    color("black") text("|", size=5, font="Liberation Sans");
                }       
            }
        }
        
        /* block side */
        $offset = $caliper_body_width-3*$interlock;
        translate([15,$offset,3*$wood_h]) {
             color("black") text("BRICKS", size=5, font="Liberation Sans");
        }
        for($step = [0 : 1 : $caliper_scale_max/$short_brick_h-$short_brick_h*6]) {
            if(! $step%3) {
                translate([2*$out_width+4+$step*$short_brick_h,$offset+2,3*$wood_h]) {  
                    color("black") text(str($step/3), size=2.5, font="Liberation Sans");          
            } 
            translate([2*$out_width+4+$step*$short_brick_h,$offset+7,3*$wood_h]) {  
                    color("black") text("|", size=2.5, font="Liberation Sans");
                }               
        } else {
                translate([2*$out_width+4+$step*$short_brick_h,$offset+7,3*$wood_h]) {  
                    color("black") text("|", size=2.5, font="Liberation Sans");
                }       
            }
        }
    }
}

module thanks_fiona() {
    translate([0,0,0]) {
         color("black") text("Fiona - Thank you!", 
                size=10, 
                font="Liberation Sans");
    }
}

module thanks_sam() {
    translate([0,0,0]) {
         color("black") text("Sam - Thank you!", 
                size=10, 
                font="Liberation Sans");
    }
}


$as_built = 0;

$bottom = 1;
$top = 2;
$bottom_mark = 3;
$top_mark = 4;
$tnx_sam = 5;
$tnx_fiona = 6;


//choose one of the above 4 choices
$print_choice = 4;

if ($as_built) {
    translate([0,$interlock,$wood_h]) {
        top_slide();
    }
    translate([0,0,0]) {
        bottom_slide();
    }
    
    translate([2*$out_width,1,3*$wood_h]) {
        single_mark();
    }   
    
    translate([2*$out_width,1+$caliper_body_width,3*$wood_h]) {
        single_mark();
    } 
    
    translate([0,0,0]) {
    //    scales();
    }
} else {
    translate([0,$out_reach,0]) {
        projection(cut=true) {
            if ($print_choice == $bottom) {
                translate([0,-$out_reach,0]) {
                    bottom_slide_middle_right();
                }
                translate([0,-$out_reach+5,0]) {
                    bottom_slide_middle_left();
                }        
                translate([0,-$out_reach+10,0]) {
                    bottom_slide_top_right();
                }
                translate([0,-$out_reach+18,0]) {
                    bottom_slide_top_left();
                }
                translate([0,25,0]) {
                    rotate([0,0,0]) {
                        bottom_slide_bottom();
                    }
                } 
            } 
            if ($print_choice == $top) {
                translate([0,0,-1]) {
                    top_slide_bottom();
                }
                translate([0,95,0]) {
                    top_slide_top();
                }
            }
        }
    }
    if ($print_choice == $top_mark) {
        single_mark();
    }
    if ($print_choice == $bottom_mark) {
        scales();
    }   
    if ($print_choice == $tnx_sam) {
        translate([0,0,$wood_h]) {
            thanks_sam();
        }
    }
    if ($print_choice == $tnx_fiona) {
        translate([0, 0,$wood_h]) {
            thanks_fiona();
        }
    }
}



