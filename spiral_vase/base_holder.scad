
$fa=1;
$fs=1;


$height=76;
$twist=0;
$slices=10;
$top_to_bottom_multiplier = 0.54;

module cone() {
     linear_extrude(height = $height, twist = $twist, slices = $slices, scale=[0.9, 0.7]) {
        circle(r=50);
    }
}

module subtractables() {
    translate([0,0,3]) {
        // cylinder(r=23, h=$height+2);    
        linear_extrude(height = $height, twist = 0, slices = $slices, scale=[     $top_to_bottom_multiplier, $top_to_bottom_multiplier]) {
        circle(r=40);
        }
    }
}

module main_event() {
    difference() {
        union() {
            translate([0,0,$height]) {
                rotate([0,180,0]) {
                    difference() {
                        cone();
                        subtractables();
                        translate([0,0,-1]) {
                            cylinder(r=36, h=5);
                        }
                        for (i = [0 : 3]) {
                            rotate([0,0,90*i]) {
                                translate([4,4,-1]) {
                                    cube([50,50,$height-10]);
                                }
                            }
                        } 
                    }
                }
            }
            translate([25,-5,0]) {
                cube([40,10,10]);
            }
                translate([-65,-5,0]) {
                cube([40,10,10]);
            }
        }
        translate([60,0,5]) {
            rotate([0,90,0]) {
                cylinder(r=1, h=10);
            }
        }
        translate([-70,0,5]) {
            rotate([0,90,0]) {
                cylinder(r=1, h=10);
            }
        }
    }
}

difference () {
    main_event();
    translate([0,0,30]) {
       cylinder(r=100, 100);
    }
}
