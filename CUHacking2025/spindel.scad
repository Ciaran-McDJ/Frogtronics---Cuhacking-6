// Author: Ciaran McDonald-Jensen
// Date: Mar 16, 2025
// CUHacking 2025 Spindel for Jumping Frog
// V1.0 5:34am start

$fn = $preview ? 32 : 64;
delta = 0.01;

motorShaftInnerRad = 2.35/2;
// motorShaftOuterRad = 10;
motorShaftHeight = 15;

spoolWidth = 5;
spoolHeight = 8;

blockWidth = 9;
blockAngledHeight = 3;
blockFlatHeight = 5;

bearingShaftRad = 7.9/2;
bearingShaftHeight = 10;

tinyHoleRad = 1.2;
tinyHoleExtraShift = 6;

loopHeight = 2;
loopMaxRad = 2.5;
loopMinRad = 1;







totalHeight = 7*blockAngledHeight + 4*blockFlatHeight + 3*spoolHeight + bearingShaftHeight;

// difference() {
//     cylinder(motorShaftHeight, r=motorShaftOuterRad);
//     translate([0,0,-delta]) cylinder(motorShaftHeight+2*delta, r=motorShaftInnerRad);
// }


module structure() {
    for (i = [0:2]) {
        translate([0,0,i*(blockAngledHeight*2+blockFlatHeight+spoolHeight)]) {
            cylinder(blockAngledHeight, r1=spoolWidth, r2=blockWidth);
            translate([0,0,blockAngledHeight]) cylinder(blockFlatHeight, r=blockWidth);
            translate([0,0,blockAngledHeight+blockFlatHeight]) cylinder(blockAngledHeight, r1=blockWidth, r2=spoolWidth);
            translate([0,0,blockAngledHeight*2+blockFlatHeight]) cylinder(spoolHeight, r=spoolWidth);
        }
    }
    translate([0,0,blockAngledHeight*6+blockFlatHeight*3+spoolHeight*3]) cylinder(blockAngledHeight, r1=spoolWidth, r2=blockWidth);
    translate([0,0,blockAngledHeight*7+blockFlatHeight*3+spoolHeight*3]) cylinder(blockFlatHeight, r=blockWidth);
    translate([0,0,blockAngledHeight*7+blockFlatHeight*4+spoolHeight*3]) cylinder(bearingShaftHeight, r=bearingShaftRad);
}

module holeStick() {
    translate([0,50,0]) rotate(90, [1,0,0]) cylinder(100, r=tinyHoleRad);
}


difference() {
    union() {
        structure();
        //Loops
    }

    // Motor Shaft
    translate([0,0,-delta]) cylinder(motorShaftHeight+2*delta, r=motorShaftInnerRad);

    //Holes
    for (i = [0:2]) {
        translate([0,0, (2+2*i)*blockAngledHeight + (1+i)*blockFlatHeight + i*spoolHeight + tinyHoleExtraShift])
        holeStick();
    }
}

// holeStick();

// translate([motor]) cylinder()