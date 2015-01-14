use <../libs/bearing_mount_lib.scad>

$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$yy = 2 * 25.4 - 0.25;
$xx = (6.8385396 * 25.4) - 0.2;

module make_parts () {
    translate([0,0,0]) {
       make_2_parts();
    }
    translate([0,$yy+8,0]) {
       make_2_parts();
    }
    translate([0,2*$yy+16,0]) {
       make_2_parts();
    }
    translate([0,3*$yy+24,0]) {
       make_2_parts();
    }
    translate([0,4*$yy+32,0]) {
       make_2_parts();
    }
}

module make_2_parts() {
	translate([0.25,0.25,0]) {
      make_ramp();
   } 

   translate([$xx,$yy+4,0]) {
      rotate([180,180,0]) {
         make_ramp();
      }
   } 
}

module make_ramp () {
   hull() {
          translate([0,0,0]) {
             cylinder(r=0.5, h=10);
          }
          translate([$xx,0,0]) {
             cylinder(r=0.5, h=10);
          }
          translate([0,$yy,0]) {
             cylinder(r=0.5, h=10);
          } 
      }
}


module make_workspace_bounds(x, y) {
   translate([-5, -5, 0]) {
      difference() {
         translate([0,0,0]) {
             cube([x+10,y+10,$eigth]);
         }
         translate([5,5,-1]) {
             cube([x,y,$eigth+2]);
         }
      }
   }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
   }
} else {
    make_parts();
//    make_workspace_bounds(290,290);
}

