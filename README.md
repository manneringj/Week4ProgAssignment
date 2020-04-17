The script assumes that the R working directory contains the necessary data files. These are:

x_train.txt
y_train.txt
x_test.txt
y_test.text
activity_lables.txt
features.txt

The script contains a number of functions.

IDFeatures
----------
This takes a parameter of the file name containing the feature column numbers and names.  Default value is the 
supplied file name i.e. features.txt

The function identifies the columns that are means or standard deviations and creates a dataframe with their names and
column numbers

LoadAndCombine
--------------
This file loads the training and test file sets.  It take the parameter of the file names and is used on the pair 
of files:

X_test.txt and y_test.txt

and

X_train.txt and y_train.txt

The result is a dataframe for the pair specified.

LoadScript
----------
This is the script the should be run to produce a dataframe as per the spec.

It takes a parameter of the Activities/Name file.  This will default to the name of the 
file in the supplied data i.e.activity_labels.txt

The output of this function is the dataframe required up to step 4 of the specification.

Part5Output
-----------
This function will  output the file as specified in part 5.  It takes as a parameter the datafrom output by function 
LoadScript.

Part5Output(LoadScript())

Will write the file output.txt to the current working directory.  Alternatively run:

MyDataFrameName<-LoadScript()
then
Part5Output(MyDataFrameName)
