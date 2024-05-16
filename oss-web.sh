#!/bin/bash

# 현재 시간 가져오기 (YYYY-MM-DD-HH-MM 형식)
current_time=$(date +"%Y-%m-%d-%H-%M")

# Docker 이미지 태그 생성
image_tag="react-app-$current_time-container"

# Docker 이미지 빌드
docker build -t $image_tag .

# 결과 출력
if [ $? -ne 0 ]; then
  echo "Docker build failed. Exiting."
  exit 1
fi

echo "Docker image built with tag: $image_tag"

# 실행 중인 이전 컨테이너 중지 및 제거
docker stop react-app-container 2>/dev/null
docker rm react-app-container 2>/dev/null

# Docker 컨테이너 실행
docker run -d -p 3000:3000 --name react-app-container $image_tag

# 결과 출력
if [ $? -ne 0 ]; then
  echo "Docker run failed. Exiting."
  exit 1
fi

echo "Docker container running with name: react-app-container"
