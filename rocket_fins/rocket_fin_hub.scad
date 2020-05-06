
$gran = 256;
$hub_height = 14.29;

// hub is radius of 27, centered on 0,0,xy plane
// get license and attribute or replace with self
// design
module basic_hub() {
    translate([0,0,12.7]) {
        rotate([-90,0,0]) {
            import("2LiterThreads.stl", convexity=3);
        }
    }
}

module pipe(outer, inner, height) {
    difference() {
        cylinder(r=outer, h=height, $fn=$gran);
        translate([0,0,-1]) {
            cylinder(r=inner, h=height+2, $fn=$gran);
        }
    }
}

module modified_hub() {
    $fin_mount_width = 10;
        $fin_width = 3.1;
    difference() {
        union() {
            basic_hub();
            pipe(27.1,17,$hub_height);
            
            for (i = [0,1,2]){
                rotate([0,0,i*120]) {            
                    translate([26, -$fin_mount_width/2, 0]) {
                        cube([10,$fin_mount_width,$hub_height]);
                    }
                }
            }
        }
        for (i = [0,1,2]){
            rotate([0,0,i*120]) {
               translate([23,-$fin_width/2,-1]) {
                  cube([15,$fin_width,$hub_height+2]);
               } 
               translate([29.5,15,7]) {
                   rotate([90,0,0]) {
                       cylinder(r=3, h=30, $fn=64);
                   }
               }
               translate([31,-6,17]) {
                   rotate([0,45,0]) {
                       cube([10,12,50]);
                   }
               }
               translate([32,-6, -2]) {
                   rotate([0,45,0]) {
                       cube([10,12,50]);
                   }
               }               
            } 
        }       
    }
}

module fin_mount() {
    $fin_mount_width = 10;
    $fin_width = 3.1;
    difference() {
        translate([0, -$fin_mount_width/2, 0]) {
            cube([10,$fin_mount_width,$hub_height]);
        }
        translate([0,-$fin_width/2,-1]) {
            cube([15,$fin_width,$hub_height+2]);
        }
    }
}

modified_hub();
/*
translate([25,0,0]) {
    fin_mount();
}
*/


/*
// measuring stick
translate([0,-2.5,0]) {
    cube([27,5,5]);
}
*/