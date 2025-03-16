// Author: Ciaran McDonald-Jensen
// Date: Mar 16, 2025
// CUHacking 2025 Base of Jumping Frog
// V1.0 0:
//done making vars and basic vector at 2:50 (lots of other stuff)

$fn = $preview ? 32 : 64;
delta = 0.01;
AMOUNT_TO_CUT_DOWN = 5;

// PARAMETERS

// Overall
bigSideLength = 60;
bigHeight = 8;

// Triangle cutouts
smallCutoutsSideLength = 10;
smallCutoutsOffset = 20;

// Crossbar
crossbarThickness = 0;
crossbarArbitraryShiftOut = 15;
crossbarArbitraryShiftIn = 0;

// Peg Holes
pegHoleRad = 5;
pegHoleHeight = AMOUNT_TO_CUT_DOWN;
pegHoleOffsetIn = 7;

// DC Motor Cutout
motorBoxLength = 20;
motorBoxWidth = 17.5;
motorBoxPropFullyCut = 0.3;
motorBoxHeightDown = AMOUNT_TO_CUT_DOWN;
motorBoxHeightUp = 17;
motorBoxWallThickness = 2;

// Edge Cut
edgeCutLength = 20;
extraEdgeCutLength = 4;

// Edge wheels
wheelRad = 8;
wheelThickness = 2.5-0.1;
wheelGap = 5; //big middle joint
heightLeg2Joint = 2.5;

// Edge wheels holes
tinyHoleRad = 1.2;
extraHoleOffset = 3;

// Side Loops
TODO = 1; //Do this if have time

direction3D = [[0,-1,0], [sqrt(3)/2, 0.5, 0], [-sqrt(3)/2, 0.5, 0]];
direction2D = [[0,-1], [sqrt(3)/2, 0.5], [-sqrt(3)/2, 0.5]];



module triangularPrism(sideLength, height) { //centers at 0,0,0
    linear_extrude(height)
    polygon(([direction2D[0], direction2D[1], direction2D[2]])*sideLength);
}

module wheel() {
    translate([0,0,bigHeight+wheelRad]) {
        rotate(90, [0,1,0]) {
            difference() {
                translate([0, 0, -wheelThickness-wheelGap/2]) {
                    // wheels
                    translate([0,0,0]) cylinder(wheelThickness, r=wheelRad);
                    translate([0,0,wheelThickness+wheelGap]) cylinder(wheelThickness, r=wheelRad);
                    // base of wheels
                    translate([0,-wheelRad,0]) cube([wheelRad,wheelRad,wheelThickness]);
                    translate([0,-wheelRad,wheelThickness+wheelGap]) cube([wheelRad,wheelRad,wheelThickness]);
                }
                //Extra Holes
                translate([0,0,-20]) cylinder(50, r=tinyHoleRad);
                translate([extraHoleOffset, extraHoleOffset,-20]) cylinder(50, r=tinyHoleRad);
                translate([extraHoleOffset, -extraHoleOffset,-20]) cylinder(50, r=tinyHoleRad);
                translate([-extraHoleOffset, +extraHoleOffset,-20]) cylinder(50, r=tinyHoleRad);
                translate([-extraHoleOffset, -extraHoleOffset,-20]) cylinder(50, r=tinyHoleRad);
            }
        }
    }
}

difference() {
    union() {
        difference() {
            difference() {
                
                union() {
                    // Base
                    triangularPrism(bigSideLength, bigHeight);
                    
                    // Motor Box Walls
                    translate([0,0,motorBoxHeightUp/2]) cube([motorBoxLength+motorBoxWallThickness*2, motorBoxWidth+motorBoxWallThickness*2, motorBoxHeightUp], center=true);
                }

                // Small Cutouts
                translate(direction3D[0]*smallCutoutsOffset+[0,0,-1]) triangularPrism(smallCutoutsSideLength, bigHeight+100);
                translate(direction3D[1]*smallCutoutsOffset+[0,0,-1]) triangularPrism(smallCutoutsSideLength, bigHeight+100);
                translate(direction3D[2]*smallCutoutsOffset+[0,0,-1]) triangularPrism(smallCutoutsSideLength, bigHeight+100);

                // Peg Holes
                translate([0,0,bigHeight-pegHoleHeight]) {
                    translate((bigSideLength/2 - pegHoleOffsetIn)*(direction3D[0]+direction3D[1])) cylinder(pegHoleHeight+100, r=pegHoleRad);
                    translate((bigSideLength/2 - pegHoleOffsetIn)*(direction3D[1]+direction3D[2])) cylinder(pegHoleHeight+100, r=pegHoleRad);
                    translate((bigSideLength/2 - pegHoleOffsetIn)*(direction3D[2]+direction3D[0])) cylinder(pegHoleHeight+100, r=pegHoleRad);
                }

                //DC Motor Cutout
                translate([-motorBoxLength/2,-motorBoxWidth/2,bigHeight-motorBoxHeightDown]) cube([motorBoxLength,motorBoxWidth,500]);
                translate([-motorBoxLength/2,-motorBoxWidth/2,-50]) cube([motorBoxLength, motorBoxWidth*motorBoxPropFullyCut, 200]);
            }

            // Edge Cuts
            rotate(60) translate([-50,bigSideLength-edgeCutLength,-delta]) cube([100, 100,100]);
            rotate(180) translate([-50,bigSideLength-edgeCutLength,-delta]) cube([100, 100, 100]); // This one doesnt work
            // translate([-500, -100-bigHeight+edgeCutLength, 0]) cube([1000, 100, -delta]);
            rotate(300) translate([-50,bigSideLength-edgeCutLength,-delta]) cube([100, 100,100]);

        }
        // Crossbars
        translate(direction3D[2]*(crossbarArbitraryShiftOut)) 
        rotate(60) translate([-crossbarThickness/2, 0, 0]) 
        cube([crossbarThickness, bigSideLength-crossbarArbitraryShiftOut-edgeCutLength-crossbarArbitraryShiftIn, bigHeight]);
        
        translate(direction3D[0]*(crossbarArbitraryShiftOut)) 
        rotate(180) translate([-crossbarThickness/2, 0, 0]) 
        cube([crossbarThickness, bigSideLength-crossbarArbitraryShiftOut-edgeCutLength-crossbarArbitraryShiftIn, bigHeight]);
        
        translate(direction3D[1]*(crossbarArbitraryShiftOut)) 
        rotate(300) translate([-crossbarThickness/2, 0, 0]) 
        cube([crossbarThickness, bigSideLength-crossbarArbitraryShiftOut-edgeCutLength-crossbarArbitraryShiftIn, bigHeight]);

        // Edge Wheels
        rotate(60) translate([0, bigSideLength-edgeCutLength, 0]) wheel();
        rotate(180) translate([0, bigSideLength-edgeCutLength, 0]) wheel();
        rotate(300) translate([0, bigSideLength-edgeCutLength, 0]) wheel();


        



        //TODO if have time also add little loops to guide wires
    }

    //Extra tiny ones
        
    rotate(60)
    translate([-wheelGap/2, bigSideLength-edgeCutLength-extraEdgeCutLength, -delta])
    cube([wheelGap, extraEdgeCutLength+delta, bigHeight+delta*2]);

    rotate(180)
    translate([-wheelGap/2, bigSideLength-edgeCutLength-extraEdgeCutLength, -delta])
    cube([wheelGap, extraEdgeCutLength+delta, bigHeight+delta*2]);

    rotate(300)
    translate([-wheelGap/2, bigSideLength-edgeCutLength-extraEdgeCutLength, -delta])
    cube([wheelGap, extraEdgeCutLength+delta, bigHeight+delta*2]);

}


