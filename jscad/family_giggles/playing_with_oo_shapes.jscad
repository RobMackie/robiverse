function main() {
  
    var box = new cube([14,14,14]);
    var tube = new cylinder({r:5, h:14});
    var intersection1 = intersection(box,tube);
    var union1 = union(box,tube);
    var difference1 = difference(box,tube);

    return  [
                intersection1.translate([19,19,0]), 
                union1.translate([0,20,0]), 
                difference1.translate([20,20,0])
            ];
}
