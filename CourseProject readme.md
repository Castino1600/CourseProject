
#### How the script works - Readme ####

1. Load dataset: 

  1) I read the feature name data and I store all the feature names into a vector called "Features"

  2) Read the Test data (without heading), Test Activity Label data, Test Subject data. 

  3) Assign feature names in Features vector to the Test dataset headings

  4) Add one column of Activity label code to the Test data set
 
  5) Add one column of Subject code to the Test data set

  6) Perform the same operations for the Training data


2. Merge the Training and Test data sets by rbind function

3. Subset the data only to mean and std-related features

  1) Identify the features associated with mean and std measures

  2) Construct a vector to store the indices of these features

4. Add a new feature which replace activity codes with actual activity names

5. Use gsub() function to replace vague feature names with more detailed feature names

6. Use melt and dcast functions to arrange the average values for each selected features by subject ID and Activity type


by Castino
