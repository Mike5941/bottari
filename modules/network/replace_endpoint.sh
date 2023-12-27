#!/bin/bash

# 파일 이름과 새로운 엔드포인트 주소를 인자로 받습니다.
FILE=$1
NEW_ENDPOINT=$2

# .ovpn 파일에서 특정 줄을 찾아 교체합니다.
sudo sed -i "s/remote .* 443/${NEW_ENDPOINT}/" $FILE
