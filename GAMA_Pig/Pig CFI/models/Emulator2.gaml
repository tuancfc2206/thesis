/**
* Name: Emulator2
* Based on the internal empty template. 
* Author: Imspiron 7590
* Tags: 
*/


model Emulator2

global {
	file map_init <- image_file("../includes/image/feeding_trough.png");
	list<file> list_of_file;
	list<matrix> list_of_matrix;
	
	
	init {
		
		add csv_file("../includes/data/input/5070.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5071.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5072.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5073.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5144.csv",",") to: list_of_file;
		
		loop i from: 0 to: length(list_of_file) - 1 {
			add matrix(list_of_file[i]) to: list_of_matrix;
		}
		
		create pig_0 number: 1;
		create pig_1 number: 1;
		
		create trough_0 number: 1;
		create trough_1 number: 1;
		create trough_2 number: 1;
		create trough_3 number: 1;
		create trough_4 number: 1;
	}
}

species generic_trough {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
	
	aspect info {
		draw rectangle(size * 4, size * 21) color: color;
	}
		
}

species trough_0 parent: generic_trough {
	init {
		location <- {50.78125, 21.875};
	}
}

species trough_1 parent: generic_trough{
	init {
		location <- {58.59375, 21.875};
	}
}

species trough_2 parent: generic_trough{
	init {
		location <- {67.96875, 21.875};
	}
}

species trough_3 parent: generic_trough{
	init {
		location <- {75.78125, 21.875};
	}
}

species trough_4 parent: generic_trough{
	init {
		location <- {85.15625, 21.875};
	}
}

species generic_pig {
	string sex;
	int ID <- 5070;
	int number;
	matrix data;
	float size <- 1.0;
	rgb color;
	int age;
	float daily_feed_intake;
	int weight;
	float cumulative_feed_intake;
	vegetation_cell my_cell <- one_of(vegetation_cell);

	init {
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex start_new_day {
		
	}
	
	reflex basic_move {

	}
	
	
	reflex go_to_gate_in  {
		
	} 
	
	reflex eat {
		
	}
	
	reflex go_to_gate_out {
		
	}
		
	aspect base {
		if (sex = "Male") {
			draw rectangle(size * 2, size * 4) color: color;
		} else if (sex = "Female") {
			draw circle(size * 1.6) color: color;
		}
		
	}
	
	aspect info {
		if (sex = "Male") {
			draw rectangle(size * 2, size * 4) color: color;
		} else if (sex = "Female") {
			draw circle(size * 1.6) color: color;
		}
		
		draw string("    " + ID) size: 8 color: #black;
	}
}

species pig_0 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5070;
	int number <- 0;
	matrix data <- list_of_matrix[0];
	rgb color <- #blue;
	int age <- data[0, 0];
	float daily_feed_intake <- 0.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
		
	reflex go_to_gate_in when: mod (cycle, 8) = 2  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)];  
	}

	reflex eat when: mod(cycle, 8) = 3 {
		location <- trough_0(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
		write(cumulative_feed_intake);
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}
	

}

species pig_1 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5071;
	int number <- 1;
	matrix data <- list_of_matrix[1];
	rgb color <- #blue;
	int age <- data[0, 0];
	float daily_feed_intake <- 0.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
		
	reflex go_to_gate_in when: mod (cycle, 8) = 2  {
		location <- trough_2(0).location;
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)];  
	}

	reflex eat when: mod(cycle, 8) = 3 {
		location <- trough_0(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
		write(cumulative_feed_intake);
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}

}

grid vegetation_cell width: 64 height: 64 neighbors: 8 {
	rgb color <- rgb (map_init at {grid_x,grid_y});
	list<vegetation_cell> neighbors2  <- (self neighbors_at 8);
}

experiment Pig_display {
	output {	
		display Main_display {
			grid vegetation_cell;
			species trough_0 aspect: base;
			species trough_1 aspect: base;
			species trough_2 aspect: base;
			species trough_3 aspect: base;
			species trough_4 aspect: base;
			species pig_0  aspect: base;
			species pig_1  aspect: base;
		}
		
		display Info_display {
			grid vegetation_cell;
			species trough_0 aspect: info;
			species trough_1 aspect: info;
			species trough_2 aspect: info;
			species trough_3 aspect: info;
			species trough_4 aspect: info;
			species pig_0  aspect: info;
			species pig_1  aspect: info;
		}
		
		display CFI_display type: java2D refresh: mod(cycle, 8) = 5 {
			chart "Cumulative Feed Intake" type: series size: {1, 1} position: {0, 0} {
				data "CFI 0" value: pig_0(0).cumulative_feed_intake color: pig_0(0).color;
			}
		}
		
		display Weight_display type: java2D refresh: mod(cycle, 8) = 4{
			chart "Weight" type: series size: {1, 1} position: {0, 0} {
				data "Weight 0"  value: pig_0(0).weight color: pig_0(0).color;
				
			}
		}
	}
}

experiment Optimization type: batch repeat: 2 keep_seed: true until: ( time = 1145 ) {
	
	reflex save_results_explo {
		ask simulations {
			save [pig_0(0).sex, pig_0(0).ID, pig_0(0).age, pig_0(0).daily_feed_intake, pig_0(0).weight, pig_0(0).cumulative_feed_intake] 
		   		to: "../includes/data/demo_pig_0.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_1(0).sex, pig_1(0).ID, pig_1(0).age, pig_1(0).daily_feed_intake, pig_1(0).weight, pig_1(0).cumulative_feed_intake] 
		   		to: "../includes/data/demo_pig_1.csv" type: "csv";
		}
	}
}

