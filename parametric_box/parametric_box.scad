

$slot_length_tab=10;
$slot_length_socket=10;

$material_depth=3.8;
$x_orient=1;
$y_orient=0;

$x_tab_count = 2;
$y_tab_count = 3;

function tab_position(index, side_len, tab_len, tab_count) =  
       (((side_len-tab_len)/tab_count) * index) + tab_len/2 ;

module add_tab(depth, length, x_orientation) {
    if (x_orientation) {
        cube([length, depth, depth]);
    } else {
        cube([depth, length, depth]);
    }
}

$tab_counter = 8;

module tab_flat(width, length, mat_depth) {

    union() {
        translate([mat_depth, mat_depth, 0]) {
            cube([width, length, mat_depth]);
        }
        for (index = [ 0 : $tab_counter-1]) {
            translate([mat_depth + tab_position(index, width, $slot_length_tab, $tab_counter),0,0]) {
                add_tab(mat_depth, $slot_length_tab, $x_orient);
            }
        }
        for (index = [ 0 : $tab_counter-1]) {
            translate([mat_depth + tab_position(index, width, $slot_length_tab, $tab_counter),length+mat_depth,0]) {
                add_tab(mat_depth, $slot_length_tab, $x_orient);
            }
        }
    }
}

module socket_flat(width, length, mat_depth) {
    
}

module make_box(width, length, heigh, mat_deptht) {
    
    
}


tab_flat(150, 100, $material_depth);



/*
translate([10, 0, 0]) {
    add_tab($material_depth, $slot_length_tab, $x_orient);
}
translate([30, 0, 0]) {
    add_tab($material_depth, $slot_length_tab, $x_orient);
}
*/


