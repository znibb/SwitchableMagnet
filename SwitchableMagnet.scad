// Parameters
discHeight = 4;
outerDiam = 70;
centerAxisDiam = 20;
centerWallThickness = 1;
outerAxisDiam = 10;
outerAxisRadius = 25;
magnetDiameter = 3.2;
magnetLength = 3.175;
centerPlatformHeight = 2;
shaftSide = 3;
shaftHeight = 10;
handleDiam = 40;
handleHeight = 3;

module base() {
    cylinder(discHeight, outerDiam/2, outerDiam/2);
}

module centerAxis() {
    translate([0, 0, -1])
    cylinder(discHeight+2, centerAxisDiam/2, centerAxisDiam/2);
}

module outerAxis() {
    for (i = [0:5]) {
        translate([outerAxisRadius*cos(i*60), outerAxisRadius*sin(i*60), -1])
        cylinder(discHeight+2, outerAxisDiam/2, outerAxisDiam/2);
    }
}

module magnetCavity() {
    for (i = [0:5]) {
        translate([0, 0, discHeight/2])
        rotate([-90, 0, i*60+30])
        translate([0, 0, centerAxisDiam/2+centerWallThickness])
        cylinder(outerDiam, magnetDiameter/2, magnetDiameter/2);
    }
}

module bottom() {
    difference() {
        base();
        centerAxis();
        outerAxis();
        magnetCavity();
    }
}

module top() {
    translate([0, 0, discHeight])
    union() {
        bottom();
  
        translate([0, 0, discHeight])
        cylinder(centerPlatformHeight, centerAxisDiam/2+2*magnetLength*1.2, centerAxisDiam/2);
        
        translate([0, 0, discHeight+centerPlatformHeight+shaftSide/2])
        cube([shaftSide, shaftSide, shaftHeight], true);
    }
}


module handle() {
    translate([0, 0, discHeight*2+centerPlatformHeight+shaftHeight/2])
    difference() {
        cylinder(handleHeight, handleDiam/2, handleDiam/2);
        
        
    }
}

bottom();
top();
handle();

echo(str("Magnet stack length: ", outerAxisRadius-outerAxisDiam/2-centerAxisDiam/2-centerWallThickness, " mm"));