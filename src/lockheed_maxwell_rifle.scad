// =========================================================================
// LOCKHEED-MAXWELL SPECIFICATION - FULL INTEGRATED ASSEMBLY (V2)
// Features: Progressive two-stage trigger group, EHD induction, muzzle nozzle
// =========================================================================

$fn = 50;

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
    color("Red") progressive_trigger_mechanism();
    
    translate([receiver_len / 2 + barrel_len, 0, 0])
        rotate([0, 90, 0])
            color("Cyan") magnetic_nozzle_assembly();
}

// Dual-Stage Mechanical/Electronic Trigger Assembly
module progressive_trigger_mechanism() {
    // Located right beneath the lower receiver junction, forward of grip
    translate([receiver_len * 0.28, 0, -22]) {
        union() {
            // Stage 1 Trigger Shoe (Light pre-travel pivot arm)
            rotate([0, 8, 0])
                cube([6, 14, 25], center = true);
                
            // Stage 2 Micro-switch contact point ("The Wall" stop pad)
            translate([-8, 0, -10])
                cube([4, 10, 6], center = true);
                
            // Dual Stage Return Torsion Spring Frame
            translate([2, 0, 8])
                rotate([90, 0, 0]) cylinder(h = 10, d = 4, center = true);
        }
    }
}

module pistol_grip_with_ehd_intake() {
    translate([receiver_len * 0.4, 0, -handle_h]) {
        difference() {
            linear_extrude(height = handle_h, scale = [1.2, 0.9]) {
                polygon(points = [[0,0], [28,0], [35,-10], [-5,-5]]);
            }
            translate([22, 0, -2])
                cylinder(h = handle_h + 5, d = 14);
            for (z_pos = [15 : 20 : handle_h - 10]) {
                translate([-10, 0, z_pos]) cube([30, 20, 4], center = true);
            }
        }
    }
}

module quantum_power_bay() {
    translate([10, -15, 10]) {
        difference() {
            cube([90, 30, 40]);
            translate([5, 5, 5]) cube([80, 20, 30]);
        }
        translate([-4, 15, 15]) cylinder(h = 10, d = 8);
        translate([94, 15, 15]) cylinder(h = 10, d = 8);
    }
}

module hex_logic_compartment() {
    translate([receiver_len * 0.35, -20, -35]) {
        difference() {
            cube([75, 40, 30]);
            translate([4, 4, 4]) cube([67, 32, 22]);
            translate([15, -2, 12]) rotate([-90, 0, 0]) cylinder(h = 44, d = 6);
        }
    }
}

module receiver_core() {
    difference() {
        cube([receiver_len, 25, 50], center = true);
        translate([0, 0, 0])
            rotate([0, 90, 0]) cylinder(h = receiver_len + 10, d = 18, center = true);
    }
}

module core_barrel_with_uv_rail() {
    translate([receiver_len / 2, 0, 0]) {
        rotate([0, 90, 0]) {
            difference() {
                cylinder(h = barrel_len, d = barrel_od);
                cylinder(h = barrel_len + 2, d = 12);
            }
        }
    }
}

module stock_buffer_system() {
    translate([-receiver_len / 2 - stock_len, -10, -15]) {
        cube([stock_len, 20, 45]);
    }
}

module magnetic_nozzle_assembly() {
    difference() {
        union() {
            cylinder(h = nozzle_len * 0.7, d1 = barrel_od + 6, d2 = 38, center = false);
            translate([0, 0, nozzle_len * 0.7])
                cylinder(h = nozzle_len * 0.3, d1 = 38, d2 = 36, center = false);
        }
        cylinder(h = nozzle_len * 0.4, d1 = barrel_od - 10, d2 = 10, center = false);
        translate([0, 0, nozzle_len * 0.4])
            cylinder(h = nozzle_len * 0.6 + 1, d1 = 10, d2 = barrel_od, center = false);
        for (ang = [0 : 45 : 360]) {
            rotate([0, 0, ang]) translate([17, 0, -5]) cylinder(h = nozzle_len + 10, d = 2.5);
        }
    }
}

lockheed_maxwell_weapon_system();
