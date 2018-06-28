run_analysis <- function(){
        #Reading persons ID's
        testSubject <- read.table("./test/subject_test.txt",  header = FALSE)
        trainSubject <- read.table("./train/subject_train.txt", header = FALSE)
        
        #Reading activities
        testy <- read.table("./test/y_test.txt",  header = FALSE)
        trainy <- read.table("./train/y_train.txt", header = FALSE)
        
        #Reading dataset
        testx <- read.table("./test/X_test.txt",  header = FALSE)
        trainx <- read.table("./train/X_train.txt", header = FALSE)

        #Reading activity labels
        activity_label <- read.table("activity_labels.txt")

        #Make a dataframe of all test elements and a dataframe of all training elements
        test_df <- cbind(testSubject, testy, testx)
        train_df <- cbind(trainSubject, trainy, trainx)  
        
        #Merge test and train dataframes and give appropriate labels
        names <- c("identity", "activity", as.character(read.table("features.txt")[,2]))
        combined_df <- rbind(test_df, train_df)
        names(combined_df) <- names
        
        # to select the mean and standard deviation columns and make a new dataframe with only these columns
        mean_std_col <- grep("mean|std|identity|activity", names(combined_df))
        mean_and_std_df <- combined_df[mean_std_col]
        
        by_id <- group_by(mean_and_std_df, identity, activity)
        final_df <- summarise_each(by_id, funs(mean))
}
