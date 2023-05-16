import json
import boto3
import base64
import botocore
import requests
import re

BUCKET_NAME = '버킷이름'

# ****** 매주 아래 파일 이름 수정해주기 ******
FILE_NAME = '파일명'
KEY = FILE_NAME

s3 = boto3.client('s3')
dynamodb = boto3.resource('dynamodb')
table = dynamodb.Table('테이블명')

# ***날짜 정규식 추가***
pattern = r'(\d+/\d+)\s*([월화수목금토일])(?!\S)'


def lambda_handler(event, context):
    data = s3.get_object(Bucket = BUCKET_NAME, Key = KEY)
    res = data['Body'].read() 
    # print(res) # 일반적인 바이트 형태, 따라서, data를 base64로 바꿔야함
    # base64로 인코딩하여 문자열로 얻기
    res = base64.b64encode(res)
    
    # 본인의 APIGW Invoke URL로 치환
    URL = ""
        
    # 본인의 Secret Key로 치환
    SECRETKEY = ""
        
    headers = {
        "Content-Type": "application/json",
        "X-OCR-SECRET": SECRETKEY
    }
    
    data = {
        "version": "V1",
        "requestId": "sample_id", # 요청을 구분하기 위한 ID, 사용자가 정의
        "timestamp": 0, # 현재 시간값
        "images": [
            {
                "name": "sample_image",
                "format": "png",
                "data": res.decode('utf-8')
            }
        ]
    }
    
    data = json.dumps(data)
    
    response = requests.post(URL, data=data, headers=headers)
    
    if response.status_code == 200:
        res = json.loads(response.text)
        
        res_data = res['images'][0]['fields']
        # print(res_data)
        
        period = res_data[0]['inferText']
        print(period)
        
        idx = 0

        for item in res_data[1:]:
            #print(item)
            
            table.put_item(
                # 요일명, 메뉴내용
                Item={
                    'Period': period,
                    'Menu': re.sub(pattern, r'\1 \2', str(idx) + " " + item['inferText'])
                    
                }
            )
            print(f"Data inserted successfully: {item['inferText']}")
            
            idx += 1

    else:
        print(f"Failed to fetch data from API. Status code: {response.status_code}")