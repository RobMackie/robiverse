$inch = 25.4;
$plate_thick = $inch/4;
$half_inch = $inch/2;
$q_inch = $inch/4;
$slot_width = 16;
$slot_center_to_center = 60;
$first_slot_offset = 15;
$2nd_slot_offset = $first_slot_offset + $slot_center_to_center;
$r_bolt = $q_inch/2 + 0.05;


module top_half () {
    difference () {
       cube([108, 60, 6.35]);
         translate([$first_slot_offset,-1,$q_inch/2])  {
            cube([$slot_width, 62, 6.35]);
         }
         translate([$2nd_slot_offset,-1,$q_inch/2])  {
            cube([$slot_width, 62, 6.35]);
         }
         translate([7,10,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([7,30,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([7,50,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([101,10,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([101,30,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([101,50,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([54,10,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([54,30,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
         translate([54,50,-0.5]) {
             cylinder(r=$r_bolt,h=7);
         }
   }
}


top_half();
