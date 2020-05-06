

module hollow_box(x,y,z,thick) {
    difference () {
      //cube([x,y,z]);
      cylinder(r=x, h=y);
  //    translate([thick/2,thick/2,thick/2]) {
        //cube([x-thick,y-thick,z]);
        cylinder(r=x-thick, h=y);
  //    }   
    }
}


module box_chain(count) {
    union() {
        hollow_box(10,10,10,2);
        for (iter = [1:count-1]) {
            translate([9*iter,9*iter,0]) {
                hollow_box(10,10,10,2);
            }
        }
    }
}

for (jitter = [0:2]) {
    rotate([0,0, jitter*7]) {
        translate([0,0,jitter*9]) {
            box_chain(5);
        }
    }
}

