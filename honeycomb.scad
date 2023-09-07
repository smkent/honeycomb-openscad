/**
 * Honeycomb library
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * URL: https://www.thingiverse.com/thing:2484395
 *
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

// parametric honeycomb
module honeycomb(x, y, dia, wall, whole_only=false)  {
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

    // a single filled hexagon
    module hexagon(xoff, yoff)  {
        radius = dia / 2;
        if (
                !whole_only || (
                    (xoff - radius >= -x/2 && xoff + radius <= x/2)
                    && (yoff - radius >= -y/2 && yoff + radius <= y/2)
                )
        ) {
            echo(x, y, "|", xoff, yoff);
            translate([xoff, yoff])
            circle(d=dia, $fn=6);
        }
    }

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
            hexagon(xOffset, yOffset);
            hexagon(xOffset + dia*3/4 + projWall, yOffset + (smallDia+wall)/2);
        }
    }
}
