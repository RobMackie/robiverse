function inch(in) = (in*25.4);

module waveshare() {
    translate([0,0,0]) {
        cylinder(r=1.5, h=inch(3));
    }
    translate([0,57,0]) {
        cylinder(r=1.5, h=inch(3));
    }
    translate([28,0,0]) {
        cylinder(r=1.5, h=inch(3));
    }
    translate([28,57,0]) {
        cylinder(r=1.5, h=inch(3));
    }    
}

module ultrasonic() {
    translate([36,24,0]) {
        cylinder(r=1.5, h=inch(3));
    }
    translate([36,34,0]) {
        cylinder(r=1.5, h=inch(3));
    }
}

module make_module() {
    translate([(1),inch(1.6),0]) {
    //    cube([1,inch(5.25), 1]);
    }
    difference() {
        translate([inch(2.6),inch(4.25),0]) {
            cylinder(r=inch(4.75), h=inch(1), $fn=3);
        }
        translate([inch(2.25),inch(3.66),inch(-1)]) {
            cube([inch(2),2,inch(3)]);
        }
        translate([inch(2.25),inch(4.76),inch(-1)]) {
            cube([inch(2),2,inch(3)]);
        }
        translate([inch(0.60),inch(2.4),-1]) {           
            cylinder(r=inch(1/8), h=inch(1));
        }
        translate([inch(0.6),inch(6.10),-1]) {
            cylinder(r=inch(1/8), h=inch(1));
        } 
        translate([inch(6),inch(4.25),-1]) {
            cylinder(r=inch(3/16), h=inch(3));         
        }  
        translate([inch(0),inch(1/10),inch(-1)]) {
            cube([inch(4),inch(1.5),inch(3)]); 
            translate([30, inch(1.5),0]) {
                cube([7,2,inch(3)]);
            }
            translate([30, inch(1.5)+14,0]) {
                cube([7,2,inch(3)]);
            }            
        }
        translate([0,inch(6.9),inch(-1)]) {
            cube([inch(4),inch(1.5),inch(3)]);
            translate([30, -2,0]) {
                cube([7,2,inch(3)]);
            }
            translate([30, -14,0]) {
                cube([7,2,inch(3)]);
            }  
        }        
        translate([inch(.5),inch(3.1), inch(-1)]) {
            waveshare();
            ultrasonic();
        }
    }
}


projection(cut=true) {
   translate([0,0,0]) rotate([0,0,0]) {
      make_module();
   }
}