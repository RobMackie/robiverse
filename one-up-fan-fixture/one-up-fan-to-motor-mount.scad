
$nema_side = 42.3;
$cup_height = 8;
$cup_wall = 2;
$cut_out = 10;

$bolt_inset = 4;
$bolt_radius = 2;
$fan_x = 40;

$total_side = $nema_side + 2 * $cup_wall;
$mid_point = $total_side/2;

$hole_from_midpoint = $fan_x/2 - $bolt_inset;

module make_motor_cup() {
   union() {
		difference() {
	      cube([$nema_side+$cup_wall*2,
	            $nema_side+$cup_wall*2,
	            $cup_height]);
	      translate([$cup_wall,$cup_wall,$cup_wall]) {
	         cube([$nema_side, 
	               $nema_side, 
	               $cup_height-$cup_wall+1]);
	      }
	      translate([$nema_side/2-$cut_out/2+$cup_wall,-1,$cup_wall]) {
	          cube([$cut_out,$cup_wall+2,$cup_height+2]);
	      }
	   }
		translate([0,$nema_side+2*$cup_wall,0]) {
         difference() {
            cube([$nema_side+2*$cup_wall, 10, $cup_wall]);
            translate([$mid_point - $hole_from_midpoint,5,-1]) {
               cylinder(r=$bolt_radius, h=6);
            }
            translate([$mid_point + $hole_from_midpoint,5,-1]) {
               cylinder(r=$bolt_radius, h=6);
            }
         }
      }
   }
}

module make_parts() {
	make_motor_cup();
}

make_parts();