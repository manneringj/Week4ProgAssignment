# Function to load the Column names (features) and create a dataframe with the 
# columns that are to be extracted and used

IDFeatures<-function(features="features.txt"){
    #load features list    
     FullFeaturesList<<-read.csv(features,sep=" ",header=FALSE) 
    
     #ID the column names to be used i.e. those contain mean and std
     IDCol <-grepl("*mean\\(|*std\\(",FullFeaturesList$V2)
     
     #Combine the logical with the orginal dataframe and subset the columns needed
     NeededFeaturesID<-cbind(FullFeaturesList,IDCol)
     NeededFeaturesList<<-NeededFeaturesID[NeededFeaturesID$IDCol==TRUE,c(1,2)]
       
}

#Function to load the  the vectors files for test or training, rename the
#columns and combine with activity 

LoadAndCombine<-function (vectorsfile,activitesfile){
    #Set-up column template for import of vectors file
    template<-rep(16,561)
    
    #load the install data files
    Vectors<<-read.fwf(vectorsfile,widths = template ,header=FALSE)
    Activities<<-read.csv(activitesfile,sep=" ",header=FALSE)
    
    #select only the vectors columns that are require
    VectorsRequiredCols<- Vectors[,NeededFeaturesList$V1]
    
    #Rename the column heading
    
    names(VectorsRequiredCols)<-NeededFeaturesList$V2
    
    
    
    #Combine with activities and give approprate column heading to activities
    
    CombinedData<- cbind(Activities,VectorsRequiredCols)
    colnames(CombinedData)[1]<-"Activity"
    
   # Output the combined data dataframe
    
    CombinedData
    
}

#Load Script - Final function to use the function previously defined and
# load the data then combine into a single dataframe with the correct column heading
# and finally outputs the required dataframe 



LoadScript<-function(activities="activity_labels.txt"){
    
# load the activities name lokup table and rename the columns    
    message("... Loading activities lookup information")
    
    ActivitiesLookup<-read.csv(activities,sep=" ",header = FALSE)
    colnames(ActivitiesLookup)<-c("Activity","ActivityName")
    message("Activities lookup information loaded")
    
#Use previously defined function to generate list of needed feature columns
    message("... Loading column definitions")    
    IDFeatures()
    message("Column definition loaded")

# Use previously dedined function to load Training and testing data and combine
    message("... Loading test and train data then combining (this may take some time)")    
    
    CombinedTestTrain<-rbind(LoadAndCombine("X_test.txt","y_test.txt"), LoadAndCombine("X_train.txt","y_train.txt"))

    message("Test and train data loaded")  

# Replace activity numnber with activity name and reorder columns    
    message(".. finalising dataframe")    
  
  CombineTestTrainPlus<-merge(CombinedTestTrain,ActivitiesLookup,by.x="Activity",by.y = "Activity")
    
    CombineTestTrainFinal<- CombineTestTrainPlus[,c(68,2:67)]
    
    
# Outout to dataframe
    
    message("Output dataframe generated") 

    CombineTestTrainFinal
}

## Function to produce the output required in part 5

Part5Output<-function(mydata) {
    #Group and calculate the mean
    mymeans<-sapply(split(mydata,mydata$ActivityName), function (x) colMeans(x[2:67]))
    newmeans<-cbind(rownames(mymeans),mymeans)
    #Remove row labels
    rownames(newmeans) <- c()
    #Add column label
    colnames(newmeans)[1]<-"Feature"
    #Write output file
    write.table(newmeans,"output.txt",row.name=FALSE)
}

