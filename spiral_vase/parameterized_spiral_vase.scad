/* 
 * Rob Mackie's spiral vase prototype openscad file
 * Open this in openscad version 2015.03-1 
 * 
 *  Change any of the numbers in the parameter block
 */

// Parameter block begin
$top_to_bottom_multiplier = 3;   // a mulitplier, no units. 
                                   // The top radius will be this number 
                                   // times the size of the bottom radius. 
                                   // This vase uses this number in both 
                                   // the x and y dimensions. Using different 
                                   // numbers for x and y has interesting effects.
                                   // the top stops being round.
// The difference between the 2 following numbers is likely your wall
// thickness:
$bottom_outer_wall_radius = 20; // in mm
$bottom_inner_wall_radius = 19.9; // in mm
$sides = 6; // number of sides to polygons pretending to be circles
$twist = 120; // degrees top twists compared to bottom
$height = 120; // height in mm.
$slices = 200; // how smooth do you want the twist? try 2, 10 and 200!
// Parameter block end


// Begin code that you probably only want to touch if you want to
// experiment with different basic concepts.
$fn=$sides;
union() {
    // Extrusion takes a 2D shape and drags it through 3D space to make a 
    // 3D shape. 
    linear_extrude(height = $height, twist = $twist, slices = $slices, scale=[$top_to_bottom_multiplier, $top_to_bottom_multiplier]) {
      difference() {
          circle(r=$bottom_outer_wall_radius);
          circle(r=$bottom_inner_wall_radius);
      }
    }
    cylinder(r=$bottom_outer_wall_radius, h=1);
}


