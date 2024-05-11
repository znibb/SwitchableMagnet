// Parameters
discHeight = 4;
outerDiam = 70;
centerAxisDiam = 20;
centerWallThickness = 1;
outerAxisDiam = 10;
outerAxisRadius = 25;
magnetDiameter = 3.2;

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

module batteryCavity() {
    for (i = [0:5]) {
        translate([0, 0, discHeight/2])
        rotate([-90, 0, i*60+30])
        translate([0, 0, centerAxisDiam/2+centerWallThickness])
        cylinder(outerDiam, magnetDiameter/2, magnetDiameter/2);
    }
}

module main() {
    difference() {
        base();
        centerAxis();
        outerAxis();
        batteryCavity();
    }
}

main();
//batteryCavity();

echo(str("Magnet stack length: ", outerAxisRadius-outerAxisDiam/2-centerAxisDiam/2-centerWallThickness, " mm"));