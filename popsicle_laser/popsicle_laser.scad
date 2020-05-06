

$stick_length = 152;

$stick_width = 18.7;

$diameter = $stick_width;

$first_cylinder_center = $diameter/2;

$cube_start = $diameter/2;

$cube_length = $stick_length - $diameter;

$second_cylinder_center = $first_cylinder_center 
                          + $cube_length;


module popsicle_stick() {
    union() {
        translate([$first_cylinder_center,
                   $first_cylinder_center,
                   0]) {
            cylinder(d=$diameter, h=3);
        }
        translate([$second_cylinder_center,                 
                   $first_cylinder_center,
                   0]) {
            cylinder(d=$diameter, h=3);
        }
        translate([$cube_start,0,0]) {
            cube([$cube_length,$diameter,3]);
        }
    }
}

module make_sticks() {
    for (jj = [0 : 2]) {
        for ( ii = [0 : 10] ){
            translate([jj*$stick_displacement_x,ii*$stick_displacement_y,0]) {
                popsicle_stick();
            }
        }
    }
}

$stick_displacement_x = 156;
$stick_displacement_y = 24;

$flat_for_svg = 1;
if ($flat_for_svg) {
    projection(cut=true) {
        make_sticks();
    }
}
else {
    make_sticks();
}