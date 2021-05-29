/**
* Name: Demo
* Based on the internal empty template. 
* Author: Imspiron 7590
* Tags: 
*/


model Demo

global {
	
	
	list<int> list_of_cfi_index <- [0, 0, 0, 0, 0, 
							 		0, 0, 0, 0, 0, 
							 		0, 0, 0, 0, 0, 
							 		0, 0, 0, 0, 0];
	list<int> list_of_flag <- [999, 999, 999, 999, 999,
							   999, 999, 999, 999, 999,
							   999, 999, 999, 999, 999,
							   999, 999, 999, 999, 999];
	
	int count <- 1;
	
	// stop condition
	reflex stop when: (list_of_cfi_index[count] = list_of_flag[count]) {
		do die;
	}
	
	int pig_age;
	float pig_feed_intake;
	float pig_weight;
	float pig_cfi;
	list<file> list_of_file;
	list<matrix> list_of_matrix;
	
	file map_init <- image_file("../includes/image/feeding_trough.png");

	init {
		
		// add database to list file;
		add csv_file("../includes/data/5070.csv",",") to: list_of_file;
		add csv_file("../includes/data/5071.csv",",") to: list_of_file;
		add csv_file("../includes/data/5072.csv",",") to: list_of_file;
		add csv_file("../includes/data/5073.csv",",") to: list_of_file;
		add csv_file("../includes/data/5144.csv",",") to: list_of_file;
		add csv_file("../includes/data/5146.csv",",") to: list_of_file;
		add csv_file("../includes/data/5147.csv",",") to: list_of_file;
		add csv_file("../includes/data/5148.csv",",") to: list_of_file;
		add csv_file("../includes/data/5149.csv",",") to: list_of_file;
		add csv_file("../includes/data/5196.csv",",") to: list_of_file;
		add csv_file("../includes/data/5197.csv",",") to: list_of_file;
		add csv_file("../includes/data/5198.csv",",") to: list_of_file;
		add csv_file("../includes/data/5199.csv",",") to: list_of_file;
		add csv_file("../includes/data/5251.csv",",") to: list_of_file;
		add csv_file("../includes/data/5252.csv",",") to: list_of_file;
		add csv_file("../includes/data/5255.csv",",") to: list_of_file;
		add csv_file("../includes/data/5256.csv",",") to: list_of_file;
		add csv_file("../includes/data/5297.csv",",") to: list_of_file;
		add csv_file("../includes/data/5299.csv",",") to: list_of_file;
		add csv_file("../includes/data/5301.csv",",") to: list_of_file;
	
		// add pig info to list pigs;
		loop i from: 0 to: length(list_of_file) - 1 {
			add matrix(list_of_file[i]) to: list_of_matrix;
		}


		create pig_0 number: 1;
		create prey number: 1;
		create trough_1 number: 1;
		create trough_2 number: 1;
		create trough_3 number: 1;
		create trough_4 number: 1;
		create trough_5 number: 1;
		
	}
}




species prey {
	float size <- 3.0;
	rgb color <- #transparent;
	init {
		location <- {43.75, 51.5625};
	}
	aspect base {
		draw rectangle(size * 4, size * 5) color: color;
	}
	reflex do {
		
	}
}

species trough_1 {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	init {
		location <- {50.78125, 21.875};
	}
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
}

species trough_2 {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	init {
		location <- {58.59375, 21.875};
	}
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
}

species trough_3 {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	init {
		location <- {67.96875, 21.875};
	}
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
}

species trough_4 {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	init {
		location <- {75.78125, 21.875};
	}
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
}

species trough_5 {
	float size <- 1.0;
	rgb color <- rgb(80, 118, 255);
	init {
		location <- {85.15625, 21.875};
	}
	aspect base {
		draw rectangle(size * 4, size * 21) color: color;
	}
}


species generic_pig skills: [moving] {
	float size <- 1.0;
	rgb color;
	list<int> age;
	list<float> daily_feed_intake;
	list<int> weight;
	list<float> cumulative_feed_intake;
	float cfi;
	int weight_per_week;
	vegetation_cell my_cell <- one_of(vegetation_cell);

	
	init {
		speed <- 0.0;
		heading <- 90.0;
//		location <- my_cell.location;
	}
	
	reflex basic_move {
//		my_cell <- one_of(my_cell.neighbors2);
////		my_shape <- vegetation_cell.center;
//		location <- my_cell.location;
	}
	
	trough_1 trough1;
	
	
	reflex search_trough when: trough1 != nil {
		ask trough_1 at_distance (1000) {
			myself.trough1 <- self;
		}
	}
	
	reflex follow when: trough1 != nil {
		speed <- 5;
		do goto target: trough1;
	}
	
	reflex init_flag {
		
	}
	
	reflex increase {
		
	}
		
	reflex eat {
		cfi <- cfi + cfi_after_eat();
	}
	
	float cfi_after_eat {
		return 0;
	}
	
	reflex weigh {
		weight_per_week <- weight_after_weigh();
	}
	
	int weight_after_weigh {
		return 0;
	}
	
	vegetation_cell choose_cell {
		return (my_cell.neighbors2) with_max_of (each.food);
	}
	
	aspect base {
		draw rectangle(size * 2, size * 4) color: color;
		if (trough1 != nil) {
			draw polyline ([self.location, trough1.location]) color: #black;
		}
	}
	
	aspect info {
		draw rectangle(size * 2, size * 4) color: color;
		draw string(weight_per_week) size: 2 color: #black;
	}
}

// declare pig 0;
species pig_0 parent: generic_pig  {
	rgb color <- #blue;
	list<int> age <- list_of_matrix[0] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[0] column_at 1;
	list<int> weight <- list_of_matrix[0] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[0] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	
	
	reflex move {
		
	}
	
	reflex init_flag {
		list_of_flag[0] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[0] <- list_of_cfi_index[0] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[0] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[0] - 1];
	}
}

grid vegetation_cell width: 64 height: 64 neighbors: 8 {
	float max_food <- 1.0;
	float food_prod <- rnd(0.01);
	float food <- rnd(1.0) update: food + food_prod;
	rgb color <- rgb (map_init at {grid_x,grid_y});
	list<vegetation_cell> neighbors2  <- (self neighbors_at 8);
	geometry shape <- circle(1) ;
}

experiment Pig_display {
	output {	
		display Main_display {
			grid vegetation_cell lines: #black;
			species pig_0  aspect: base;
			species prey aspect: base;
			species trough_1 aspect: base;
			species trough_2 aspect: base;
			species trough_3 aspect: base;
			species trough_4 aspect: base;
			species trough_5 aspect: base;
		}
		
//		display Info_display {
//			grid vegetation_cell;
//			species pig_0  aspect: info;
//
//		}
//		
//		display CFI_display type: java2D refresh: every (1#cycles){
//			chart "Cumulative Feed Intake" type: series size: {1, 1} position: {0, 0} {
//				data "CFI 0"  value: pig_0(0).cfi color: pig_0(0).color;
//			}
//		}
	}
}

