// =========================================================================
// LOCKHEED-MAXWELL MUZZLE ATTACHMENT: INTEGRATED MAGNETIC NOZZLE
// Physics: Converging-Diverging Magnetic Fields for Plasmoid Detachment
// =========================================================================

$fn = 60;

// Dimensions matching the primary barrel specs
barrel_outer_d = 26;
nozzle_length = 90;
throat_inner_d = 10;   // Compressed plasma constriction zone
exit_outer_d = 38;     // Diverging stealth shroud exit

module magnetic_nozzle_assembly() {
    difference() {
        // 1. Main Lockheed Stealth Geometric Outer Shroud
        union() {
            // Main body transitioning from barrel mount to wide muzzle exit
            cylinder(h = nozzle_length * 0.7, d1 = barrel_outer_d + 6, d2 = exit_outer_d, center = false);
            translate([0, 0, nozzle_length * 0.7])
                cylinder(h = nozzle_length * 0.3, d1 = exit_outer_d, d2 = exit_outer_d - 2, center = false);
        }

        // 2. Converging-Diverging Inner Plasma Bore
        // Entrance from main barrel
        cylinder(h = nozzle_length * 0.4, d1 = barrel_outer_d - 10, d2 = throat_inner_d, center = false);
        // Diverging expansion zone and detachment plane
        translate([0, 0, nozzle_length * 0.4])
            cylinder(h = nozzle_length * 0.6 + 1, d1 = throat_inner_d, d2 = barrel_outer_d, center = false);

        // 3. Multi-Magnet Coil Chambers (Three-Thick-Coil Layout for Field Tuning)
        // Upstream compression coil chamber
        translate([0, 0, 10])
            toroidal_coil_cavity(inner_r = 11, outer_r = 15, thickness = 15);
            
        // Nozzle throat pinch coil chamber (highest field density)
        translate([0, 0, 32])
            toroidal_coil_cavity(inner_r = 7, outer_r = 13, thickness = 12);
            
        // Downstream expansion/detachment coil chamber
        translate([0, 0, 55])
            toroidal_coil_cavity(inner_r = 10, outer_r = 16, thickness = 20);

        // 4. Helical Active Coolant Channels (Thermal management for 3oz copper windings)
        for (a = [0 : 45 : 360]) {
            rotate([0, 0, a])
                translate([17, 0, -5])
                    cylinder(h = nozzle_length + 10, d = 2.5);
        }
    }
}

// Helper module to cut out precise toroidal rings for electromagnetic coils
module toroidal_coil_cavity(inner_r, outer_r, thickness) {
    difference() {
        cylinder(h = thickness, r = outer_r, center = false);
        translate([0, 0, -1])
            cylinder(h = thickness + 2, r = inner_r, center = false);
    }
}

// Render the detached module blueprint
magnetic_nozzle_assembly();
