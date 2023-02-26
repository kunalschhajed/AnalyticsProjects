import sys
from awsglue.transforms import *
from awsglue.utils import getResolvedOptions
from pyspark.context import SparkContext
from awsglue.context import GlueContext
from awsglue.job import Job

args = getResolvedOptions(sys.argv, ["JOB_NAME"])
sc = SparkContext()
glueContext = GlueContext(sc)
spark = glueContext.spark_session
job = Job(glueContext)
job.init(args["JOB_NAME"], args)

# Script generated for node S3 bucket
S3bucket_node1 = glueContext.create_dynamic_frame.from_catalog(
    database="retailstoredb",
    table_name="dmefextractcontacts_csv",
    transformation_ctx="S3bucket_node1",
)

# Script generated for node Amazon S3
AmazonS3_node1677395485446 = glueContext.create_dynamic_frame.from_catalog(
    database="retailstoredb",
    table_name="dmefextractlines_csv",
    transformation_ctx="AmazonS3_node1677395485446",
)

# Script generated for node Amazon S3
AmazonS3_node1677395690720 = glueContext.create_dynamic_frame.from_catalog(
    database="retailstoredb",
    table_name="dmefextractorders_csv",
    transformation_ctx="AmazonS3_node1677395690720",
)

# Script generated for node Amazon S3
AmazonS3_node1677395696581 = glueContext.create_dynamic_frame.from_catalog(
    database="retailstoredb",
    table_name="dmefextractsummary_csv",
    transformation_ctx="AmazonS3_node1677395696581",
)

# Script generated for node ApplyMapping
ApplyMapping_node2 = ApplyMapping.apply(
    frame=S3bucket_node1,
    mappings=[
        ("cust_id", "long", "cust_id", "long"),
        ("contactdate", "long", "contactdate", "long"),
        ("contacttype", "string", "contacttype", "string"),
    ],
    transformation_ctx="ApplyMapping_node2",
)

# Script generated for node Change Schema (Apply Mapping)
ChangeSchemaApplyMapping_node1677395520999 = ApplyMapping.apply(
    frame=AmazonS3_node1677395485446,
    mappings=[
        ("cust_id", "long", "cust_id", "long"),
        ("ordernum", "long", "ordernum", "long"),
        ("orderdate", "long", "orderdate", "long"),
        ("linedollars", "double", "linedollars", "double"),
        ("gift", "string", "gift", "string"),
        ("recipnum", "long", "recipnum", "long"),
    ],
    transformation_ctx="ChangeSchemaApplyMapping_node1677395520999",
)

# Script generated for node Change Schema (Apply Mapping)
ChangeSchemaApplyMapping_node1677395702413 = ApplyMapping.apply(
    frame=AmazonS3_node1677395690720,
    mappings=[
        ("cust_id", "long", "cust_id", "long"),
        ("ordernum", "long", "ordernum", "long"),
        ("orderdate", "long", "orderdate", "long"),
        ("ordermethod", "string", "ordermethod", "string"),
        ("paymenttype", "string", "paymenttype", "string"),
    ],
    transformation_ctx="ChangeSchemaApplyMapping_node1677395702413",
)

# Script generated for node Change Schema (Apply Mapping)
ChangeSchemaApplyMapping_node1677395720147 = ApplyMapping.apply(
    frame=AmazonS3_node1677395696581,
    mappings=[
        ("cust_id", "long", "cust_id", "long"),
        ("scf_code", "long", "scf_code", "long"),
        ("retf07dollars", "long", "retf07dollars", "long"),
        ("retf07trips", "long", "retf07trips", "long"),
        ("retf07lines", "long", "retf07lines", "long"),
        ("rets07dollars", "long", "rets07dollars", "long"),
        ("rets07trips", "long", "rets07trips", "long"),
        ("rets07lines", "long", "rets07lines", "long"),
        ("retf06dollars", "long", "retf06dollars", "long"),
        ("retf06trips", "long", "retf06trips", "long"),
        ("retf06lines", "long", "retf06lines", "long"),
        ("rets06dollars", "long", "rets06dollars", "long"),
        ("rets06trips", "long", "rets06trips", "long"),
        ("rets06lines", "long", "rets06lines", "long"),
        ("retf05dollars", "long", "retf05dollars", "long"),
        ("retf05trips", "long", "retf05trips", "long"),
        ("retf05lines", "long", "retf05lines", "long"),
        ("rets05dollars", "long", "rets05dollars", "long"),
        ("rets05trips", "long", "rets05trips", "long"),
        ("rets05lines", "long", "rets05lines", "long"),
        ("retf04dollars", "long", "retf04dollars", "long"),
        ("retf04trips", "long", "retf04trips", "long"),
        ("retf04lines", "long", "retf04lines", "long"),
        ("rets04dollars", "long", "rets04dollars", "long"),
        ("rets04trips", "long", "rets04trips", "long"),
        ("rets04lines", "long", "rets04lines", "long"),
        ("retpre04dollars", "long", "retpre04dollars", "long"),
        ("retpre04trips", "long", "retpre04trips", "long"),
        ("retpre04lines", "long", "retpre04lines", "long"),
        ("retpre04recency", "long", "retpre04recency", "long"),
        ("intf07gdollars", "long", "intf07gdollars", "long"),
        ("intf07ngdollars", "long", "intf07ngdollars", "long"),
        ("intf07orders", "long", "intf07orders", "long"),
        ("intf07lines", "long", "intf07lines", "long"),
        ("ints07gdollars", "long", "ints07gdollars", "long"),
        ("ints07ngdollars", "long", "ints07ngdollars", "long"),
        ("ints07orders", "long", "ints07orders", "long"),
        ("ints07lines", "long", "ints07lines", "long"),
        ("intf06gdollars", "long", "intf06gdollars", "long"),
        ("intf06ngdollars", "long", "intf06ngdollars", "long"),
        ("intf06orders", "long", "intf06orders", "long"),
        ("intf06lines", "long", "intf06lines", "long"),
        ("ints06gdollars", "long", "ints06gdollars", "long"),
        ("ints06ngdollars", "long", "ints06ngdollars", "long"),
        ("ints06orders", "long", "ints06orders", "long"),
        ("ints06lines", "long", "ints06lines", "long"),
        ("intf05gdollars", "long", "intf05gdollars", "long"),
        ("intf05ngdollars", "long", "intf05ngdollars", "long"),
        ("intf05orders", "long", "intf05orders", "long"),
        ("intf05lines", "long", "intf05lines", "long"),
        ("ints05gdollars", "long", "ints05gdollars", "long"),
        ("ints05ngdollars", "long", "ints05ngdollars", "long"),
        ("ints05orders", "long", "ints05orders", "long"),
        ("ints05lines", "long", "ints05lines", "long"),
        ("intf04gdollars", "long", "intf04gdollars", "long"),
        ("intf04ngdollars", "long", "intf04ngdollars", "long"),
        ("intf04orders", "long", "intf04orders", "long"),
        ("intf04lines", "long", "intf04lines", "long"),
        ("ints04gdollars", "long", "ints04gdollars", "long"),
        ("ints04ngdollars", "long", "ints04ngdollars", "long"),
        ("ints04orders", "long", "ints04orders", "long"),
        ("ints04lines", "long", "ints04lines", "long"),
        ("intpre04gdollars", "long", "intpre04gdollars", "long"),
        ("intpre04ngdollars", "long", "intpre04ngdollars", "long"),
        ("intpre04orders", "long", "intpre04orders", "long"),
        ("intpre04lines", "long", "intpre04lines", "long"),
        ("intpre04recency", "long", "intpre04recency", "long"),
        ("catf07gdollars", "long", "catf07gdollars", "long"),
        ("catf07ngdollars", "long", "catf07ngdollars", "long"),
        ("catf07orders", "long", "catf07orders", "long"),
        ("catf07lines", "long", "catf07lines", "long"),
        ("cats07gdollars", "long", "cats07gdollars", "long"),
        ("cats07ngdollars", "long", "cats07ngdollars", "long"),
        ("cats07orders", "long", "cats07orders", "long"),
        ("cats07lines", "long", "cats07lines", "long"),
        ("catf06gdollars", "long", "catf06gdollars", "long"),
        ("catf06ngdollars", "long", "catf06ngdollars", "long"),
        ("catf06orders", "long", "catf06orders", "long"),
        ("catf06lines", "long", "catf06lines", "long"),
        ("cats06gdollars", "long", "cats06gdollars", "long"),
        ("cats06ngdollars", "long", "cats06ngdollars", "long"),
        ("cats06orders", "long", "cats06orders", "long"),
        ("cats06lines", "long", "cats06lines", "long"),
        ("catf05gdollars", "long", "catf05gdollars", "long"),
        ("catf05ngdollars", "long", "catf05ngdollars", "long"),
        ("catf05orders", "long", "catf05orders", "long"),
        ("catf05lines", "long", "catf05lines", "long"),
        ("cats05gdollars", "long", "cats05gdollars", "long"),
        ("cats05ngdollars", "long", "cats05ngdollars", "long"),
        ("cats05orders", "long", "cats05orders", "long"),
        ("cats05lines", "long", "cats05lines", "long"),
        ("catf04gdollars", "long", "catf04gdollars", "long"),
        ("catf04ngdollars", "long", "catf04ngdollars", "long"),
        ("catf04orders", "long", "catf04orders", "long"),
        ("catf04lines", "long", "catf04lines", "long"),
        ("cats04gdollars", "long", "cats04gdollars", "long"),
        ("cats04ngdollars", "long", "cats04ngdollars", "long"),
        ("cats04orders", "long", "cats04orders", "long"),
        ("cats04lines", "long", "cats04lines", "long"),
        ("catpre04gdollars", "long", "catpre04gdollars", "long"),
        ("catpre04ngdollars", "long", "catpre04ngdollars", "long"),
        ("catpre04orders", "long", "catpre04orders", "long"),
        ("catpre04lines", "long", "catpre04lines", "long"),
        ("catpre04recency", "long", "catpre04recency", "long"),
        ("emailsf07", "long", "emailsf07", "long"),
        ("emailss07", "long", "emailss07", "long"),
        ("emailsf06", "long", "emailsf06", "long"),
        ("emailss06", "long", "emailss06", "long"),
        ("emailsf05", "long", "emailsf05", "long"),
        ("emailss05", "long", "emailss05", "long"),
        ("catcircf07", "long", "catcircf07", "long"),
        ("catcircs07", "long", "catcircs07", "long"),
        ("catcircf06", "long", "catcircf06", "long"),
        ("catcircs06", "long", "catcircs06", "long"),
        ("catcircf05", "long", "catcircf05", "long"),
        ("catcircs05", "long", "catcircs05", "long"),
        ("giftrecf07", "long", "giftrecf07", "long"),
        ("giftrecs07", "long", "giftrecs07", "long"),
        ("giftrecf06", "long", "giftrecf06", "long"),
        ("giftrecs06", "long", "giftrecs06", "long"),
        ("giftrecf05", "long", "giftrecf05", "long"),
        ("giftrecs05", "long", "giftrecs05", "long"),
        ("giftrecf04", "long", "giftrecf04", "long"),
        ("giftrecs04", "long", "giftrecs04", "long"),
        ("giftrecpre04", "long", "giftrecpre04", "long"),
        ("newgrf07", "long", "newgrf07", "long"),
        ("newgrs07", "long", "newgrs07", "long"),
        ("newgrf06", "long", "newgrf06", "long"),
        ("newgrs06", "long", "newgrs06", "long"),
        ("newgrf05", "long", "newgrf05", "long"),
        ("newgrs05", "long", "newgrs05", "long"),
        ("newgrf04", "long", "newgrf04", "long"),
        ("newgrs04", "long", "newgrs04", "long"),
        ("newgrpre04", "long", "newgrpre04", "long"),
        ("firstyymm", "long", "firstyymm", "long"),
        ("firstchannel", "string", "firstchannel", "string"),
        ("firstdollar", "long", "firstdollar", "long"),
        ("storedist", "double", "storedist", "double"),
        ("acqdate", "long", "acqdate", "long"),
        ("email", "string", "email", "string"),
        ("occupcd", "long", "occupcd", "long"),
        ("travel", "string", "travel", "string"),
        ("curraff", "string", "curraff", "string"),
        ("currev", "string", "currev", "string"),
        ("wines", "string", "wines", "string"),
        ("finearts", "string", "finearts", "string"),
        ("exercise", "string", "exercise", "string"),
        ("selfhelp", "string", "selfhelp", "string"),
        ("collect", "string", "collect", "string"),
        ("needle", "string", "needle", "string"),
        ("sewing", "string", "sewing", "string"),
        ("dogowner", "string", "dogowner", "string"),
        ("carowner", "string", "carowner", "string"),
        ("cooking", "string", "cooking", "string"),
        ("pets", "string", "pets", "string"),
        ("fashion", "string", "fashion", "string"),
        ("camping", "string", "camping", "string"),
        ("hunting", "string", "hunting", "string"),
        ("boating", "string", "boating", "string"),
        ("agecode", "long", "agecode", "long"),
        ("inccode", "long", "inccode", "long"),
        ("homecode", "long", "homecode", "long"),
        ("child0_2", "string", "child0_2", "string"),
        ("child3_5", "string", "child3_5", "string"),
        ("child6_11", "string", "child6_11", "string"),
        ("child12_16", "string", "child12_16", "string"),
        ("child17_18", "string", "child17_18", "string"),
        ("dwelling", "long", "dwelling", "long"),
        ("lengthres", "long", "lengthres", "long"),
        ("homevalue", "long", "homevalue", "long"),
    ],
    transformation_ctx="ChangeSchemaApplyMapping_node1677395720147",
)

# Script generated for node S3 bucket
S3bucket_node3 = glueContext.write_dynamic_frame.from_options(
    frame=ApplyMapping_node2,
    connection_type="s3",
    format="csv",
    connection_options={"path": "s3://outputretailstore", "partitionKeys": []},
    transformation_ctx="S3bucket_node3",
)

# Script generated for node Amazon S3
AmazonS3_node1677395596554 = glueContext.write_dynamic_frame.from_options(
    frame=ChangeSchemaApplyMapping_node1677395520999,
    connection_type="s3",
    format="csv",
    connection_options={"path": "s3://outputretailstore", "partitionKeys": []},
    transformation_ctx="AmazonS3_node1677395596554",
)

# Script generated for node Amazon S3
AmazonS3_node1677395707455 = glueContext.write_dynamic_frame.from_options(
    frame=ChangeSchemaApplyMapping_node1677395702413,
    connection_type="s3",
    format="csv",
    connection_options={"path": "s3://outputretailstore", "partitionKeys": []},
    transformation_ctx="AmazonS3_node1677395707455",
)

# Script generated for node Amazon S3
AmazonS3_node1677395723108 = glueContext.write_dynamic_frame.from_options(
    frame=ChangeSchemaApplyMapping_node1677395720147,
    connection_type="s3",
    format="csv",
    connection_options={"path": "s3://outputretailstore", "partitionKeys": []},
    transformation_ctx="AmazonS3_node1677395723108",
)

job.commit()
