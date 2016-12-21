$t_numbers0 = ["3459"];

/*
 Team numbers for up to 12 voltmeters at a time
 Just fill this table with team numbers. An empty 
 array will not generate a chassis, a missing entry
 will not generate a chassis. Do not add more 
 than 3 entries per row for print bed dimensions (go measure soon)
 */
/*
$t_numbers0 = ["3459", "2222", "3333"];
$t_numbers1 = ["4444", "5555", "6666"];
$t_numbers2 = ["7777", "8888", "3459"];
$t_numbers3 = ["9999", "9998", "9997"];
*/


/* 
   Code to generate the voltmeter chassis and then to read the numbers and 
   create objects
*/
$thickness = 7;
$width=33.75;
$length=65.62;

$tang_length = 14;
$tang_width = 27;
$tang_thickness = $thickness - 0.5;

$lanyard_r = 2;
$lanyard_inset = 5;

$cutout_length = $tang_length;
$cutout_width = 6.83;
$cutout_height = 10;
$cutout_z_offset = 2.25;

$contact_x_pullback = 6;
$contact_y_offset = ($width/2 - $cutout_width/2)/2 + ($width-$tang_width)/4;

$contact1_x = $length - $contact_x_pullback;
$contact1_y = $contact_y_offset;
$contact2_x = $length - $contact_x_pullback;
$contact2_y = $width - $contact_y_offset;

$sides = 30;

$voltmeter_width = 14.91;
$voltmeter_length = 30.83;
$voltmeter_offset_x = 10;
$voltmeter_thickness = 4;
$voltmeter_depth = $thickness - $voltmeter_thickness;

$wire_chase_width = 2;

$hexnut_head_dim = 7.43/2;

$brass_insert_r = 1.2;

$pin_r = 0.5;
$pin_h = 1;

module voltmeter_chassis(t_number) {
    union() {
        difference() {
            // main body of device
            translate([0,0,0]) {
                union() {
                    cube([$length-$cutout_length,$width,$thickness]);
                    translate([$length-$cutout_length, ($width-27)/2, 0]) {
                        cube([$cutout_length, 27, $tang_thickness]);
                    }
                }
            }
            /*
              long list of shapes to be subtracted from the main body:
            */
            // lanyard hole shape
            translate([$lanyard_inset,$width/2,-1]) {
                cylinder(r=$lanyard_r, h=$thickness+2, $fn=$sides); 
            }
            
            // voltmeter recess
            translate([$voltmeter_offset_x,$width/2 - $voltmeter_width/2, $voltmeter_depth]) {
                rotate([0,0,0]) {
                    cube([$voltmeter_length, $voltmeter_width, $voltmeter_thickness+1]);
               }
            }    
            
            // wire chase 1
            translate([$voltmeter_offset_x + $voltmeter_length-1, $width/2+$voltmeter_width/2 - $wire_chase_width, $voltmeter_depth]) {
                rotate([0,0,6]) {
                    cube([17.5, $wire_chase_width, $thickness]);
                }
            }
            
            // wire chase 2
            translate([$voltmeter_offset_x + $voltmeter_length-1, $width/2-$voltmeter_width/2,$voltmeter_depth]) {
                rotate([0,0,-6]) {
                    cube([17.5, $wire_chase_width, $thickness]);
                }
            }    
            
            // calibration hole (to be positioned when measured
            translate([25,$width/2,-1]) {
                cylinder(r=1, h=$thickness+2, $fn=$sides); 
            }    
            
            // slanting bar to create slope cutaway on insert tangs
            // 5.5*$length/7
            translate([59.5,-1,$tang_thickness]) {
                rotate([0,13.7,0]) {
                    cube([40,$width+2,5]);
               }
            }
            
            // block to be removed to create upright index cutout
            translate([($length-$cutout_length), ($width/2)-($cutout_width/2), $cutout_z_offset]) {
                cube([$cutout_length, $cutout_width, $cutout_height]);
            }
            
            // holes for threaded brass inserts in tangs or for bolts 1
            translate([$contact1_x, $contact1_y, -1]) {
                cylinder(r=$brass_insert_r, h=$thickness + 2, $fn=$sides);
            }
            // hex nut cut out 1
            translate([$contact1_x, $contact1_y, $voltmeter_depth]) {
                cylinder(r=$hexnut_head_dim, h=5, $fn=6);
            }
            // pocket for tapered bolt head 1
            translate([$contact1_x, $contact1_y, -0.1]) {
                linear_extrude(height = 2, twist=0, slices = 0, scale=[-2,-2]) {
                       circle(r=3, $fn=$sides);
                }
            }   
            
            // holes for threaded brass inserts in tangs or for bolts 2
            translate([$contact2_x, $contact2_y, -1]) {
                cylinder(r=$brass_insert_r, h=$thickness + 2, $fn=$sides);
            }
            // hex nut cut out 2
            translate([$contact2_x, $contact2_y, $voltmeter_depth]) {
                cylinder(r=$hexnut_head_dim, h=5, $fn=6);
            }
            // pocket for tapered bolt head 2
            translate([$contact2_x, $contact2_y, -0.1]) {
                linear_extrude(height = 2, twist=0, slices = 0, scale=[-2,-2]) {
                       circle(r=3, $fn=$sides);
                }
            }         
        }
        
        // Add pins to stablize and position voltmeter
        translate([12.55, $width/2, $voltmeter_depth]) {
            cylinder(r=$pin_r, h=$pin_h, $fn=30);
        }
        // Add pins to stablize and position voltmeter
        translate([12.55 + 24.60, $width/2, $voltmeter_depth]) {
            cylinder(r=$pin_r, h=$pin_h, $fn=30);
        }  
        
        // Add team number
        translate([14, 26, $thickness-2.5]) {
            linear_extrude(3) text(t_number, size = 7);        
        }
        translate([14, 1, $thickness-2.5]) {
            linear_extrude(3) text(t_number, size = 7);        
        }     
    }
}

$counter0 = len($t_numbers0);
for($count0 = [0 : $counter0-1]) {
    translate([($length+5)*$count0, 0, 0]) {
        voltmeter_chassis($t_numbers0[$count0]);
    }
}

$counter1 = len($t_numbers1);
for($count1 = [0 : $counter1-1]) {
    translate([($length+5)*$count1, $width+5, 0]) {
        voltmeter_chassis($t_numbers1[$count1]);
    }
}

$counter2 = len($t_numbers2);
for($count2 = [0 : $counter2-1]) {
    translate([($length+5)*$count2, ($width+5)*2, 0]) {
        voltmeter_chassis($t_numbers2[$count2]);
    }
}

$counter3 = len($t_numbers3);
for($count3 = [0 : $counter3-1]) {
    translate([($length+5)*$count3, ($width+5)*3, 0]) {
        voltmeter_chassis($t_numbers3[$count3]);
    }
}

/*
translate([63, 4, 0]) {
    cube([4,1,5.0]);
}
*/
