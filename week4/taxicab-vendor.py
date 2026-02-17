# PySpark program to print count of rides for VendorID 1 and VendorID 2 using taxicab data
# run with spark-submit --master local[4] week4/taxicab-vendor.py

from pyspark.sql import SparkSession
from pyspark.sql.functions import col

# Create a SparkSession
spark = SparkSession \
          .builder \
          .appName("TaxiRidesCount") \
          .getOrCreate()
sc = spark.sparkContext

# Load the taxi data from a parquet file
input_file = "file:///workspaces/CSCIE192-2026-Spring/data/yellow_tripdata_2025-01_sample.parquet"
taxi_data = spark.read.parquet(input_file)

# Filter the data for VendorID 1 and VendorID 2 and count the rides
vendor1_count = taxi_data.filter(col("VendorID") == 1).count()
vendor2_count = taxi_data.filter(col("VendorID") == 2).count()

# Print the counts
print(f"*** Count of rides for VendorID 1: {vendor1_count}")
print(f"*** Count of rides for VendorID 2: {vendor2_count}")

# Stop the SparkSession
spark.stop()


