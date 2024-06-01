import json
import boto3

def lambda_handler(event, context):
    
    client = boto3.client('sqs')
    response = client.list_queues()
    print(response)
    
    return {
        'statusCode': 200,
        'body': json.dumps('Hello from Lambda!')
    }
