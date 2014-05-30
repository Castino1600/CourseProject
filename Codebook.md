CourseProject
=============
The Data Cleaning Project

All necessary data is in a directory UCIDataset on the working directory.

test/x_test.txt – test dataset
train/x_train.txt – training dataset
test/y_test.txt – labels for test dataset
train/y_train.txt – labels for training dataset
activity_labels.txt – descriptive names of activities
test/subject_test.txt – identifier for each subject who performed activity in test dataset
train/subject_train.txt – identifier for each subject who performed activity in train dataset
features.txt – List of all features
Information about Variables

Variables used in within the script

xtest – data frame with row data from x_test.txt
xtrain data frame with row data from x_train.txt
ytest data frame with row data from y_test.txt
ytrain data frame with row data from _train.txt
activitylabels data frame with numeric and descriptive activity
subjecttest data frame with row data from subject_test.txt. Each row identifies subject who performed activity
subjecttrain – data frame with row data from subject_train.txt. Each row identifies subject who performed activity.
colNames – cleaned (lowercase and punctuation removed) labels for features variable
testsAll – binded all tests data
trainAll – binded all training data
allData – binded test & training dataset
measureData – subset of allData only with variables & data with measurements (mean & std)
melted – measureData melted with 2 variables (Subject & Activity
Variable naming

Column names are from features.txt (feature data frame). All names were cleaned by lowercase letters and removing punctuation, underscore, left & right paranthesis.

Variable Selection Measurements extraction was based on labels name with “mean” and standard deviation
Steps in script

Loading data into variable
Cleaning data
Lowercase labels
Removing punctuation & other unnecessary character
Naming missing labels & update cleaning names
Merge datasets and creating one big dataset
Extract datasets with mean & std variable name
Change activities to descriptive name
Creating second, independent tidy dataset
Write tidy data using space separator
