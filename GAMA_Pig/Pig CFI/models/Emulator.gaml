/**
* Name: Emulator
* Based on the internal empty template. 
* Author: Ha Minh Tuan
* Tags: 
*/


model Emulator

global {
	
	list<rgb> colors <- [#blue, #red, #yellow, #brown, #orange,
						 #gray, #green, #cyan, #violet, #black,
						 #pink, #gold, #silver, #purple, #darkblue,
						 #darkred, #darkgoldenrod, #darkorange, #darkgreen, #darkcyan];
	
	file map_init <- image_file("../includes/image/feeding_trough.png");
	list<file> list_of_file;
	list<matrix> list_of_matrix;
	
	
	init {
		// add pig databases to list
		add csv_file("../includes/data/input/5070.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5071.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5072.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5073.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5144.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5146.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5147.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5148.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5149.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5196.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5197.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5198.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5199.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5251.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5252.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5255.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5256.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5297.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5299.csv",",") to: list_of_file;
		add csv_file("../includes/data/input/5301.csv",",") to: list_of_file;
		
		loop i from: 0 to: length(list_of_file) - 1 {
			add matrix(list_of_file[i]) to: list_of_matrix;
		}
		
		create pig_0  number: 1;
		create pig_1  number: 1;
		create pig_2  number: 1;
		create pig_3  number: 1;
		create pig_4  number: 1;
		create pig_5  number: 1;
		create pig_6  number: 1;
		create pig_7  number: 1;
		create pig_8  number: 1;
		create pig_9  number: 1;
		create pig_10 number: 1;
		create pig_11 number: 1;
		create pig_12 number: 1;
		create pig_13 number: 1;
		create pig_14 number: 1;
		create pig_15 number: 1;
		create pig_16 number: 1;
		create pig_17 number: 1;
		create pig_18 number: 1;
		create pig_19 number: 1;
		
		create trough_0 number: 1;
		create trough_1 number: 1;
		create trough_2 number: 1;
		create trough_3 number: 1;
		create trough_4 number: 1;
	}
	
	reflex pause when: cycle = 1145 {
		do pause;
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
	int ID;
	int number;
	matrix data;
	float size <- 1.0;
	rgb color <- colors[number];
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
		} else if (sex = 'Female') {
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
	rgb color <- colors[number];
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
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}
}

species pig_1 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5071;
	int number <- 1;
	matrix data <- list_of_matrix[1];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3,0];
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
		daily_feed_intake <- data[1, int((cycle - 2)/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 3 {
		location <- trough_1(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}

}

species pig_2 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5072;
	int number <- 2;
	matrix data <- list_of_matrix[2];
	rgb color <- colors[number];
	int age <- data[0 ,0];
	float daily_feed_intake <- 1.0;
	int weight <- 22;
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
		location <- trough_2(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}
}

species pig_3 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5073;
	int number <- 3;
	matrix data <- list_of_matrix[3];
	rgb color <- colors[number];
	int age <- data[0 ,0];
	float daily_feed_intake <- 1.0;
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
		location <- trough_3(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}

}

species pig_4 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5144;
	int number <- 4;
	matrix data <- list_of_matrix[4];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
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
		location <- trough_4(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 4 {
		location <- {95.3125, 48.4375};
	}

}

species pig_5 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5146;
	int number <- 5;
	matrix data <- list_of_matrix[5];
	rgb color <- colors[number];
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
	
	reflex go_to_gate_in when: mod (cycle, 8) = 3  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)];  
	}

	reflex eat when: mod(cycle, 8) = 4 {
		location <- trough_0(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 5 {
		location <- {95.3125, 48.4375};
	}

}

species pig_6 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5147;
	int number <- 6;
	matrix data <- list_of_matrix[6];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3,0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 3  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int((cycle - 2)/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 4 {
		location <- trough_1(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 5 {
		location <- {95.3125, 48.4375};
	}

}

species pig_7 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5148;
	int number <- 7;
	matrix data <- list_of_matrix[7];
	rgb color <- colors[number];
	int age <- data[0 ,0];
	float daily_feed_intake <- 1.0;
	int weight <- 22;
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 3  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 4 {
		location <- trough_2(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 5 {
		location <- {95.3125, 48.4375};
	}

}

species pig_8 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5149;
	int number <- 8;
	matrix data <- list_of_matrix[8];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 3  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 4 {
		location <- trough_3(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 5 {
		location <- {95.3125, 48.4375};
	}

}

species pig_9 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5196;
	int number <- 9;
	matrix data <- list_of_matrix[9];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 3  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 4 {
		location <- trough_4(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 5 {
		location <- {95.3125, 48.4375};
	}

}

species pig_10 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5197;
	int number <- 10;
	matrix data <- list_of_matrix[10];
	rgb color <- colors[number];
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
	
	reflex go_to_gate_in when: mod (cycle, 8) = 4  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)];  
	}

	reflex eat when: mod(cycle, 8) = 5 {
		location <- trough_0(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 6 {
		location <- {95.3125, 48.4375};
	}

}

species pig_11 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5198;
	int number <- 11;
	matrix data <- list_of_matrix[11];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3,0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 4  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int((cycle - 2)/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 5 {
		location <- trough_1(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 6 {
		location <- {95.3125, 48.4375};
	}

}

species pig_12 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5199;
	int number <- 12;
	matrix data <- list_of_matrix[12];
	rgb color <- colors[number];
	int age <- data[0 ,0];
	float daily_feed_intake <- 1.0;
	int weight <- 22;
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 4  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 5 {
		location <- trough_2(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 6 {
		location <- {95.3125, 48.4375};
	}

}

species pig_13 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5251;
	int number <- 13;
	matrix data <- list_of_matrix[13];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 4  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 5 {
		location <- trough_3(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 6 {
		location <- {95.3125, 48.4375};
	}

}

species pig_14 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5252;
	int number <- 14;
	matrix data <- list_of_matrix[14];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 4  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 5 {
		location <- trough_4(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 6 {
		location <- {95.3125, 48.4375};
	}

}

species pig_15 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5255;
	int number <- 15;
	matrix data <- list_of_matrix[15];
	rgb color <- colors[number];
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
	
	reflex go_to_gate_in when: mod (cycle, 8) = 5  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)];  
	}

	reflex eat when: mod(cycle, 8) = 6 {
		location <- trough_0(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 7 {
		location <- {95.3125, 48.4375};
	}

}

species pig_16 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5256;
	int number <- 16;
	matrix data <- list_of_matrix[16];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3,0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 5  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int((cycle - 2)/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 6 {
		location <- trough_1(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 7 {
		location <- {95.3125, 48.4375};
	}

}

species pig_17 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5297;
	int number <- 17;
	matrix data <- list_of_matrix[17];
	rgb color <- colors[number];
	int age <- data[0 ,0];
	float daily_feed_intake <- 1.0;
	int weight <- 22;
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 5  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 6 {
		location <- trough_2(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 7 {
		location <- {95.3125, 48.4375};
	}

}

species pig_18 parent: generic_pig  {
	string sex <- "Male";
	int ID <- 5299;
	int number <- 18;
	matrix data <- list_of_matrix[18];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 5  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 6 {
		location <- trough_3(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 7 {
		location <- {95.3125, 48.4375};
	}

}

species pig_19 parent: generic_pig  {
	string sex <- "Female";
	int ID <- 5301;
	int number <- 19;
	matrix data <- list_of_matrix[19];
	rgb color <- colors[number];
	int age <- data[0, 0];
	float daily_feed_intake <- 1.0;
	int weight <- data[3, 0];
	float cumulative_feed_intake <- 0.0;
	
	reflex start_new_day when: (mod (cycle, 8) = 0 and cycle > 0) {
		age <- age + 1;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- {rnd(0.0, 100.0), rnd(57.0, 100.0)};
	}
	
	reflex go_to_gate_in when: mod (cycle, 8) = 5  {
		location <- {43.75, 51.5625};
		weight <- data[3, int(cycle/8)];
		daily_feed_intake <- data[1, int(cycle/8)]; 
	}

	reflex eat when: mod(cycle, 8) = 6 {
		location <- trough_4(0).location;
		cumulative_feed_intake <- cumulative_feed_intake + daily_feed_intake;
	}
	
	reflex go_to_gate_out when: mod (cycle, 8) = 7 {
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
			species pig_0   aspect: base;
			species pig_1   aspect: base;
			species pig_2   aspect: base;
			species pig_3   aspect: base;
			species pig_4   aspect: base;
			species pig_5   aspect: base;
			species pig_6   aspect: base;
			species pig_7   aspect: base;
			species pig_8   aspect: base;
			species pig_9   aspect: base;
			species pig_10  aspect: base;
			species pig_11  aspect: base;
			species pig_12  aspect: base;
			species pig_13  aspect: base;
			species pig_14  aspect: base;
			species pig_15  aspect: base;
			species pig_16  aspect: base;
			species pig_17  aspect: base;
			species pig_18  aspect: base;
			species pig_19  aspect: base;
		}
		
		display Info_display {
			grid vegetation_cell;
			species trough_0 aspect: info;
			species trough_1 aspect: info;
			species trough_2 aspect: info;
			species trough_3 aspect: info;
			species trough_4 aspect: info;
			species pig_0   aspect: info;
			species pig_1   aspect: info;
			species pig_2   aspect: info;
			species pig_3   aspect: info;
			species pig_4   aspect: info;
			species pig_5   aspect: info;
			species pig_6   aspect: info;
			species pig_7   aspect: info;
			species pig_8   aspect: info;
			species pig_9   aspect: info;
			species pig_10  aspect: info;
			species pig_11  aspect: info;
			species pig_12  aspect: info;
			species pig_13  aspect: info;
			species pig_14  aspect: info;
			species pig_15  aspect: info;
			species pig_16  aspect: info;
			species pig_17  aspect: info;
			species pig_18  aspect: info;
			species pig_19  aspect: info;
		}
		
		display CFI_display type: java2D refresh: mod(cycle, 8) = 5 {
			chart "Cumulative Feed Intake" type: series size: {1, 1} position: {0, 0} {
				data "CFI 0"   value: pig_0(0).cumulative_feed_intake   color: pig_0(0).color;
				data "CFI 1"   value: pig_1(0).cumulative_feed_intake   color: pig_1(0).color;
				data "CFI 2"   value: pig_2(0).cumulative_feed_intake   color: pig_2(0).color;
				data "CFI 3"   value: pig_3(0).cumulative_feed_intake   color: pig_3(0).color;
				data "CFI 4"   value: pig_4(0).cumulative_feed_intake   color: pig_4(0).color;
				data "CFI 5"   value: pig_5(0).cumulative_feed_intake   color: pig_5(0).color;
				data "CFI 6"   value: pig_6(0).cumulative_feed_intake   color: pig_6(0).color;
				data "CFI 7"   value: pig_7(0).cumulative_feed_intake   color: pig_7(0).color;
				data "CFI 8"   value: pig_8(0).cumulative_feed_intake   color: pig_8(0).color;
				data "CFI 9"   value: pig_9(0).cumulative_feed_intake   color: pig_9(0).color;
				data "CFI 10"  value: pig_10(0).cumulative_feed_intake  color: pig_10(0).color;
				data "CFI 11"  value: pig_11(0).cumulative_feed_intake  color: pig_11(0).color;
				data "CFI 12"  value: pig_12(0).cumulative_feed_intake  color: pig_12(0).color;
				data "CFI 13"  value: pig_13(0).cumulative_feed_intake  color: pig_13(0).color;
				data "CFI 14"  value: pig_14(0).cumulative_feed_intake  color: pig_14(0).color;
				data "CFI 15"  value: pig_15(0).cumulative_feed_intake  color: pig_15(0).color;
				data "CFI 16"  value: pig_16(0).cumulative_feed_intake  color: pig_16(0).color;
				data "CFI 17"  value: pig_17(0).cumulative_feed_intake  color: pig_17(0).color;
				data "CFI 18"  value: pig_18(0).cumulative_feed_intake  color: pig_18(0).color;
				data "CFI 19"  value: pig_19(0).cumulative_feed_intake  color: pig_19(0).color;
			}
		}
		
		display Weight_display type: java2D refresh: mod(cycle, 8) = 4{
			chart "Weight" type: series size: {1, 1} position: {0, 0} {
				data "Weight 0"   value: pig_0(0).weight   color: pig_0(0).color;
				data "Weight 1"   value: pig_1(0).weight   color: pig_1(0).color;
				data "Weight 2"   value: pig_2(0).weight   color: pig_2(0).color;
				data "Weight 3"   value: pig_3(0).weight   color: pig_3(0).color;
				data "Weight 4"   value: pig_4(0).weight   color: pig_4(0).color;
				data "Weight 5"   value: pig_5(0).weight   color: pig_5(0).color;
				data "Weight 6"   value: pig_6(0).weight   color: pig_6(0).color;
				data "Weight 7"   value: pig_7(0).weight   color: pig_7(0).color;
				data "Weight 8"   value: pig_8(0).weight   color: pig_8(0).color;
				data "Weight 9"   value: pig_9(0).weight   color: pig_9(0).color;
				data "Weight 10"  value: pig_10(0).weight  color: pig_10(0).color;
				data "Weight 11"  value: pig_11(0).weight  color: pig_11(0).color;
				data "Weight 12"  value: pig_12(0).weight  color: pig_12(0).color;
				data "Weight 13"  value: pig_13(0).weight  color: pig_13(0).color;
				data "Weight 14"  value: pig_14(0).weight  color: pig_14(0).color;
				data "Weight 15"  value: pig_15(0).weight  color: pig_15(0).color;
				data "Weight 16"  value: pig_16(0).weight  color: pig_16(0).color;
				data "Weight 17"  value: pig_17(0).weight  color: pig_17(0).color;
				data "Weight 18"  value: pig_18(0).weight  color: pig_18(0).color;
				data "Weight 19"  value: pig_19(0).weight  color: pig_19(0).color;
			}
		}
		
		display CFI_comparison type: java2D refresh: every (1#cycles) {
			chart "CFI compare" type: histogram size: {1, 1} position: {0, 0} {
				data "Pig 0"  value: pig_0(0).cumulative_feed_intake  color: pig_0(0).color;
				data "Pig 1"  value: pig_1(0).cumulative_feed_intake  color: pig_1(0).color;
				data "Pig 2"  value: pig_2(0).cumulative_feed_intake  color: pig_2(0).color;
				data "Pig 3"  value: pig_3(0).cumulative_feed_intake  color: pig_3(0).color;
				data "Pig 4"  value: pig_4(0).cumulative_feed_intake  color: pig_4(0).color;
				data "Pig 5"  value: pig_5(0).cumulative_feed_intake  color: pig_5(0).color;
				data "Pig 6"  value: pig_6(0).cumulative_feed_intake  color: pig_6(0).color;
				data "Pig 7"  value: pig_7(0).cumulative_feed_intake  color: pig_7(0).color;
				data "Pig 8"  value: pig_8(0).cumulative_feed_intake  color: pig_8(0).color;
				data "Pig 9"  value: pig_9(0).cumulative_feed_intake  color: pig_9(0).color;
				data "Pig 10" value: pig_10(0).cumulative_feed_intake color: pig_10(0).color;
				data "Pig 11" value: pig_11(0).cumulative_feed_intake color: pig_11(0).color;
				data "Pig 12" value: pig_12(0).cumulative_feed_intake color: pig_12(0).color;
				data "Pig 13" value: pig_13(0).cumulative_feed_intake color: pig_13(0).color;
				data "Pig 14" value: pig_14(0).cumulative_feed_intake color: pig_14(0).color;
				data "Pig 15" value: pig_15(0).cumulative_feed_intake color: pig_15(0).color;
				data "Pig 16" value: pig_16(0).cumulative_feed_intake color: pig_16(0).color;
				data "Pig 17" value: pig_17(0).cumulative_feed_intake color: pig_17(0).color;
				data "Pig 18" value: pig_18(0).cumulative_feed_intake color: pig_18(0).color;
				data "Pig 19" value: pig_19(0).cumulative_feed_intake color: pig_19(0).color;
			}
		}
		
		display Weight_comparison type: java2D refresh: every (1#cycles) {
			chart "Weight compare" type: histogram size: {1, 1} position: {0, 0} {
				data "Weight 0"  value: pig_0(0).weight  color: pig_0(0).color;
				data "Weight 1"  value: pig_1(0).weight  color: pig_1(0).color;
				data "Weight 2"  value: pig_2(0).weight  color: pig_2(0).color;
				data "Weight 3"  value: pig_3(0).weight  color: pig_3(0).color;
				data "Weight 4"  value: pig_4(0).weight  color: pig_4(0).color;
				data "Weight 5"  value: pig_5(0).weight  color: pig_5(0).color;
				data "Weight 6"  value: pig_6(0).weight  color: pig_6(0).color;
				data "Weight 7"  value: pig_7(0).weight  color: pig_7(0).color;
				data "Weight 8"  value: pig_8(0).weight  color: pig_8(0).color;
				data "Weight 9"  value: pig_9(0).weight  color: pig_9(0).color;
				data "Weight 10" value: pig_10(0).weight color: pig_10(0).color;
				data "Weight 11" value: pig_11(0).weight color: pig_11(0).color;
				data "Weight 12" value: pig_12(0).weight color: pig_12(0).color;
				data "Weight 13" value: pig_13(0).weight color: pig_13(0).color;
				data "Weight 14" value: pig_14(0).weight color: pig_14(0).color;
				data "Weight 15" value: pig_15(0).weight color: pig_15(0).color;
				data "Weight 16" value: pig_16(0).weight color: pig_16(0).color;
				data "Weight 17" value: pig_17(0).weight color: pig_17(0).color;
				data "Weight 18" value: pig_18(0).weight color: pig_18(0).color;
				data "Weight 19" value: pig_19(0).weight color: pig_19(0).color;
			}
		}
	}
}

experiment Optimization type: batch repeat: 2 keep_seed: true until: ( time = 1145 ) {
	
	reflex save_results {
		ask simulations {
			save [pig_0(0).sex, pig_0(0).ID, pig_0(0).age, pig_0(0).daily_feed_intake, pig_0(0).weight, pig_0(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_0.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_1(0).sex, pig_1(0).ID, pig_1(0).age, pig_1(0).daily_feed_intake, pig_1(0).weight, pig_1(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_1.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_2(0).sex, pig_2(0).ID, pig_2(0).age, pig_2(0).daily_feed_intake, pig_2(0).weight, pig_2(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_2.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_3(0).sex, pig_3(0).ID, pig_3(0).age, pig_3(0).daily_feed_intake, pig_3(0).weight, pig_3(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_3.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_4(0).sex, pig_4(0).ID, pig_4(0).age, pig_4(0).daily_feed_intake, pig_4(0).weight, pig_4(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_4.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_5(0).sex, pig_5(0).ID, pig_5(0).age, pig_5(0).daily_feed_intake, pig_5(0).weight, pig_5(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_5.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_6(0).sex, pig_6(0).ID, pig_6(0).age, pig_6(0).daily_feed_intake, pig_6(0).weight, pig_6(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_6.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_7(0).sex, pig_7(0).ID, pig_7(0).age, pig_7(0).daily_feed_intake, pig_7(0).weight, pig_7(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_7.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_8(0).sex, pig_8(0).ID, pig_8(0).age, pig_8(0).daily_feed_intake, pig_8(0).weight, pig_8(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_8.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_9(0).sex, pig_9(0).ID, pig_9(0).age, pig_9(0).daily_feed_intake, pig_9(0).weight, pig_9(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_9.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_10(0).sex, pig_10(0).ID, pig_10(0).age, pig_10(0).daily_feed_intake, pig_10(0).weight, pig_10(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_10.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_11(0).sex, pig_11(0).ID, pig_11(0).age, pig_11(0).daily_feed_intake, pig_11(0).weight, pig_11(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_11.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_12(0).sex, pig_12(0).ID, pig_12(0).age, pig_12(0).daily_feed_intake, pig_12(0).weight, pig_12(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_12.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_13(0).sex, pig_13(0).ID, pig_13(0).age, pig_13(0).daily_feed_intake, pig_13(0).weight, pig_13(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_13.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_14(0).sex, pig_14(0).ID, pig_14(0).age, pig_14(0).daily_feed_intake, pig_14(0).weight, pig_14(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_14.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_15(0).sex, pig_15(0).ID, pig_15(0).age, pig_15(0).daily_feed_intake, pig_15(0).weight, pig_15(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_15.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_16(0).sex, pig_16(0).ID, pig_16(0).age, pig_16(0).daily_feed_intake, pig_16(0).weight, pig_16(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_16.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_17(0).sex, pig_17(0).ID, pig_17(0).age, pig_17(0).daily_feed_intake, pig_17(0).weight, pig_17(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_17.csv" type: "csv";
		}
		
		ask simulations {
			save [pig_18(0).sex, pig_18(0).ID, pig_18(0).age, pig_18(0).daily_feed_intake, pig_18(0).weight, pig_18(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_18.csv" type: "csv";
		}		
		
		ask simulations {
			save [pig_19(0).sex, pig_19(0).ID, pig_19(0).age, pig_19(0).daily_feed_intake, pig_19(0).weight, pig_19(0).cumulative_feed_intake] 
		   		to: "../includes/data/output/real/pig_19.csv" type: "csv";
		}
	}
}

