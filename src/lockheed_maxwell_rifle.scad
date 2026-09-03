// =========================================================================
// LOCKHEED-MAXWELL SPECIFICATION - FULL INTEGRATED ASSEMBLY
// Features: Solid-state field intake, quantum cells, hex logic, muzzle nozzle
// =========================================================================

$fn = 50;

// Unified Structural Parameters (Metric mm)
barrel_len    = 450;
receiver_len  = 250;
handle_h      = 110;
stock_len     = 220;
barrel_od     = 26;
nozzle_len    = 90;

module lockheed_maxwell_weapon_system() {
    color("SlateGray") receiver_core();
    color("DimGray") core_barrel_with_uv_rail();
    color("DarkSlateGray") stock_buffer_system();
    color("Black") pistol_grip_with_ehd_intake();
    color("Gold") quantum_power_bay();
    color("Green") hex_logic_compartment();
    
    // Mount the Magnetic Nozzle onto the end of the barrel
    translate([receiver_len / 2 + barrel_len, 0, 0])
        rotate([0, 90, 0])
            color("Cyan") magnetic_nozzle_assembly();
}

// 1. Double-Sided EHD Compression Intake Grip
module pistol_grip_with_ehd_intake() {
    translate([receiver_len * 0.4, 0, -handle_h]) {
        difference() {
            // Main stealth polygon chassis
            linear_extrude(height = handle_h, scale = [1.2, 0.9]) {
                polygon(points = [[0,0], [45,5], [35,-10], [-5,-5]]);
            }
            // Vertical pneumatic routing core
            translate([22, 0, -2])
                cylinder(h = handle_h + 5, d = 14);
            // Dual-sided EHD collector/emitter mesh grid array slots
            for (z_pos = [15 : 20 : handle_h - 10]) {
                translate([-10, 0, z_pos]) cube([60, 4, 3], center = true);
            }
        }
    }
}

// 2. Quantum Power Array Housing
module quantum_power_bay() {
    translate([10, -15, 10]) {
        difference() {
            cube([90, 30, 35]); // External shield block
            translate([5, 3, 5])
                cube([80, 24, 25]); // Cavity for 24k fractured matrix
        }
        // Rubber dampener contact mount pads
        translate([-4, 15, 15]) cylinder(h = 10, d = 8);
        translate([94, 15, 15]) cylinder(h = 10, d = 8);
    }
}

// 3. Hexadecimal Analog Logic Bay
module hex_logic_compartment() {
    translate([receiver_len * 0.35, -20, -35]) {
        difference() {
            cube([75, 40, 30]); // Heavy copper trace shielding block
            translate([3, 3, 3])
                cube([69, 34, 24]); // Internal PCB layer bounds
            // Photonic line feedthroughs
            translate([15, -2, 12]) rotate([-90, 0, 0]) cylinder(h = 44, d = 6);
        }
    }
}

// 4. Upper Lockheed Chassis Base
module receiver_core() {
    difference() {
        cube([receiver_len, 25, 50], center = true);
        translate([0, 0, 5])
            rotate([0, 90, 0]) cylinder(h = receiver_len + 10, d = 18, center = true);
    }
}

// 5. Linear Gun Bore
module core_barrel_with_uv_rail() {
    translate([receiver_len / 2, 0, 0]) {
        rotate([0, 90, 0]) {
            difference() {
                cylinder(h = barrel_len, d = barrel_od); // Structural shroud
                cylinder(h = barrel_len + 2, d = 12);     // Central UV plasma guide
            }
        }
    }
}

// 6. Recoil Dampening Stock
module stock_buffer_system() {
    translate([-receiver_len / 2 - stock_len, -10, -15]) {
        cube([stock_len, 20, 45]);
    }
}

// 7. Muzzle Magnetic Nozzle Submodule
module magnetic_nozzle_assembly() {
    difference() {
        union() {
            cylinder(h = nozzle_len * 0.7, d1 = barrel_od + 6, d2 = 38, center = false);
            translate([0, 0, nozzle_len * 0.7])
                cylinder(h = nozzle_len * 0.3, d1 = 38, d2 = 36, center = false);
        }
        // Converging-diverging throat geometries
        cylinder(h = nozzle_len * 0.4, d1 = barrel_od - 10, d2 = 10, center = false);
        translate([0, 0, nozzle_len * 0.4])
            cylinder(h = nozzle_len * 0.6 + 1, d1 = 10, d2 = barrel_od, center = false);
        // Helical thermal cooling passages
        for (ang = [0 : 45 : 360]) {
            rotate([0, 0, ang]) translate([17, 0, -5]) cylinder(h = nozzle_len + 10, d = 2.5);
        }
    }
}

// Render Project Wireframe Topology
lockheed_maxwell_weapon_system();

