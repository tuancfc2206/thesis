/**
* Name: Pig5070
* Based on the internal empty template. 
* Author: Imspiron 7590
* Tags: 
*/


model Pig5071

global {
	
	file Pig_file <- csv_file("../includes/data/5071.csv",",");
	matrix Pig_matrix <- matrix(Pig_file);
	float Pig_number <- Pig_matrix[3,0];
	list<float> Pig_days <- Pig_matrix column_at 0;
	list<float> Pig_feed_intake <- Pig_matrix column_at 1;
	list<float> Pig_weight_na <- Pig_matrix column_at 2;
	list<float> Pig_weight <- Pig_matrix column_at 3;
	list<float> Cumulative_feed_intake<- Pig_matrix column_at 4;
	
	init {
		write Pig_days;
		write Pig_feed_intake;
		write Pig_weight_na;
		write Pig_weight;
		write Cumulative_feed_intake;
	}
}



experiment Pig {
	output {
		display Pig_display type: java2D{
			chart "Cumulative Feed intake" type: series size: {1, 0.5} position: {0, 0} {
				data "CFI" value: Cumulative_feed_intake color: #blue;
			}
			chart "Weight" type: series size: {1,0.5} position: {0, 50} {
				data "weight" value: Pig_weight color: #red;
			}
		}
	}
}

