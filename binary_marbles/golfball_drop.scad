// golf ball drop for CCR


$inch=25.4;

$fn=32;

module handle() {
    difference() {
        translate([0,-($clamp_wide/2),0]) {
            cube([$clamp_len*1.1, $clamp_wide,$height]);
        }
        translate([15,0,-1]) {
            cylinder(r=$inch/7.9, h=$height+2);
        }
        translate([15+$inch,0,-1]) {
            cylinder(r=$inch/7.9, h=$height+2);
        }   
        translate([15+2*$inch,0,-1]) {
            cylinder(r=$inch/7.9, h=$height+2);
        }       
    }
}

module hollow_paddle() {
    translate([$paddle_rad,0,0]) {
        difference() {
            cylinder(r=$paddle_rad, h=$height);
            translate([0,0,-1]) {
                cylinder(r=$paddle_hollow_rad, h=$height+2); 
            }
        }
    }
}

module diving_board() {
    difference() {
        union() {
            translate([0,-($plat_rad),0]) {
                cube([($paddle_rad-$t_hole)/3, $plat_rad*2, $height]);
            }
            translate([$paddle_rad/3, 0, 0]) {
                cylinder(r=$plat_rad, h=$height);
            }
        }
        translate([$paddle_rad/3,0,-1]) {
            cylinder(r=$t_hole, h=$height+2);
        }
    }
}

module build_tip() {
    union() {
        hollow_paddle();
        diving_board();
    }  
}

module build_it() {
    //cube([110,2,10]);
    union() {
        translate([$clamp_len,0,0]) {
            build_tip();
        }
        handle();
    }
}

//--------------------------------------------------
$2d=0;

if ($2d) {
    projection(cut=true) {
       translate([50,$paddle_rad,0]) rotate([0,0,0]) {
          build_it();
       }
       translate([($clamp_len+2*$paddle_rad),$paddle_rad * 2.3,0]) rotate([0,0,180]) {
          build_it();
       }
/*
	   translate([50,$paddle_rad * 1.6*2.3,0]) rotate([0,0,0]) {
	      build_it();
	   } 
*/
    }
} else {
   translate([55,$paddle_rad+5,0]) rotate([0,0,0]) {
      build_it();
   }
   translate([($clamp_len+2*$paddle_rad)+5,$paddle_rad * 2.3+5,0]) rotate([0,0,180]) {
      build_it();
   }  /*
   translate([50,$paddle_rad * 1.6*2.3,0]) rotate([0,0,0]) {
      build_it();
   } */ 
}

