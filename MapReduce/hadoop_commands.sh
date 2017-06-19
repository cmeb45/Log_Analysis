#!/bin/bash

# Setup HDFS directory

hadoop fs -mkdir nasa

hadoop fs -copyFromLocal nasa/input nasa/


# Problem 1

hs mapper_prob1.py reducer_prob1.py nasa/input/* nasa/output_prob1

hadoop fs -cat nasa/output_prob1/part-00000 > mapreduce_prob1_output.txt


# Problem 2

hs mapper_prob2.py reducer_prob2.py nasa/input/* nasa/output_prob2

hadoop fs -cat nasa/output_prob2/part-00000 > mapreduce_prob2_output.txt
