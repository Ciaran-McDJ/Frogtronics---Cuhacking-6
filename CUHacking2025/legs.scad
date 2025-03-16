// Author: Ciaran McDonald-Jensen
// Date: Mar 15, 2025
// CUHacking 2025 Legs of Jumping Frog
// V4.1 1:30am

$fn = $preview ? 32 : 64;

// Lengths are currently from edge of leg to center of ball joint
lengthLeg1 = 55;
lengthLeg2 = 55;
heightLegs = 10; //should be 2 Leg2Joints + 1 Leg1Joints
heightLeg1Joint = 5; //big middle joint
heightLeg2Joint = 2.5;
grooveCircleRad = 0.7;
grooveOffset = 0; //NOT USED
depthLegs = 8;
ballRad = 8;
tinyHoleRad = 1.2;

tol = 0.1;

// Loop params
loopHeight = 2;
loopMaxRad = 2.5;
loopMinRad = 1;
loopOffsetBack = 2;
loopOffsetOut = 0.5;
loopTopOffsetForward = 10;

// Extra Hole params
extraHoleOffset = 3;

// Pin Params (PEGS)
pinHeight = 3;
pinHeightCutOff = 0.2;
pinOutyRad = 3;
pinHoleRad = 3.1;
pin1Pos = 15; //along length of leg to center of pin
pin2Pos = 40;

module GrooveCutOut() {
    rotate_extrude(convexity = 10)
    translate([ballRad, 0, 0])
        circle(r = grooveCircleRad);
}

//Loop for holding string
module LoopForString() { //positioned so center is at 0,0,0
    rotate(90, [0,1,0]) {
        difference() {
            cylinder(loopHeight, r=loopMaxRad);
            translate([0,0,-1])cylinder(loopHeight+2, r=loopMinRad);
        }
    }
}

//Leg 1 (top)
module Leg1() {
    difference() {
        union() {
            difference() {
                translate([0,0,0]) cube([lengthLeg1,depthLegs,heightLegs]);
                translate([lengthLeg1,depthLegs/2,-1]) cylinder(heightLegs+2, r=ballRad);
                translate([0,depthLegs/2,-1]) cylinder(heightLegs+2, r=ballRad);
            }
            //Circle for joint
            difference() {
                translate([lengthLeg1,depthLegs/2,heightLeg2Joint+tol]) cylinder(heightLeg1Joint-2*tol, r=ballRad);
                translate([lengthLeg1,depthLegs/2,heightLegs/2]) GrooveCutOut();
            }
            //Circle (at top) for other joint
            difference() {
                translate([0,depthLegs/2,heightLeg2Joint+tol]) cylinder(heightLeg1Joint-2*tol, r=ballRad);
                translate([0,depthLegs/2,heightLegs/2]) GrooveCutOut();
            }
            //Loops for string
            translate([lengthLeg1-ballRad-loopOffsetBack, -loopOffsetOut, heightLegs/2]) LoopForString();
            translate([lengthLeg1-ballRad-loopOffsetBack, depthLegs+loopOffsetOut, heightLegs/2]) LoopForString();

            translate([loopTopOffsetForward, -loopOffsetOut, heightLegs/2]) LoopForString();
            translate([loopTopOffsetForward, depthLegs+loopOffsetOut, heightLegs/2]) LoopForString();
        }
        //Axel holes
        translate([lengthLeg1,depthLegs/2,-1]) cylinder(heightLegs+2, r=tinyHoleRad);
        translate([0,depthLegs/2,-1]) cylinder(heightLegs+2, r=tinyHoleRad);

        //Extra Holes
        translate([extraHoleOffset, depthLegs/2+extraHoleOffset,-1]) cylinder(heightLegs+2, r=tinyHoleRad);
        translate([extraHoleOffset, depthLegs/2-extraHoleOffset,-1]) cylinder(heightLegs+2, r=tinyHoleRad);
        translate([-extraHoleOffset, depthLegs/2+extraHoleOffset,-1]) cylinder(heightLegs+2, r=tinyHoleRad);
        translate([-extraHoleOffset, depthLegs/2-extraHoleOffset,-1]) cylinder(heightLegs+2, r=tinyHoleRad);


    }
}


//Leg 2 (bottom)
module Leg2() {
    // translate([0,-30,0]) {
        difference() {
            union() {
                difference() {
                    translate([0,0,0]) cube([lengthLeg2,depthLegs,heightLegs]);
                    translate([lengthLeg2,depthLegs/2,-1]) cylinder(heightLegs+2, r=ballRad);
                }
                //Circle for joint
                translate([lengthLeg2,depthLegs/2,0]) cylinder(heightLeg2Joint-tol, r=ballRad);
                translate([lengthLeg2,depthLegs/2,heightLeg1Joint+heightLeg2Joint+tol]) cylinder(heightLeg2Joint-tol, r=ballRad);
                //Loops for string
                translate([lengthLeg2-ballRad-loopOffsetBack, -loopOffsetOut, heightLegs/2]) LoopForString();
                translate([lengthLeg2-ballRad-loopOffsetBack, depthLegs+loopOffsetOut, heightLegs/2]) LoopForString();
                //Ball Base
                translate([0,depthLegs/2,0]) cylinder(heightLegs, r=ballRad);
            }
            //Pin hole
            translate([lengthLeg2,depthLegs/2,-1]) cylinder(heightLegs+2, r=tinyHoleRad);
        }
    // }
}



// union() {
//     difference() {
//         translate([0,0,-heightLegs/2]) Leg1();
//         translate([0,0,-heightLegs/2]) cube([200, 200, heightLegs], center=true);
//     }
//     translate([pin1Pos,depthLegs/2,heightLegs/2]) cylinder(pinHeight-pinHeightCutOff, r=pinOutyRad);
//     translate([pin2Pos,depthLegs/2,heightLegs/2]) cylinder(pinHeight-pinHeightCutOff, r=pinOutyRad);
// }

// translate([0,-20,0])
// difference() {
//     translate([0,0,-heightLegs/2]) Leg1();
//     translate([0,0,-heightLegs/2]) cube([200, 200, heightLegs], center=true);
//     translate([pin1Pos,depthLegs/2,heightLegs/2-pinHeight]) cylinder(pinHeight+1, r=pinHoleRad);
//     translate([pin2Pos,depthLegs/2,heightLegs/2-pinHeight]) cylinder(pinHeight+1, r=pinHoleRad);
// }

translate([0,20,0])
union() {
    difference() {
        Leg2();
        translate([0,0,heightLegs]) cube([200, 200, heightLegs], center=true);
    }
    translate([pin1Pos,depthLegs/2,heightLegs/2]) cylinder(pinHeight-pinHeightCutOff, r=pinOutyRad);
    translate([pin2Pos,depthLegs/2,heightLegs/2]) cylinder(pinHeight-pinHeightCutOff, r=pinOutyRad);
}

translate([0,40,0])
difference() {
    Leg2();
    translate([0,0,heightLegs]) cube([200, 200, heightLegs], center=true);
    translate([pin1Pos,depthLegs/2,heightLegs/2-pinHeight]) cylinder(pinHeight+1, r=pinHoleRad);
    translate([pin2Pos,depthLegs/2,heightLegs/2-pinHeight]) cylinder(pinHeight+1, r=pinHoleRad);
}



Leg1();

// translate([0,-20,0]) Leg2();
// Leg2();

// LoopForString();
// GrooveCutOut();



