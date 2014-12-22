// title: OpenJSCAD.org Logo
// author: Rene K. Mueller 
// license: Creative Commons CC BY
// URL: http://openjscad.org/#examples/logo.jscad
// revision: 0.003
// tags: Logo,Intersection,Sphere,Cube

function main() {
    return difference(
               union( 
                    //shoulder
                    /* cube([2,20,5*1.414]).translate([2.5*1.414,0,0]), */

                    // diamond
                    cube([5,20,5]).rotateY(45).translate([0,0,1.414*2.5]), 

                    // body slab
                    cube([30,20,1]).translate([3,0.0]) 
               ),
               //magnet hollow
               cube([3,22,3]).rotateY(45).translate([0.5,-1,1.414*2.5]) 
           );
}
    

/*   return union(
      difference(
         cube({size: 3, center: true}),
         sphere({r:2, center: true})
      ),
      intersection(
          sphere({r: 1.3, center: true}),
          cube({size: 2.1, center: true})
      )
   ).translate([0,0,1.5]).scale(10);
   */
