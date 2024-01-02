-- Load data from the file
inputFile = LOAD 'hdfs:///user/sonam/input.txt' AS (line:chararray);
-- Tokeize each word in the file (Map)
words = FOREACH inputFile GENERATE FLATTEN(TOKENIZE(line)) AS word;
-- Combine the words from the above stage (Map)
grpd = GROUP words BY word;
-- Count the occurence of each word [Reduce]
totalCount = FOREACH grpd GENERATE $0, COUNT($1);

-- Delete the output folder
rmf hdfs:///user/sonam/PigOutput;
-- Store the result in HDFS
STORE totalCount INTO 'hdfs:///user/sonam/PigOutput';
