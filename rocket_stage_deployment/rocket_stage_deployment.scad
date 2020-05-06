
$tube_r = i2mm(1.75);
$resolution = 32;


/* i2mm inch to millimeter 
 *   INPUT
       -- "inch" value expressed as inches
 *   RETURN: 
       -- value expressed as millimeters
 */
function i2mm(inch) = (25.4 * inch);

module doit() {
    cylinder(r=$tube_r, h=i2mm(0.25),$fn=$resolution);   
}



$2d = 0;

if ($2d) {
    projection(cut=true) {
        translate([$tube_r,$tube_r, 0]) {
            doit();
        } 
    }
} else {
    translate([$tube_r,$tube_r, 0]) {
        doit();
    }
}