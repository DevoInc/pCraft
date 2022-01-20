import os
import boto3

def push_to_s3(bucket_name, filenames):
    s3_client = boto3.client(
        's3',
        aws_access_key_id=os.getenv('AWS_ACCESS_KEY_ID'),
        aws_secret_access_key=os.getenv('AWS_SECRET_ACCESS_KEY')
    )

    for filename in filenames:
        ans = s3_client.upload_file(filename, bucket_name, filename)
    
