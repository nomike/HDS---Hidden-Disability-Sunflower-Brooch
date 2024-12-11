
$fn =  50;
epsilon = 1;
insert_width = 5.1;
insert_length = 25.5;
knob_diameter = 2;
knob_distance = 6;
layer_height = 0.2;


ray_flower_angel_spacing = 30;
ray_flower_width = 10.6;
ray_flower_length = 16;
ray_flower_gap_correction = 4;
ray_flower_height = layer_height * 5;

disk_flower_radius = 10;
disk_flower_height = layer_height * 15;

insert_height = layer_height * 2;


module knob(d, h) {
    cylinder(d=d, h=h);
}

module sunflower() {
    for(angle = [0 : ray_flower_angel_spacing : 360]) {
        rotate([0, 0, angle]) mirror([(angle / ray_flower_angel_spacing) % 2, 0, 0]) translate([-ray_flower_width/2, disk_flower_radius, 0]) resize([ray_flower_width, ray_flower_length, ray_flower_height]) linear_extrude(ray_flower_height) import("ray_flower.svg");
    }
    for(angle = [ray_flower_angel_spacing / 2 : ray_flower_angel_spacing : 360]) {
         rotate([0, 0, angle])  mirror([(((angle - ray_flower_angel_spacing / 2) / ray_flower_angel_spacing) + 1) % 2, 0, 0])  translate([-ray_flower_width/2, disk_flower_radius, 0]) resize([ray_flower_width, ray_flower_length, ray_flower_height * 2]) linear_extrude(ray_flower_height * 2) import("ray_flower.svg");
    }
    cylinder(r=disk_flower_radius + ray_flower_gap_correction + epsilon, h=disk_flower_height);
}

module insert() {
    difference() {
        translate([0, 0, ((insert_height  + epsilon) / 2) - epsilon]) cube([insert_width, insert_length, insert_height + epsilon], center=true);
        union() {
            translate([0, knob_distance / 2, 0]) knob(d=knob_diameter, h=insert_height + epsilon);
            translate([0, -knob_distance / 2, 0]) knob(d=knob_diameter, h=insert_height + epsilon);
        }
    }
}

difference() {
    difference() {
        sunflower();
        insert();
    }
}
