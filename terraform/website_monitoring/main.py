import subprocess
import urllib3
import boto3
import os

TOPIC_ENV = "TOPIC"
WEBSITE_ENV = "URI"
MESSAGE = 'Website is down, please run ansible to configure.'

def lambda_handler(event, context):
    http = urllib3.PoolManager()
    wedding_response = http.request("GET", f"https://{os.getenv(WEBSITE_ENV)}")
    wedding_response_status = wedding_response.status
    if wedding_response_status != 200:
        sns_client = boto3.client('sns')
        result = sns_client.publish(TopicArn=os.getenv(TOPIC_ENV),
                Message=MESSAGE,
                Subject="Website is Down")
    return {
        'statusCode' : 200,
        'body': 'no'
    }
