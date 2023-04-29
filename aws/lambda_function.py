import json
import boto3
import base64
import botocore
import requests

BUCKET_NAME = 'megamenubucket' # 버킷 이름
FILE_NAME = 'menu.png' # 불러올 파일 이름
KEY = FILE_NAME

# s3 client 객체 생성
s3 = boto3.client('s3')

def lambda_handler(event, context):
    data = s3.get_object(Bucket = BUCKET_NAME, Key = KEY)
    
    # 이미지가 일반적인 바이트 형태이므로, data를 base64로 인코딩하여 문자열로 얻기
    res = data['Body'].read()
    res = base64.b64encode(res)
    
    ### 여기서부터는 Naver OCR
    # 본인의 APIGW Invoke URL로 치환
    URL = "{}"
        
    # 본인의 Secret Key로 치환
    SECRETKEY = "{}"
    
    ### naver OCR 로 데이터 보내기
    headers = {
        "Content-Type": "application/json",
        "X-OCR-SECRET": SECRETKEY
    }
    
    data = {
        "version": "V1",
        "requestId": "sample_id", # 요청을 구분하기 위한 ID(사용자가 정의)
        "timestamp": 0, # 현재 시간값
        "images": [
            {
                "name": "sample_image",
                "format": "png",
                "data": res.decode('utf-8')
            }
        ]
    }
    
    # 데이터를 json 형태로, post 방식으로 요청
    data = json.dumps(data)
    response = requests.post(URL, data=data, headers=headers)
    
    # html 로 결과값을 받게 된다. (http gateway 방식일 경우 필수)
    return {
        'statusCode': 200,
        'body' : response.text
    }