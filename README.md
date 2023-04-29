# 메가스터디 구내식당 식단표 어플리케이션

남부터미널 가성비 맛집 서초 메가스터디 구내식당의 식단표를 간편하게 확인할 수 있는 어플리케이션입니다.


## 🎯 개발 목적

"의미있고 가치있는"

내가 만든 서비스 혹은 작업들이 의미있고 가치있는 결과로 이어진다는 것은 굉장히 보람있고 뿌듯한 일이라고 생각한다.

이번 개발을 통해서, 사용자가 원할 때 원클릭으로 볼 수 있는 어플로 만들면, 같이 교육받고 있는 분들과 직원분들께 작은 편리함이라도 제공해줄 수 있을 것이라 판단했고 의미있고 가치있는 개발이 될 수 있겠다는 생각을 했다.

더욱이, 내가 꼭 배우고 싶고 도전해보고 싶었던 AWS 서비스를 적용함으로서 학습까지 해볼 수 있겠다는 생각이 들어서 이번 프로젝트를 시작하게 되었다.


### - 개발 계기

- 사용 대상

    현재 듣고 있는 교육장 근처에 '메가스터디의 구내식당' 이 있어, 교육장 학생분들과 직원분들이 자주 점심 식사로 애용하는 곳이다.

    우리뿐만 아니라, 근처 직장인 분들도 많이 사용하는 듯하다.


- 기존 시스템 접근성 문제

    매번 점심 메뉴를 확인하기 위해서는 블로그에 들어가 해당 포스팅을 일일이 확인해주어야 한다.
 
    다들 메뉴 이미지도 저장하지 않는 것 같고, 그때 그때 블로그를 찾아 들어가거나, 슬랙에서 공유된 링크를 통해 들어가는 것 같다.


- 학습 목적(OCR, AWS)

    사실 정보를 제공하기만 하는 어플을 만드는 건, 아주 어렵지 않다.
    여기서, 교육 시간에 강사님께서 잠깐 언급해주신 OCR 을 알게 되었다.

    이를 적용해 내가 정보를 DB에 직접 적재하지 않아도, 이미지만 알아서 넣어주면 OCR 을 통해 텍스트를 인식하여 데이터를 App에 전달하면 어떨까? 라는 생각을 하게 되었다.

    그리고, 대학 생활에서 기획만 하고 적용해보지 못했던...! 정말 꼭 배우고 경험해보고 싶었던 AWS 서비스들을 활용해 의미있는 서비스를 만들어보고 싶었다.

    이번 기회에 좋은 기회가 될 것 같아, 적용해보기로 결정했다.


## 🌏 개발 환경


### 통합 개발 환경

[ 운영 체제 ]

Mac OS 13.1(22C65), Silicon Chip(M2)

[ 안드로이드 ]

Android Studio Electric Eel | 2022.1.1 Patch 2

Android Studio default JDK | ver 11.0.15

(SDK : minSdk = 24, targetSdk = 33)


### 사용 플랫폼

[ Naver Cloud Platform ]

- CLOVA OCR(Template)

- API Gateway
 
[ AWS ]

- AWS S3

- AWS Lambda

- AWS API Gateway

### 사용 언어 및 라이브러리

[ Python ] AWS Lambda 에서 사용(Python 3.8)

- import json

- import boto3

- import base64

- import botocore

- import requests
 

[ Java ] Android Studion 에서 사용

- import android.os.AsyncTask;

- import android.os.Bundle;

- import android.widget.TextView;

- import org.json.JSONArray;

- import org.json.JSONException;

- import org.json.JSONObject;

- import java.io.BufferedReader;

- import java.io.IOException;

- import java.io.InputStream;

- import java.io.InputStreamReader;

- import java.net.HttpURLConnection;

- import java.net.URL;


## 💻 개발 과정

### 시스템 아키텍처 다이어그램

![image](https://user-images.githubusercontent.com/55132964/235295371-cda71a1a-e481-4063-853a-397be30849a0.png)

1. AWS S3 에 주간 식단표 이미지를 올린다.

2. S3 와 연결된 AWS Lambda 를 통해, 이미지를 불러온다.

3. 해당 이미지를 Lambda 를 통해 Naver OCR API 에 전달한다.

4. OCR 을 통해 나온 텍스트 추출 결과를 전달받는다.

5. 전달받은 텍스트 결과를 AWS API Gateway(Http 방식)으로 전달한다.

6. 해당 html 페이지를 안드로이드 스튜디오에 전달한다.

7. 전달받은 내용을 앱 화면에 띄운다.


### 개발 방법(코드, 모듈 구조)

코드는 해당 레포에 있기 때문에 생략합니다.

전체적인 개발 방법과 세팅까지 확인하고 싶다면, 아래의 블로그를 참고하시면 됩니다.

https://summing.tistory.com/70



## ⚠️ 개선 사항

- Lambda 함수에서의 OCR 호출 개선

- 현실적인 서비스 배포 가능성