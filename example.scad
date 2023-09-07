/**
 * Simple example of Honeycomb library usage
 * License: Creative Commons - Attribution
 * Copyright: Gael Lafond 2017
 * 
 * Inspired from:
 *   https://www.thingiverse.com/thing:1763704
 */

include <honeycomb.scad>

linear_extrude(10) {
	honeycomb(105, 80, 12, 3);
}
