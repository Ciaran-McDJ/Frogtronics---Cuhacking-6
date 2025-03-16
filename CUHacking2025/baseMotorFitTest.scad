// Author: Ciaran McDonald-Jensen
// Date: Mar 16, 2025
// CUHacking 2025 Base of Jumping Frog - fit test for DC Motor
// Start 0:40am




delta=0.01;

motorLength = 20;
motorWidth = 17;


// motorExtraLength = 8;
// motorExtraWidth = 1;
height = 22;

wallThickness = 2;
bottomThickness = 2;

difference(){
    cube([motorLength+2*wallThickness, motorWidth+2*wallThickness, height]);
    translate([wallThickness, wallThickness, bottomThickness]) cube([motorLength, motorWidth, height+100]);
    translate([wallThickness-delta,wallThickness-delta,-delta]) cube([motorLength+delta, motorWidth/3+delta, 100]);
}


