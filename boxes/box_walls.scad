$one_inch = 25.4;
$quarter = $one_inch/4;
$eigth = $one_inch/8;
$sixteenth = $one_inch/16;

$long = 130;
$short = 73;
$high = 75;

$td=3.175;

$wall_thickness = $eigth;      //material depth
$tab_length = $wall_thickness; // how much tab sticks out to side
$slot_inset = 0;               // slots in how much from edge

$wall_width_side = $long;              // overall width
$wall_height = $high;            // overall height

$wall_width_end = $short;             // overall width

$tab_width = 8; 
              // how long is the tab slot
$low_tab_height = 10;          // how far from end is slot
$high_tab_height = $wall_height - $low_tab_height - $tab_width;

module end_wall()  // wall with tabs
{
	union() {
      // base wall 
		translate([$tab_length,0,0]) 
			  cube([$wall_width_end-(2*$tab_length),
                 $wall_height,
                 $wall_thickness]);
      //lower left tab
      translate([0,$low_tab_height,0]) 
           cube([$tab_length,$tab_width,$wall_thickness]);	
      //upper left tab
      translate([0,$high_tab_height,0]) 
           cube([$tab_length,$tab_width,$wall_thickness]);
      //lower right tab
      translate([$wall_width_end-$tab_length-0.005,$low_tab_height,0]) 
           cube([$tab_length,$tab_width,$wall_thickness]);
      //upper right tab
      translate([$wall_width_end-$tab_length-0.005,$high_tab_height,0]) 
           cube([$tab_length,$tab_width,$wall_thickness]);
    }
}

module side_wall()  // wall with slots
{
	difference() {
		cube([$wall_width_side,$wall_height,$wall_thickness],center);
      // lower left slot
		translate([$slot_inset,
                $low_tab_height,
                -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);	
      // upper left slot	
      translate([$slot_inset,
                 $high_tab_height,
                 -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);
      // lower right slot
      translate([$wall_width_side-$slot_inset-$wall_thickness+0.7,
                 $low_tab_height,
                 -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);
      // upper right slot
      translate([$wall_width_side-$slot_inset-$wall_thickness+0.7,
                $high_tab_height,
                -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);  
	}
}

/*
module bottom_wall()  // wall with slots
{
	difference() {
		cube([$wall_width_side,$wall_height,$wall_thickness],center);
      // lower left slot
		translate([$slot_inset,
                $low_tab_height,
                -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);	
      // upper left slot	
      translate([$slot_inset,
                 $high_tab_height,
                 -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);
      // lower right slot
      translate([$wall_width_side-$slot_inset-$wall_thickness+0.7,
                 $low_tab_height,
                 -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);
      // upper right slot
      translate([$wall_width_side-$slot_inset-$wall_thickness+0.7,
                $high_tab_height,
                -$wall_thickness/4]) 
           cube([$wall_thickness*0.8,$tab_width,$wall_thickness*2]);    
	}
   
}
*/


 
module demo_proj()
{
    
	translate([0,0,0]) side_wall();
	translate([0,$wall_height+10,0]) side_wall();
//	translate([0,2 * $wall_height+20,0]) side_wall(); //floor?
    translate([$wall_width_side+10,0,0]) end_wall();
    translate([$wall_width_side+10,$wall_height+10,0]) end_wall();
   
}

$2d = 1;
if ($2d) {
	projection(cut=true) 
	   translate([0,0,0]) rotate([0,0,0]) 
	     demo_proj();
} else {
    demo_proj();
}