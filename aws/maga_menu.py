import json
import boto3

dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('mega_menu')
# ****** 매주 아래 partition_key 수정해주기 ******
partition_key = "2023.5.1 - 5.5"

def lambda_handler(event, context):
    
    response = table.query(
        KeyConditionExpression='Period = :Period',
        ExpressionAttributeValues={
            ':Period': partition_key
        }
    )
    
    items = response['Items']
    
    return {
        'statusCode': 200,
        'headers': {
            'Content-Type': 'application/json;charset=utf-8'
        },
        'body': json.dumps(items, ensure_ascii=False)
    }
