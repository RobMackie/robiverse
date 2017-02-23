
$inch = 25.4;

$coupler_d = $inch*1 + $inch/16;
$screw_d = 5 * $inch / 8;
$bolt_r = $inch/8;

//        radius of coupler + some clearance + diameter of bolt + some clearance
$out_r =  $coupler_d/2 + $inch/8 + $inch/4 + $inch/8;
$inner_motor_r = $inch/8 + 0.5;
$inner_screw_r = $screw_d/2 + 0.5;
$bolt_h_r = $inch/8 + 0.25;
$bolt_c_r = $out_r-$bolt_r*2;

$plate = $inch/4;

$detail = 128;

module retainer(outer_r, inner_r, bolt_hole_r, bolt_circle_r, thick) {
    difference() {
        cylinder(r=outer_r, h=thick, $fn=$detail);
        
        translate([0,0,-1]) {
            cylinder(r=inner_r, h=thick+2, $fn=$detail);
        }
    
        $bolt_count = 3;
        $radial_displacement = 360/3;
        for(bolt = [0:$bolt_count - 1]) {
            rotate([0,0,$radial_displacement * bolt]) {
                translate([bolt_circle_r, 0, -1]) {                
                    cylinder(r=bolt_hole_r, h=thick+2, $fn=$detail);
                }
            }
        }
    }
}

module make_parts() {
    translate([0,0,0]) {
        retainer($out_r, $inner_motor_r, $bolt_h_r, $bolt_c_r, $plate);
    }
    translate([$out_r*2+10,0,0]) {
        retainer($out_r, $inner_screw_r, $bolt_h_r, $bolt_c_r, $plate);
    }
}

$2d = 0;
if ($2d) {
    projection(cut=true) {
        translate([$out_r+5,$out_r+5,0]) {
             make_parts();
        }
    }
} else {
    translate([$out_r+5,$out_r+5,0]) {
        make_parts();
    }
}

