module rounded_rect_x (r, l, h) {
   $rect_l = l;
   $rect_w = 4 * r;
   $rect_h = h;
   union () {
	   translate([2*r, 0, 0]) {
		    cube([$rect_l, $rect_w, $rect_h]);
	   }
	   translate([2*r, 2*r, 0]) {
		    cylinder(r=2*r, h=h);
	   }
	   translate([2*r+l, 2*r, 0]) {
		    cylinder(r=2*r, h=h);
	   }  
   }
}

module rounded_rect_p_x (r, l, h) {
   difference () {
      rounded_rect_x(r, l, h);
      translate([2*r, 2*r, -1])  {
         cylinder(r=r, h=h+2);
      }  
      translate([2*r, l+2*r, -1])  {
         cylinder(r=r, h=h+2);
      } 
   }
}

module rounded_rect_y (r, l, h) {
   $rect_l = l;
   $rect_w = 4 * r;
   $rect_h = h;
   union () {
	   translate([0, 2*r, 0]) {
		    cube([$rect_w, $rect_l, $rect_h]);
	   }
	   translate([2*r, 2*r, 0]) {
		    cylinder(r=2*r, h=h);
	   }
	   translate([2*r, 2*r+l, 0]) {
		    cylinder(r=2*r, h=h);
	   }  
   }
}


module rounded_rect_p_y (r, l, h) {
   difference () {
      rounded_rect_y(r, l, h);
      translate([2*r, 2*r, -1])  {
         cylinder(r=r, h=h+2);
      }  
      translate([2*r, l+2*r, -1])  {
         cylinder(r=r, h=h+2);
      } 
   }
}

module mitered_box_x (ww, ll, hh) {
   $rr=ww/3;
   $lll = ll - 2*$rr; 
   translate ([$rr,$rr,0]) {
      minkowski() {
         cube([$lll,$rr,hh]);
         cylinder(r=$rr,h=hh);
      }
   }
}

module mitered_box_y (ww, ll, hh) {
   $rr=ww/3;
   $lll = ll - 2*$rr; 
   translate ([$rr,$rr,0]) {
      minkowski() {
         cube([$rr,$lll,hh]);
         cylinder(r=$rr,h=hh);
      }
   }
}

module duemilanove_hole_pattern_x (depth) {
    translate([0,0,0]) {
       cylinder(r=1.5,h=depth);
    }
    translate([0,27.9,0]) {
       cylinder(r=1.5,h=depth);
    }
    translate([50.8,27.9 + 15.2,0]) {
       cylinder(r=1.5,h=depth);
    }
}

module duemilanove_hole_pattern_y (depth) {
    translate([0,0,0]) {
       cylinder(r=1.5,h=depth);
    }
    translate([27.9,0,0]) {
       cylinder(r=1.5,h=depth);
    }
    translate([27.9 + 15.2, 50.8,0]) {
       cylinder(r=1.5,h=depth);
    }
}

module workspace_bounds(x, y) {
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

$pierced = 1;
if (1 == $pierced) {
   union () {
      rounded_rect_p_x(r=5, l=60, h=6.35);
      rounded_rect_p_y(r=5, l=60, h=6.35);
   }
} else {
   union () {
      rounded_rect_x(r=5, l=60, h=6.35);
      rounded_rect_y(r=5, l=60, h=6.35);
   }
}
