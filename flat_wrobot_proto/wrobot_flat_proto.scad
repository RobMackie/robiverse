$inch = 25.4;
$half = $inch/2;
$quarter = $inch/4;
$eigth = $inch/8;
$sixteenth = $inch/16;
$thirtysecondth = $inch/32;

$add_to_tail = 0;

$zip_tie_hole_r = 2.5;

$plate_thickness = 3; // millimeters
$plate_long =              (11.00 + $add_to_tail) * $inch;    
$plate_wide =               6.00 * $inch;
$axle_offset_from_front =   (2.50 + $add_to_tail) * $inch;
$rear_wheel_offset_ff =     (9.00 + $add_to_tail) * $inch;

$gear_box_f2b =             0.75 * $inch;
$gear_box_s2s =             1.00 * $inch;
$gear_box_ledge =           0.50 * $inch;

$r_wheel_base_w =        (1 + 5/8) * $inch;
$r_wheel_base_l =        (1 + 1/4) * $inch;
$bread_board_w =         (2 + 1/8) * $inch;
$bread_board_l =         (3 + 1/4) * $inch;

$hole_offset_from_center_w = 
                       $r_wheel_base_w/2 - (5/32 * $inch) -1;
$hole_offset_from_center_l = 
                       $r_wheel_base_l/2 - (5/32 * $inch);

$battery_offset_ff =           (10 + $add_to_tail) * $inch;
$battery_w =                    1 * $inch;

$sense_slot_l = 1 * $inch;
$sense_slot_w = 3/8 * $inch;

$wire_port_r = 1/4 * $inch;

$potentiometer_offset_ff = $axle_offset_from_front 
                           + $bread_board_l/2 
                           + 1.5 * $inch;
$potentiometer_hole_r = (9/32 * $inch / 2) + 0.2;
                 

module base_plate (length, width) {

   difference () {
      translate([0,0,0]) {
         cube([length, width, $eigth]);
      }
      // left gearbox zip tie holes
      // front  (The zip tie hole radius in the first coord
      // is so that the whole hole is out from under the 
      // fitting
      translate([$axle_offset_from_front - $gear_box_f2b/2
                 - $zip_tie_hole_r,
                 $gear_box_s2s - $gear_box_ledge/2,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // back
      translate([$axle_offset_from_front + $gear_box_f2b/2
                 + $zip_tie_hole_r,
                 $gear_box_s2s - $gear_box_ledge/2,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // right gearbox zip tie holes
      // front
      translate([$axle_offset_from_front - $gear_box_f2b/2
                  - $zip_tie_hole_r,
                 width - $gear_box_s2s + $gear_box_ledge/2,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // back
      translate([$axle_offset_from_front + $gear_box_f2b/2
                 + $zip_tie_hole_r,
                 width - $gear_box_s2s + $gear_box_ledge/2,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
   // back wheel ziptie holes
    // left front
      translate([$rear_wheel_offset_ff
                   - $hole_offset_from_center_l,
                 width/2 - $hole_offset_from_center_w,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }

      translate([$rear_wheel_offset_ff 
                   + $hole_offset_from_center_l,
                 width/2 - $hole_offset_from_center_w,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      translate([$rear_wheel_offset_ff
                   - $hole_offset_from_center_l,
                 width/2 + $hole_offset_from_center_w,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      translate([$rear_wheel_offset_ff
                   + $hole_offset_from_center_l,
                 width/2 + $hole_offset_from_center_w,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // battery holes
      translate([$battery_offset_ff,
                 width/2 + $battery_w/2 + $zip_tie_hole_r,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      translate([$battery_offset_ff,  
                 width/2 - $battery_w/2 - $zip_tie_hole_r ,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // slot for sensor wire cardboard
      translate([0,  
                 width/2 - $sense_slot_w/2,
                 -1]) {
         cube([$sense_slot_l, 
               $sense_slot_w, 
               $plate_thickness + 2]);
      }
      // zip tie holes for breadboard
      translate([$axle_offset_from_front,  
                 width/2 - $bread_board_w/2 
                    - $zip_tie_hole_r ,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      translate([$axle_offset_from_front,  
                 width/2 + $bread_board_w/2 
                    + $zip_tie_hole_r ,
                 -1]) {
         cylinder(r=$zip_tie_hole_r, h=$plate_thickness + 2);
      }
      // wire port for motor wire
      translate([$axle_offset_from_front - $bread_board_l/2 
                   + 3/4 * $inch,  
                 width/2 - $bread_board_w/2 - $wire_port_r,
                 -1]) {
         cylinder(r=$wire_port_r, 
                  h=$plate_thickness + 2);
      }
      // wire port for potentiometer wire
      translate([$axle_offset_from_front + $bread_board_l/2 
                   - 3/4 * $inch,  
                 width/2 + $bread_board_w/2 + $wire_port_r,
                 -1]) {
         cylinder(r=$wire_port_r, 
                  h=$plate_thickness + 2);
      }

/*    //bread board position
      translate([$axle_offset_from_front - $bread_board_l/2,  
                 width/2 - $bread_board_w/2,
                 -1]) {
         cube([$bread_board_l, 
               $bread_board_w, 
               $plate_thickness + 2]);
      }      
*/
      // potentiometer mounting hole
      translate([$potentiometer_offset_ff,  
                 width/2,
                 -1]) {
         cylinder(r=$potentiometer_hole_r, h=$plate_thickness + 2);
      }
      // and potentiometer retaining pin holes
      translate([$potentiometer_offset_ff,  
                 width/2 - 7.5,
                 -1]) {
         cylinder(r=$inch/12, h=$plate_thickness + 2);
      }
      translate([$potentiometer_offset_ff,  
                 width/2 + 7.5,
                 -1]) {
         cylinder(r=$inch/14, h=$plate_thickness + 2);
      }
   }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
          base_plate($plate_long, $plate_wide);
       }
    }
} else {
   translate([0,0,0]) rotate([0,0,0]) {
      base_plate($plate_long, $plate_wide);
   }
}

