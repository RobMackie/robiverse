use <../libraries/publicDomainGearV1.1.scad>

$inch=25.4;
$detail=32;

/*
translate([-25.4,-10,0]) {
    cube([25.4*2, 20, 10]);
}
*/
difference() {
    union() {    
        difference() {
         
            union() {
                cylinder(r=$inch*0.449, h=(.144+.313)*$inch, $fn=$detail);
                
                translate([0,0,0.144*$inch/2]) {
                    gear(number_of_teeth=40, pressure_angle=14.5, 
                         mm_per_tooth=3.8, thickness=0.144*$inch, 
                         hole_diameter=0.25*$inch);
                }
            }
            translate([0,0,-1]) {
                cylinder(r=6.2/2, h=(.144+.313)*$inch+2, $fn=$detail);    
            }
        
        }
        translate([-3,-7/2,0]) {
            cube([1.52,7,(0.144+0.313)*$inch]);
        }
    }
    translate([-0.5*$inch,-0.07/2*$inch, 0.144*$inch]) {
        cube([$inch, 0.75, 0.313*$inch+1]);
    }
}