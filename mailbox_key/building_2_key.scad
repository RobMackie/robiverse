$fn=64;

$letter_v = 20;
$letter_extrude = 5;

module make_parts() {
    union() {
        difference() {
            cube([70, 28, 1]);
            translate([10,3,-1]) {
                string("bld 2", $letter_v, $letter_extrude);
            }
            translate([4,14,-1]) {
                cylinder(r=2, h=3);
            }
        }
        
        translate([17.5,0,0]) {
            cube([1, 28, 1]);
        }
        translate([38,0,0]) {
            cube([1, 28, 1]);
        }
        
    }
}

module string(word, word_size, extrude_mm) {
	// Use linear_extrude() to make the letters 3D objects as they
	// are only 2D shapes when only using text()
	linear_extrude(height = extrude_mm) {
		text(word, size = word_size, font = font, halign = "left", valign = "bottom", $fn = 64);
	}
}


$2d = 1;
if ($2d) {
    projection(cut=true) {
       translate([0,0,0]) rotate([0,0,0]) {
         make_parts();
       }
    }
} else {
    translate([0,0,0]) rotate([0,0,0]) {
        make_parts();
    }
}