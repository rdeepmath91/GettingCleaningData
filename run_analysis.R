#getting the required directories and files
cd = getwd()
dir1 = paste(cd,"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/test",sep="")
dir2 = paste(cd,"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/train",sep="")
file1 = paste(dir1,"/X_test.txt",sep="")
file2 = paste(dir2,"/X_train.txt",sep="")

#name of features
feat = read.table(paste(cd,"/getdata-projectfiles-UCI HAR Dataset/UCI HAR Dataset/features.txt",sep=""),sep="")
feat = feat[,2]

#extracting the data
X_test= read.table(file1,sep="")
X_train = read.table(file2,sep="")

#naming the colnames
for (i in 1:561) {
    colnames(X_test)[i] = as.character(feat[i])
    colnames(X_train)[i] = as.character(feat[i])
}

#subsetting the features counting either mean() or std()
X_test = X_test[,grepl("mean()",colnames(X_test),fixed=TRUE)|grepl("std()",colnames(X_test),fixed=TRUE)]
X_train = X_train[,grepl("mean()",colnames(X_train),fixed=TRUE)|grepl("std()",colnames(X_train),fixed=TRUE)]

#merging the test and train sets, then adding a row containing the average of all the features
X_union = merge(X_test,X_train,all = TRUE)
temprow <- matrix(c(rep.int(NA,length(data))),nrow=1,ncol=length(X_union))
newrow <- data.frame(temprow)
for (i in 1:length(X_union))
    newrow[i] = mean(X_union[,i])
colnames(newrow) <- colnames(X_union)
X_union <- rbind(X_union,newrow)

#writing the merged data to a new file
write.table(X_union,"X_union.txt",row.names=FALSE)

