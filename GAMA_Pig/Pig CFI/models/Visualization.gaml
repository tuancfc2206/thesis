/**
* Name: Visualization
* Author: Ha Minh Tuan - 17021348
* Tags: 
*/


model Visualization

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
	
	file map_init <- image_file("../includes/image/final_map.png");

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
	}
}

species generic_pig {
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
		location <- my_cell.location;
	}
	
	reflex basic_move {
		my_cell <- one_of(my_cell.neighbors2);
		location <- my_cell.location;
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
	}
	
	aspect info {
		draw rectangle(size * 2, size * 4) color: color;
		draw string(weight_per_week) size: 2 color: #black;
	}
}

// declare pig 0;
species pig_0 parent: generic_pig {
	rgb color <- #blue;
	list<int> age <- list_of_matrix[0] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[0] column_at 1;
	list<int> weight <- list_of_matrix[0] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[0] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
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

// declare pig 1;
species pig_1 parent: generic_pig {
	rgb color <- #red;
	list<int> age <- list_of_matrix[1] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[1] column_at 1;
	list<int> weight <- list_of_matrix[1] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[1] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[1] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[1] <- list_of_cfi_index[1] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[1] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[1] - 1];
	}
}

// declare pig 2;
species pig_2 parent: generic_pig {
	rgb color <- #yellow;
	list<int> age <- list_of_matrix[2] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[2] column_at 1;
	list<int> weight <- list_of_matrix[2] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[2] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[2] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[2] <- list_of_cfi_index[2] + 1;
	}
	
	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[2] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[2] - 1];
	}
}

// declare pig 3;
species pig_3 parent: generic_pig {
	rgb color <- #brown;
	list<int> age <- list_of_matrix[3] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[3] column_at 1;
	list<int> weight <- list_of_matrix[3] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[3] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[3] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[3] <- list_of_cfi_index[3] + 1;
	}
	
	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[3] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[3] - 1];
	}
}

// declare pig 4;
species pig_4 parent: generic_pig {
	rgb color <- #orange;
	list<int> age <- list_of_matrix[4] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[4] column_at 1;
	list<int> weight <- list_of_matrix[4] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[4] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[4] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[4] <- list_of_cfi_index[4] + 1;
	}
	
	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[4] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[4] - 1];
	}
}

// declare pig 5;
species pig_5 parent: generic_pig {
	rgb color <- #gray;
	list<int> age <- list_of_matrix[5] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[5] column_at 1;
	list<int> weight <- list_of_matrix[5] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[5] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[5] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[5] <- list_of_cfi_index[5] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[5] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[5] - 1];
	}
}

// declare pig 6;
species pig_6 parent: generic_pig {
	rgb color <- #green;
	list<int> age <- list_of_matrix[6] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[6] column_at 1;
	list<int> weight <- list_of_matrix[6] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[6] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[6] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[6] <- list_of_cfi_index[6] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[6] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[6] - 1];
	}
}

// declare pig 7;
species pig_7 parent: generic_pig {
	rgb color <- #cyan;
	list<int> age <- list_of_matrix[7] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[7] column_at 1;
	list<int> weight <- list_of_matrix[7] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[7] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[7] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[7] <- list_of_cfi_index[7] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[7] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[7] - 1];
	}
}

// declare pig 8;
species pig_8 parent: generic_pig {
	rgb color <- #violet;
	list<int> age <- list_of_matrix[8] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[8] column_at 1;
	list<int> weight <- list_of_matrix[8] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[8] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[8] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[8] <- list_of_cfi_index[8] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[8] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[8] - 1];
	}
}

// declare pig 9;
species pig_9 parent: generic_pig {
	rgb color <- #black;
	list<int> age <- list_of_matrix[9] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[9] column_at 1;
	list<int> weight <- list_of_matrix[9] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[9] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[9] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[9] <- list_of_cfi_index[9] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[9] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[9] - 1];
	}
}

// declare pig 10;
species pig_10 parent: generic_pig {
	rgb color <- #violet;
	list<int> age <- list_of_matrix[10] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[10] column_at 1;
	list<int> weight <- list_of_matrix[10] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[10] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[10] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[10] <- list_of_cfi_index[10] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[10] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[10] - 1];
	}
}

// declare pig 11;
species pig_11 parent: generic_pig {
	rgb color <- #gold;
	list<int> age <- list_of_matrix[11] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[11] column_at 1;
	list<int> weight <- list_of_matrix[11] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[11] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[11] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[11] <- list_of_cfi_index[11] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[11] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[11] - 1];
	}
}

// declare pig 12;
species pig_12 parent: generic_pig {
	rgb color <- #silver;
	list<int> age <- list_of_matrix[12] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[12] column_at 1;
	list<int> weight <- list_of_matrix[12] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[12] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[12] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[12] <- list_of_cfi_index[12] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[12] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[12] - 1];
	}
}

// declare pig 13;
species pig_13 parent: generic_pig {
	rgb color <- #purple;
	list<int> age <- list_of_matrix[13] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[13] column_at 1;
	list<int> weight <- list_of_matrix[13] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[13] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[13] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[13] <- list_of_cfi_index[13] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[13] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[13] - 1];
	}
}

// declare pig 14;
species pig_14 parent: generic_pig {
	rgb color <- #darkblue;
	list<int> age <- list_of_matrix[14] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[14] column_at 1;
	list<int> weight <- list_of_matrix[14] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[14] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[14] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[14] <- list_of_cfi_index[14] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[14] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[14] - 1];
	}
}

// declare pig 15;
species pig_15 parent: generic_pig {
	rgb color <- #darkred;
	list<int> age <- list_of_matrix[15] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[15] column_at 1;
	list<int> weight <- list_of_matrix[15] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[15] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[15] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[15] <- list_of_cfi_index[15] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[15] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[15] - 1];
	}
}

// declare pig 16;
species pig_16 parent: generic_pig {
	rgb color <- #darkgoldenrod;
	list<int> age <- list_of_matrix[16] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[16] column_at 1;
	list<int> weight <- list_of_matrix[16] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[16] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[16] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[16] <- list_of_cfi_index[16] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[16] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[16] - 1];
	}
}

// declare pig 17;
species pig_17 parent: generic_pig {
	rgb color <- #darkorange;
	list<int> age <- list_of_matrix[17] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[17] column_at 1;
	list<int> weight <- list_of_matrix[17] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[17] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[17] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[17] <- list_of_cfi_index[17] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[17] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[17] - 1];
	}
}

// declare pig 18;
species pig_18 parent: generic_pig {
	rgb color <- #darkgreen;
	list<int> age <- list_of_matrix[18] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[18] column_at 1;
	list<int> weight <- list_of_matrix[18] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[18] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[18] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[18] <- list_of_cfi_index[18] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[18] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[18] - 1];
	}
}

// declare pig 19;
species pig_19 parent: generic_pig {
	rgb color <- #darkcyan;
	list<int> age <- list_of_matrix[19] column_at 0;
	list<float>daily_feed_intake <- list_of_matrix[19] column_at 1;
	list<int> weight <- list_of_matrix[19] column_at 3;
	list<float> cumulative_feed_intake <- list_of_matrix[19] column_at 4;
	float cfi <- 0;
	int weight_per_week <- weight[0];
	
	reflex init_flag {
		list_of_flag[19] <- length(cumulative_feed_intake) - 1;
	}
	
	reflex increase {
		list_of_cfi_index[19] <- list_of_cfi_index[19] + 1;
	}

	float cfi_after_eat {
		return daily_feed_intake[list_of_cfi_index[19] - 1] with_precision 3;
	}
	
	int weight_after_weigh {
		return weight[list_of_cfi_index[19] - 1];
	}
}

// init area;
grid vegetation_cell width: 64 height: 64 neighbors: 8 {
	float max_food <- 1.0;
	float food_prod <- rnd(0.01);
	float food <- rnd(1.0) update: food + food_prod;
	rgb color <- rgb (map_init at {grid_x,grid_y});
	list<vegetation_cell> neighbors2  <- (self neighbors_at 8);
}

experiment Pig_display {
	output {	
		display Main_display {
			grid vegetation_cell;
			species pig_0  aspect: base;
			species pig_1  aspect: base;
			species pig_2  aspect: base;
			species pig_3  aspect: base;
			species pig_4  aspect: base;
			species pig_5  aspect: base;
			species pig_6  aspect: base;
			species pig_7  aspect: base;
			species pig_8  aspect: base;
			species pig_9  aspect: base;
			species pig_10 aspect: base;
			species pig_11 aspect: base;
			species pig_12 aspect: base;
			species pig_13 aspect: base;
			species pig_14 aspect: base;
			species pig_15 aspect: base;
			species pig_16 aspect: base;
			species pig_17 aspect: base;
			species pig_18 aspect: base;
			species pig_19 aspect: base;
			
		}
		
		display Info_display {
			grid vegetation_cell;
			species pig_0  aspect: info;
			species pig_1  aspect: info;
			species pig_2  aspect: info;
			species pig_3  aspect: info;
			species pig_4  aspect: info;
			species pig_5  aspect: info;
			species pig_6  aspect: info;
			species pig_7  aspect: info;
			species pig_8  aspect: info;
			species pig_9  aspect: info;
			species pig_10 aspect: info;
			species pig_11 aspect: info;
			species pig_12 aspect: info;
			species pig_13 aspect: info;
			species pig_14 aspect: info;
			species pig_15 aspect: info;
			species pig_16 aspect: info;
			species pig_17 aspect: info;
			species pig_18 aspect: info;
			species pig_19 aspect: info;
		}
		
		display CFI_display type: java2D refresh: every (1#cycles){
			chart "Cumulative Feed Intake" type: series size: {1, 1} position: {0, 0} {
				data "CFI 0"  value: pig_0(0).cfi  color: pig_0(0).color;
				data "CFI 1"  value: pig_1(0).cfi  color: pig_1(0).color;
				data "CFI 2"  value: pig_2(0).cfi  color: pig_2(0).color;
				data "CFI 3"  value: pig_3(0).cfi  color: pig_3(0).color;
				data "CFI 4"  value: pig_4(0).cfi  color: pig_4(0).color;
				data "CFI 5"  value: pig_5(0).cfi  color: pig_5(0).color;
				data "CFI 6"  value: pig_6(0).cfi  color: pig_6(0).color;
				data "CFI 7"  value: pig_7(0).cfi  color: pig_7(0).color;
				data "CFI 8"  value: pig_8(0).cfi  color: pig_8(0).color;
				data "CFI 9"  value: pig_9(0).cfi  color: pig_9(0).color;
				data "CFI 10" value: pig_10(0).cfi color: pig_10(0).color;
				data "CFI 11" value: pig_11(0).cfi color: pig_11(0).color;
				data "CFI 12" value: pig_12(0).cfi color: pig_12(0).color;
				data "CFI 13" value: pig_13(0).cfi color: pig_13(0).color;
				data "CFI 14" value: pig_14(0).cfi color: pig_14(0).color;
				data "CFI 15" value: pig_15(0).cfi color: pig_15(0).color;
				data "CFI 16" value: pig_16(0).cfi color: pig_16(0).color;
				data "CFI 17" value: pig_17(0).cfi color: pig_17(0).color;
				data "CFI 18" value: pig_18(0).cfi color: pig_18(0).color;
				data "CFI 19" value: pig_19(0).cfi color: pig_19(0).color;
			}
		}
		
		display CFI_comparison type: java2D refresh: every (1#cycles) {
			chart "CFI compare" type: histogram size: {1, 1} position: {0, 0} {
				data "Pig 0"  value: pig_0(0).cfi  color: pig_0(0).color;
				data "Pig 1"  value: pig_1(0).cfi  color: pig_1(0).color;
				data "Pig 2"  value: pig_2(0).cfi  color: pig_2(0).color;
				data "Pig 3"  value: pig_3(0).cfi  color: pig_3(0).color;
				data "Pig 4"  value: pig_4(0).cfi  color: pig_4(0).color;
				data "Pig 5"  value: pig_5(0).cfi  color: pig_5(0).color;
				data "Pig 6"  value: pig_6(0).cfi  color: pig_6(0).color;
				data "Pig 7"  value: pig_7(0).cfi  color: pig_7(0).color;
				data "Pig 8"  value: pig_8(0).cfi  color: pig_8(0).color;
				data "Pig 9"  value: pig_9(0).cfi  color: pig_9(0).color;
				data "Pig 10" value: pig_10(0).cfi color: pig_10(0).color;
				data "Pig 11" value: pig_11(0).cfi color: pig_11(0).color;
				data "Pig 12" value: pig_12(0).cfi color: pig_12(0).color;
				data "Pig 13" value: pig_13(0).cfi color: pig_13(0).color;
				data "Pig 14" value: pig_14(0).cfi color: pig_14(0).color;
				data "Pig 15" value: pig_15(0).cfi color: pig_15(0).color;
				data "Pig 16" value: pig_16(0).cfi color: pig_16(0).color;
				data "Pig 17" value: pig_17(0).cfi color: pig_17(0).color;
				data "Pig 18" value: pig_18(0).cfi color: pig_18(0).color;
				data "Pig 19" value: pig_19(0).cfi color: pig_19(0).color;
			}
		}
		
		display Weight_display type: java2D refresh: every (1#cycles) {
			chart "Weight" type: series size: {1, 1} position: {0, 0} {
				data "Weight 0"  value: pig_0(0).weight_per_week  color: pig_0(0).color;
				data "Weight 1"  value: pig_1(0).weight_per_week  color: pig_1(0).color;
				data "Weight 2"  value: pig_2(0).weight_per_week  color: pig_2(0).color;
				data "Weight 3"  value: pig_3(0).weight_per_week  color: pig_3(0).color;
				data "Weight 4"  value: pig_4(0).weight_per_week  color: pig_4(0).color;
				data "Weight 5"  value: pig_5(0).weight_per_week  color: pig_5(0).color;
				data "Weight 6"  value: pig_6(0).weight_per_week  color: pig_6(0).color;
				data "Weight 7"  value: pig_7(0).weight_per_week  color: pig_7(0).color;
				data "Weight 8"  value: pig_8(0).weight_per_week  color: pig_8(0).color;
				data "Weight 9"  value: pig_9(0).weight_per_week  color: pig_9(0).color;
				data "Weight 10" value: pig_10(0).weight_per_week color: pig_10(0).color;
				data "Weight 11" value: pig_11(0).weight_per_week color: pig_11(0).color;
				data "Weight 12" value: pig_12(0).weight_per_week color: pig_12(0).color;
				data "Weight 13" value: pig_13(0).weight_per_week color: pig_13(0).color;
				data "Weight 14" value: pig_14(0).weight_per_week color: pig_14(0).color;
				data "Weight 15" value: pig_15(0).weight_per_week color: pig_15(0).color;
				data "Weight 16" value: pig_16(0).weight_per_week color: pig_16(0).color;
				data "Weight 17" value: pig_17(0).weight_per_week color: pig_17(0).color;
				data "Weight 18" value: pig_18(0).weight_per_week color: pig_18(0).color;
				data "Weight 19" value: pig_19(0).weight_per_week color: pig_19(0).color;
			}
		}
			
		display Weight_comparison type: java2D refresh: every (1#cycles) {
			chart "Weight_compare" type: histogram size: {1, 1} position: {0, 0} {
				data "Pig 0"  value: pig_0(0).weight_per_week  color: pig_0(0).color;
				data "Pig 1"  value: pig_1(0).weight_per_week  color: pig_1(0).color;
				data "Pig 2"  value: pig_2(0).weight_per_week  color: pig_2(0).color;
				data "Pig 3"  value: pig_3(0).weight_per_week  color: pig_3(0).color;
				data "Pig 4"  value: pig_4(0).weight_per_week  color: pig_4(0).color;
				data "Pig 5"  value: pig_5(0).weight_per_week  color: pig_5(0).color;
				data "Pig 6"  value: pig_6(0).weight_per_week  color: pig_6(0).color;
				data "Pig 7"  value: pig_7(0).weight_per_week  color: pig_7(0).color;
				data "Pig 8"  value: pig_8(0).weight_per_week  color: pig_8(0).color;
				data "Pig 9"  value: pig_9(0).weight_per_week  color: pig_9(0).color;
				data "Pig 10" value: pig_10(0).weight_per_week color: pig_10(0).color;
				data "Pig 11" value: pig_11(0).weight_per_week color: pig_11(0).color;
				data "Pig 12" value: pig_12(0).weight_per_week color: pig_12(0).color;
				data "Pig 13" value: pig_13(0).weight_per_week color: pig_13(0).color;
				data "Pig 14" value: pig_14(0).weight_per_week color: pig_14(0).color;
				data "Pig 15" value: pig_15(0).weight_per_week color: pig_15(0).color;
				data "Pig 16" value: pig_16(0).weight_per_week color: pig_16(0).color;
				data "Pig 17" value: pig_17(0).weight_per_week color: pig_17(0).color;
				data "Pig 18" value: pig_18(0).weight_per_week color: pig_18(0).color;
				data "Pig 19" value: pig_19(0).weight_per_week color: pig_19(0).color;
			}
		}
	}
}

