/**
 * Honeycomb library
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * URL: https://www.thingiverse.com/thing:2484395
 *
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

// a single filled hexagon
module hexagon(l)  {
    circle(d=l, $fn=6);
}

// parametric honeycomb
module honeycomb(x, y, dia, wall)  {
    // Diagram
    //          ______     ___
    //         /     /\     |
    //        / dia /  \    | smallDia
    //       /     /    \  _|_
    //       \          /   ____
    //        \        /   /
    //     ___ \______/   /
    // wall |            /
    //     _|_  ______   \
    //         /      \   \
    //        /        \   \
    //                 |---|
    //                   projWall
    //
    smallDia = dia * cos(30);
    projWall = wall * cos(30);

    yStep = smallDia + wall;
    xStep = dia*3/2 + projWall*2;

    yStepsCount = ceil((y/2) / yStep);
    xStepsCount = ceil((x/2) / xStep);

    difference() {
        square([x, y]);
        translate([x/2, y/2])
        for (
                yOffset = [-yStep * yStepsCount : yStep : yStep * yStepsCount],
                xOffset = [-xStep * xStepsCount : xStep : xStep * xStepsCount]
        ) {
            translate([xOffset, yOffset]) {
                hexagon(dia);
            }
            translate([xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2]) {
                hexagon(dia);
            }
        }
    }
}
