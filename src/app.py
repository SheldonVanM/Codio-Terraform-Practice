import json


def lambda_handler(event, context):
    #res = Res.response()
    #return res
    return {
        'statusCode': 200,
        'body': json.dumps('Hello World')
    }