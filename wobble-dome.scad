$fa = 3;
$fs = 3;
inch = 25.4;

module wobble_dome(
	build_size,
	dome_height,
	screw_r = 5/2,
	screw_height = 20,
	screw_head_r = 9/2
) {
	screw_h = screw_height;
	cutoff_h = 35;

	function parabola_point(x, k, y) = k*pow(x, 2) + y;

	module screw_hole() {
		cylinder(build_size, r=screw_r, center=true);
		cylinder(screw_head_r - screw_r, screw_r, screw_head_r);
		translate([0, 0, screw_head_r - screw_r])
			cylinder(build_size, r=screw_head_r);
	};

	for(x = [0:4], y = [0:4]) translate([x*build_size, y*build_size]) render(convexity=8) difference(convexity=12) {
		intersection() {
			cylinder(200, r=100);
			sphere(build_size/2);
		};
		translate([0, 0, -1]) render(convexity=6) linear_extrude(build_size) for(a = [0:360/5:360])
			rotate([0, 0, a]) polygon([
				for (x = [-build_size:build_size]) [x, parabola_point(x, 1/56, 40)]
			]);
		for(a = [0:360/5:360]) rotate([0, 0, a + 360/5/2])
			translate([0, build_size/2 - 30, cutoff_h + 20])
				screw_hole();
		cylinder(2*cutoff_h, r=build_size, center=true);
	};
};

wobble_dome(
	build_size = 170,
	dome_height = 55,
	screw_height = inch*3/4
);
