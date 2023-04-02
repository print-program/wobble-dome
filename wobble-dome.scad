$fa = 3;
$fs = 3;
inch = 25.4;

function parabola_point(x, k, y) = k*pow(x, 2) + y;

module wobble_dome(
	build_size,
	dome_height,
	screw_dist = 50,
	screw_r = 5/2,
	screw_height = 20,
	screw_head_r = 9/2
) {
	curve = 1/56;
	dist = 40;
	dome_r = build_size[0]/2;
	//cutoff_h = 35;

	module screw_hole() {
		cylinder(build_size[2], r=screw_r, center=true);
		cylinder(screw_head_r - screw_r, screw_r, screw_head_r);
		translate([0, 0, screw_head_r - screw_r])
			cylinder(build_size[2], r=screw_head_r);
	};

	render(convexity=8) difference() {
		intersection() {
			cylinder(build_size[2], r=100);
			translate([0, 0, dome_height - dome_r]) sphere(dome_r);
		};
		translate([0, 0, -1]) render(convexity=6) linear_extrude(build_size[2]) for(a = [0:360/5:360])
			rotate([0, 0, a]) polygon([
				for (x = [-build_size[0]:build_size[0]]) [x, parabola_point(x, curve, dist)]
			]);
		for(a = [0:360/5:360]) rotate([0, 0, a + 360/5/2])
			translate([0, screw_dist, screw_height])
				screw_hole();
	};
};

build_size = [170, 170, 170];

wobble_dome(
	build_size = build_size,
	dome_height = 55,
	screw_dist = build_size[1]/2 - 30,
	screw_height = inch*3/4
);
