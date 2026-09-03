// =========================================================================
// LOCKHEED-MAXWELL HYBRID RIFLE CHASSIS BLUEPRINT
// Integration: RT Hexadecimal Logic & Room-Temp Quantum Snap-Circuit Power
// =========================================================================

$fn = 50;

// Primary Dimensions (SWaP-C Optimized)
barrel_length = 450;
receiver_length = 250;
handle_height = 110;
stock_length = 220;

module main_assembly() {
    color("SlateGray") receiver_core();
    color("DimGray") barrel_assembly();
    color("DarkSlateGray") stock_buffer_system();
    color("Black") pistol_grip_with_intake();
    color("Gold") quantum_power_bay();
    color("Green") hex_logic_compartment();
}

// 1. Pistol Grip with Integrated Bottom Air Intake
module pistol_grip_with_intake() {
    translate([receiver_length * 0.4, 0, -handle_height]) {
        difference() {
            // Main angular handle structure (Lockheed Stealth Geometry)
            linear_extrude(height = handle_height, scale = [1.2, 0.9]) {
                polygon(points = [[0,0], [35,-10], [45,25], [10,35]]);
            }
            
            // Hollow Core for Air Intake Conduit
            translate([22, 7, -2])
                cylinder(h = handle_height + 5, d = 14);
                
            // Bottom Intake Vent Slits
            for (i = [0 : 3]) {
                translate([12 + (i*6), 7, 2])
                    cube([3, 16, 8], center = true);
            }
        }
    }
}

// 2. Quantum Power Module (Fractured Gold Lattice Array)
module quantum_power_bay() {
    // Positioned in upper receiver for balance
    translate([10, -15, 10]) {
        difference() {
            // Shielded outer housing
            cube([90, 30, 40]);
            
            // Internal pocket for the 24k fractured gold lattice nodes
            translate([5, 3, 5])
                cube([80, 24, 30]);
        }
        // Integrated rubber shock absorber mounts (shocks.scad integration)
        translate([-4, 10, 15]) cylinder(h = 10, d = 8);
        translate([94, 10, 15]) cylinder(h = 10, d = 8);
    }
}

// 3. Hexadecimal Analog Logic Bay (0.0V - 1.0V Processor Housing)
module hex_logic_compartment() {
    // Mounted below the receiver, directly above the handle intake stream
    translate([receiver_length * 0.35, -20, -35]) {
        difference() {
            // Enclosure for 8-layer KiCad Netlist PCB with 3oz copper traces
            cube([110, 40, 30]);
            
            // Inner chamber for components & RT Phase-Change interface
            translate([5, 4, 4])
                cube([100, 32, 22]);
                
            // Photonic memory loop routing paths (EDFA loop clearance)
            translate([15, -2, 10])
                rotate([-90, 0, 0]) cylinder(h = 44, d = 6);
        }
    }
}

// 4. Upper Receiver Assembly
module receiver_core() {
    difference() {
        cube([receiver_length, 25, 50], center = true);
        // Bolt carrier group track
        translate([0, 0, 0])
            rotate([0, 90, 0]) cylinder(h = receiver_length + 10, d = 18, center = true);
    }
}

// 5. Kinetic Barrel with Linear Accelerator Rails
module barrel_assembly() {
    translate([receiver_length / 2, 0, 0]) {
        rotate([0, 90, 0]) {
            // Outer thermal shroud
            difference() {
                cylinder(h = barrel_length, d = 26);
                cylinder(h = barrel_length + 2, d = 12);
            }
        }
    }
}

// 6. Recoil Buffering Stock
module stock_buffer_system() {
    translate([-receiver_length / 2, 0, -10]) {
        rotate([0, -5, 0])
            cube([stock_length, 20, 45]);
    }
}

// Render the complete system
main_assembly();

