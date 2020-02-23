// constants

$inch = 25.4;
$plyboard_h = 3*$inch/4;
$table_r = 15*$inch;
$rope_r = 6;


$dado_long = $inch*6;
$dado_wide = $plyboard_h;
$dado_from_edge = $inch*1;
$dado_deep=$plyboard_h;

$gran = 256;
$corner_relief = 3*$inch/16;

$arm_h = 750;
$arm_offset = 250;

$angle_twist = 25;
$angle_offset = 30;
$angle_offset_bottom = -$angle_offset+$angle_twist;
$angle_offset_top = $angle_offset-$angle_twist;

$cleat_long = 2*$inch;
    
module cleat() { 
    translate([0,0,$inch/2]) {
        difference() {
            hull() {
                cube([$cleat_long, $plyboard_h, $inch], center=true);
                translate([0,$plyboard_h/2,2*$inch]) {
                    rotate([90,0,0]) {
                        cylinder(r=$cleat_long/2, h=$plyboard_h);
                    }
                }
            }
            translate([0,$plyboard_h/2+1,2*$inch]) {
                rotate([90,0,0]) {
                    cylinder(r=$rope_r, h=$plyboard_h+2);
                }
            }
        }
    }
}

module base(angle_offset) {
    translate([$table_r, $table_r, 0]) {
        difference() {
            cylinder(r=$table_r, h=$plyboard_h, $fn=$gran);
            for (position = [0,1,2]) {
                rotate((position * 120+angle_offset)*[0,0,1]) {
                    translate([0,0.95*$table_r, $inch/2]) {
                        cube([$cleat_long, $plyboard_h, $inch], center=true);
                    }
                }
            }
            translate([$table_r-$dado_long/2-$dado_from_edge, 0,($plyboard_h-$dado_deep)+0.5*$dado_deep]) {
                cube([$dado_long, $dado_wide, $dado_deep+2], center = true);
                translate([$dado_long/2,$dado_wide/2, 0]) {
                    cylinder(r=$corner_relief, h=$plyboard_h+20);
                }
                translate([-1*$dado_long/2,$dado_wide/2,0]) {
                    cylinder(r=$corner_relief, h=$plyboard_h+20);
                }
                translate([$dado_long/2,-1*$dado_wide/2,0]) {
                    cylinder(r=$corner_relief, h=$plyboard_h+20);
                }
                translate([-1*$dado_long/2,-1*$dado_wide/2,0]) {
                    cylinder(r=$corner_relief, h=$plyboard_h+20);
                }
            }
        }
    }
}

$knee_r = 3*$dado_long/4;
$thigh_l = 500;
module arm_up() {
    hull() {
        cube([$dado_long, $dado_wide, 4*$inch]);
        translate([$knee_r/2,$plyboard_h,500]) {
            rotate([90,0,0]) {
                cylinder(r=$knee_r/2, h=$plyboard_h, $fn=$gran);
            }
        }
    }
}

module arm_angle() {
    hull() {
        translate([$knee_r/2,$plyboard_h,500]) {
            rotate([90,0,0]) {
                cylinder(r=$knee_r/2, h=$plyboard_h, $fn=$gran);
            }
        }
        translate([$knee_r/4-7*$inch,$plyboard_h,$arm_h]) {
            rotate([90,0,0]) {
                cylinder(r=$knee_r/4, h=$plyboard_h, $fn=$gran);
            }
        }
    }
}

module arm_over() {
    hull() {
        translate([$knee_r/4-7*$inch,$plyboard_h,$arm_h]) {
            rotate([90,0,0]) {
                cylinder(r=$knee_r/4, h=$plyboard_h, $fn=$gran);
            }
        }
        translate([$knee_r/4-10*$inch,$plyboard_h,$arm_h]) {
            rotate([90,0,0]) {
                cylinder(r=$knee_r/4, h=$plyboard_h, $fn=$gran);
            }
        }
    }
}

module arm() {
    union() {
        arm_up();
        translate([0,0,0]) {
            arm_angle();
        }
        translate([0,0,0]) {
            arm_over();
        }
    }
    
}

module rope(length) {
    
}


module table_half(angle) {
    color("gray") base(angle_offset = angle);
    translate([(2*$table_r)-$dado_from_edge-$dado_long,$table_r-$plyboard_h/2,$plyboard_h - $dado_deep]) {
        color("brown") arm();
    }
}

module table() {
    table_half($angle_offset_bottom);
    translate([$table_r*2,0,$arm_h+$arm_offset]) {
        rotate([0,180,0]) {
            table_half($angle_offset_top);   
        }
    }
    
    //simulated rope
    translate([$table_r, $table_r, 210]) {
        cylinder(r=$plyboard_h/4, h=580);
    }
    
    
    translate([$table_r, $table_r, $plyboard_h-$dado_deep]) {
        for (position = [0,1,2]) {
            rotate((position * 120+$angle_offset_bottom)*[0,0,1]) {
                translate([0,0.95*$table_r, 0]) {
                    cleat();
                }
            }
        }
    }
    
    translate([$table_r, $table_r, $plyboard_h-$dado_deep]) {
        for (position = [0,1,2]) {
            rotate((position * 120+$angle_offset_bottom)*[0,0,1]) {
                translate([0,0.95*$table_r, 1000-3.5*$inch-2*($plyboard_h-$dado_deep)]) {
                    translate([0,0,3.5*$inch]) {
                        rotate([0,180,0]) {
                            cleat();
                        }
                    }
                }
            }
        }
    }    

}

$cut_cleats = 0;
$cut_bottom_disk = 1;
$cut_top_disk = 2;
$cut_arm = 3;

$what_to_cut = $cut_arm;
$2d = 0;

module parts_layout() {
    if ($what_to_cut == $cut_cleats) {
        for ( ii = [0:5] ) {
            translate([ii*($cleat_long+3*$inch/4)+$inch/2,$inch/2,0]) {
                rotate([-90,0,0]) {
                    translate([$cleat_long/2, 0,0]) {
                        cleat();
                    }
                }
            }
        }
    }
    if ($what_to_cut == $cut_bottom_disk) {
        base($angle_offset+$angle_twist);
    }

    if ($what_to_cut == $cut_top_disk) {
        rotate([0,0,0]) {
            base($angle_offset-$angle_twist);
        }
    }
    if ($what_to_cut == $cut_arm) {
        translate([$dado_long,0,0]) {
            rotate([-90,180,0]) {
                arm();
            }
        }
        translate([$dado_long*2+30,0,0]) {
            rotate([-90,180,0]) {
                arm();
            }
        }
    }
    
}

if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          parts_layout();
       }
   }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      table();
   }
}