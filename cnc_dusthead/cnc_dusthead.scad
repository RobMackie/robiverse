// test

$inch = 25.4;

$side = 5.125 * $inch;

$hose_hole_r = $inch* 3/4;

module router_cutout() {
    cube([$side, $side, $inch]);
}

// router_cutout();

module dust_cuff() {
    cube([$side+(0.5*$inch), $side+(3.25*$inch), $inch/2]);
}

module hose_hole() {
    cylinder(r=$hose_hole_r, h=$inch,$fn=32);
}

module brush_cut() {
    $bside = $side + $inch;
    $factor = 2.0;
    difference() {
        cube([$bside-$inch*5/8, $bside+($factor*$inch), $inch * 3/8]);
        translate([$inch/8,$inch/8,0]) {
            cube([$bside-$inch*7/8, $bside+($factor*$inch)-$inch/4, $inch/4]);
        }
    }
}

module assembly() {
    difference() {
        dust_cuff();
        translate([$inch/4, $inch*3/8, 0]) {
            router_cutout();
        }
        translate([3.75*$hose_hole_r, (6+7/8)*$inch, 0]) {
            hose_hole();
        }
        translate([$inch*1/16,$inch*1/8,1/4*$inch]) {
            brush_cut();
        }
    }
}

assembly();
/*
translate([0,0,0]) {
    cube([1/4*$inch, 50, 20]);
}
*/