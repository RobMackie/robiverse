// golf ball drop for CCR


$inch=25.4;
$paddle_rad=(2.5*$inch);
$paddle_hollow_rad=($paddle_rad - (0.5*$inch));
$div_long=($paddle_rad-(0.5*$inch));
$div_wide=($paddle_rad/5);
$plat_rad=($inch*2/4);
$height=1;
$t_hole=($inch * 1/16);

$clamp_wide=$inch*1;
$clamp_len=$inch*2;

module handle() {
    difference() {
        translate([0,-($clamp_wide/2),0]) {
            cube([$clamp_len*1.1, $clamp_wide,$height]);
        }
        translate([15,0,-1]) {
            cylinder(r=$inch/8, h=$height+2);
        }
        translate([45,0,-1]) {
            cylinder(r=$inch/8, h=$height+2);
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
            translate([0,-(0.5*$div_wide),0]) {
                cube([$paddle_rad-$t_hole, $div_wide, $height]);
            }
            translate([$paddle_rad, 0, 0]) {
                cylinder(r=$plat_rad, h=$height);
            }
        }
        translate([$paddle_rad,0,-1]) {
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
    }
} else {
   translate([50,$paddle_rad,0]) rotate([0,0,0]) {
      build_it();
   }
   translate([($clamp_len+2*$paddle_rad),$paddle_rad * 2.3,0]) rotate([0,0,180]) {
      build_it();
   }   
}

