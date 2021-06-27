model Pig5199

global {
	
	file Pig_file <- csv_file("../includes/data/input/5199.csv",",");
	file Pig_fake_file <- csv_file("../includes/data/output/simulation/fake_pig_12.csv",",");
	
	matrix Pig_matrix <- matrix(Pig_file);
	matrix Pig_fake_matrix <- matrix(Pig_fake_file);
	
	list<float> Pig_weight <- Pig_matrix column_at 3;
	list<float> Cumulative_feed_intake<- Pig_matrix column_at 4;
	
	list<float> Pig_fake_weight <- Pig_fake_matrix column_at 5;
	list<float> Cumulative_feed_intake_fake<- Pig_fake_matrix column_at 6;
	
	init {

		write Pig_weight;
		write Cumulative_feed_intake;
	}
}



experiment Pig {
	output {
		display Pig_display type: java2D{
			chart "Cumulative Feed intake" type: series size: {1, 0.5} position: {0, 0} {
				data "CFI" value: Cumulative_feed_intake color: #blue;
				data "CFI after running" value: Cumulative_feed_intake_fake color: #red;
				
			}
			chart "Weight" type: series size: {1,0.5} position: {0, 50} {
				data "weight" value: Pig_weight color: #blue;
				data "weight after running" value: Pig_fake_weight color: #red;
			}
		}
	}
}