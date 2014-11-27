
$fn=128;
$height = 7;
difference () {
   cylinder(r=15, h=$height);
   translate([11,0,-1]) {
      cylinder(r=1.2	, h=$height+2);
   }
   translate([-2,0,2]) {
      cylinder(r=9.8, h=$height-1);
   }
   translate([-10,-20,-1]) {
      rotate([0,0,15]) {
         cube([40,10,$height+2]);
      }
   }
   translate([-12,+10,-1]) {
      rotate([0,0,-15]) {
         cube([40,10,$height+2]);
      }
   }
}

