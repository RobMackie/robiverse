//$t_numbers0 = ["6523"];

/*
 Team numbers for up to 12 voltmeters at a time
 Just fill this table with team numbers. An empty 
 array will not generate a chassis, a missing entry
 will not generate a chassis. Do not add more 
 than 3 entries per row for print bed dimensions 
 */



/* 
   Code to generate the voltmeter chassis and then to read the numbers and create objects
*/

$thickness = 5;
$x_dir = 20;
$y_dir = 28;

module voltmeter_chassis(t_number, name) {
    union() {
        translate([0,52,0]) {
            rotate([0,0,270]) {
                import("battery_indicator.stl", convexity=3);
            }
        }
    
        // Add team number
        translate([$x_dir, $y_dir, $thickness]) {
            linear_extrude(3) text(t_number, size = 7);        
        }
        translate([$x_dir-5, $y_dir-23, $thickness]) {
            linear_extrude(3) text(name, size = 5);        
        }    
    }
}


$t_numbers0 = ["3459", "3459", "3459"];
$t_names0 = ["PyroTech", "PyroTech", "PyroTech"];

$length = len($t_numbers0);
for($count1 = [0 : $length-1]) {
    translate([70*$count1, 0, 0]) {
        voltmeter_chassis($t_numbers0[$count1], $t_names0[$count1]);
    }
}




