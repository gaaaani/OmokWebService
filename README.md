# 🚀 5조은목
[신한SW아카데미 5기] <br>
오목 게임 만들기 <br>

| 5조은팀 | 이름 | GitHub 프로필 |
|:---:|:---:|:---:|
| <img src="https://github.com/minsss0726.png" width="40" />| **김민중(팀장)**  | [minsss0726](https://github.com/minsss0726) |
| <img src="https://github.com/parkeunhyo.png" width="40" /> |**박은효** | [parkeunhyo](https://github.com/parkeunhyo) |
| <img src="https://github.com/window101.png" width="40" /> |**박화준** | [window101](https://github.com/window101) |
| <img src="https://github.com/gaaaani.png" width="40" /> |**서가은** | [gaaaani](https://github.com/gaaaani) |
| <img src="https://github.com/22jml.png" width="40" /> |**이정민** | [22jml](https://github.com/22jml) |
---


## 📖 프로젝트 개요

> **5조은목** : Java Servlet/JSP와 WebSocket을 기반의 실시간 모바일 웹 서비스


- **실시간 대국**: WebSocket을 이용해 착수 버튼 클릭 즉시 반영  
- **회원 시스템**: 간단한 가입·로그인 절차 및 개인 관리  
- **게임 기록 조회**: 유저별 전적 및 랭킹 확인
- **모듈화된 아키텍처**: Controller → Service → DAO → DB 계층으로 분리 
<br>

## 🎯 주요 기능
🎮 실시간 대국: WebSocket으로 즉시 반영되는 착수 <br>
📝 회원 시스템: 가입·로그인, 닉네임·비밀번호 관리 <br>
⏱️ 타이머 기능: 턴별 제한 시간 설정 및 타임 오바 <br>
📊 전적 관리: 게임 기록 및 랭킹 확인 <br>
<br>

## 🖼️ 화면 구조

| 인트로 | 회원가입 | 방 목록 | 방 만들기 | 게임 |
|:---:|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/6e1b4ae3-f947-4dfd-9cc6-6519462703d6" alt="인트로" width="160" /> | <img src="https://github.com/user-attachments/assets/3eb22088-f5f8-43c6-b47e-0ae64c6ca932" alt="회원가입" width="160" /> | <img src="https://github.com/user-attachments/assets/14423937-728f-4a3a-a22a-a664e9366a20" alt="방 목록" width="160" /> | <img src="https://github.com/user-attachments/assets/13d1e06a-8cca-4626-8827-9ccfaf3d2591" alt="방 만들기" width="160" /> | <img src="https://github.com/user-attachments/assets/7e2b0fa3-2e4e-4314-90f2-57c56339e0e1" alt="게임" width="160" /> |

| Win 팝업 | Lose 팝업 | 랭킹 | 전적 조회 | 프로필 변경 |
|:---:|:---:|:---:|:---:|:---:|
| <img src="https://github.com/user-attachments/assets/3774e41e-c358-45fa-979a-36bfa0bebaac" alt="Win 팝업" width="160" /> | <img src="https://github.com/user-attachments/assets/f11bebc0-102f-4876-bc0c-d47069d5120d" alt="Lose 팝업" width="160" /> | <img src="https://github.com/user-attachments/assets/d282db8d-f4bf-4e8f-8cf7-e8317ad3f5af" alt="랭킹" width="160" /> | <img src="https://github.com/user-attachments/assets/d5059eb5-28f3-49da-92bb-917054af39cd" alt="전적 조회" width="160" /> | <img src="https://github.com/user-attachments/assets/5ed66137-219e-4c76-8d0f-c06a441aa0b2" alt="프로필 변경" width="160" /> |


| 화면            | 설명                                                    |
|:--------------:|:------------------------------------------------------|
| 🎬 인트로       | 서비스 진입 화면 & 로그인                                  |
| 🔑 회원가입     | 아이디·닉네임·비밀번호 입력 및 캐릭터/테마 선택           |
| 🏠 방 목록      | 생성된 방 리스트 확인, 방 상태 업데이트            |
| ➕ 방 만들기     | 방 이름·소개 입력 후 신규 방 생성                        |
| 🎮 게임         | 15×15 오목판, 턴 타이머, 착수 버튼                |
| 🏆 Win 팝업     | 승리 시 포인트 획득 알림                                 |
| 😞 Lose 팝업    | 패배 시 포인트 차감 알림                                 |
| 📈 랭킹         | 서버 전체 유저 랭킹 리스트                               |
| 📊 전적 조회    | 개인 전적(승/패/점수) 및 히스토리 리스트                 |
| 👤 프로필 변경  | 캐릭터 및 테마 변경                                      |


## 📊 ERD
  <img src="https://github.com/user-attachments/assets/43534a05-98c2-4f3b-9f4d-83adad9a5f2e" alt="ERD" width="800" style="margin:0 12px;" />
  <br>
  
## 🗂️ 폴더 구조
<img src="https://github.com/user-attachments/assets/b7df6dfb-c800-4b70-87be-b17960d5c1a3" alt="Folder" width="300" style="margin:0 12px;" />
<br>

## 🛠️ 기술 스택

<p align="center">
  <img src="https://img.shields.io/badge/Java-17-007396?logo=java&logoColor=white" alt="Java 17" />
  <img src="https://img.shields.io/badge/Servlet_API-4.0.1-6DB33F?logo=apachetomcat&logoColor=white" alt="Servlet API 4.0.1" />
  <img src="https://img.shields.io/badge/WebSocket-1.1-35495E?logo=websocket&logoColor=white" alt="WebSocket API 1.1" />
  <img src="https://img.shields.io/badge/Oracle_DB-–-F80000?logo=oracle&logoColor=white" alt="Oracle Database" />
  <img src="https://img.shields.io/badge/Maven-3.8.4-C71A36?logo=apachemaven&logoColor=white" alt="Maven" />
  <img src="https://img.shields.io/badge/Apache_Tomcat-9.x-F8DC75?logo=apachetomcat&logoColor=black" alt="Apache Tomcat" />
  <img src="https://img.shields.io/badge/Gson-2.8.9-4285F4?logo=google&logoColor=white" alt="Gson 2.8.9" />
</p>
<br>
