<h1 align="center"> 🔍 flutter_local_search_app </h1> 

<div align="center">
  <img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-04 at 23 42 27" src="https://github.com/user-attachments/assets/025262dc-c9ae-4726-a320-a968de1d2835" />
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-04 at 23 42 42" src="https://github.com/user-attachments/assets/b0f01cc5-5afb-4379-8b53-9568281c4294" />
<img width="300" height="600" alt="Simulator Screenshot - iPhone 16 Pro - 2025-08-04 at 23 43 39" src="https://github.com/user-attachments/assets/8769e962-c131-4164-b26c-da6e2e80a7ed" />
</div>
<br>

<h3 align="center"> [Flutter 숙련] 개인 과제 - 지역 검색 앱 </h3>
<p align="center"> 프로젝트 일정 [ 25/07/24 ~ 25/08/05 ] </p>
<br>
<br>
<br>

## 🗺️ 프로젝트 개요 – Flutter Local Search App 🔍

**💡 지역 기반 검색과 사용자 리뷰를 제공하는 위치 탐색 앱**

- 네이버 지역 검색 API를 통해 지역 정보를 검색
- Firebase Firestore를 이용하여 해당 지역에 대한 리뷰를 저장하고 불러오기
- Riverpod 상태관리로 깔끔하게 UI와 로직 분리
<br>

## 🎯 주요 목표

- **API 활용 능력 강화**
  - `dio` 패키지를 사용한 네이버 Open API 연동
  - 응답 JSON을 파싱하여 `Location` 모델 클래스로 구조화

- **상태 관리 학습**
  - `flutter_riverpod`를 활용한 ViewModel 구조
  - `StateNotifierProvider`를 통해 검색 결과 및 리뷰 상태 관리

- **Firebase 연동 실습**
  - `cloud_firestore`를 이용한 리뷰 저장 및 조회
  - 좌표 기반(mapX, mapY)으로 리뷰를 필터링하여 불러오기
<br>

## ✅ 완료한 필수 기능
### 1. HomePage
- AppBar의 title 속성에 TextField 위젯 배치
- onSubmitted 콜백을 통해 검색어 입력 시 지역 검색 수행
- 검색 결과는 ListView로 출력
- 각 아이템에는 title, category, roadAddress가 세로 정렬로 표시
- 검색 결과 아이템 클릭 시 ReviewPage로 이동
- Riverpod을 통해 상태관리 구현 완료
<br>

### 2. 네이버 검색 Open API 연동
- 네이버 검색 API 키 발급 후 요청 테스트 완료
- dio 패키지를 사용해 비동기 HTTP GET 요청 구현  

📎 관련 문서 및 요청 정보
- 문서: Naver Local Search API
- 요청 URL 예시:  
https://openapi.naver.com/v1/search/local.json?query=검색할지역이름&display=5
- 요청 헤더:  
X-Naver-Client-Id: 발급받은 Client ID
X-Naver-Client-Secret: 발급받은 Client Secret
<br>

📌 구현 흐름
- 응답 데이터를 바탕으로 Location 모델 클래스 생성
- LocationRepository 클래스 생성 후 검색 메서드 구현
- flutter_riverpod으로 ViewModel 구성
- HomePage에서 ViewModel과 연결하여 검색 기능 실행
<br>

### 3. Firestore를 이용한 리뷰 저장 및 조회 기능
- 검색 결과 클릭 시 ReviewPage로 이동하여 해당 지역의 리뷰 확인 가능
- mapX, mapY 좌표 기준으로 리뷰 필터링
- 리뷰 작성 후 Firestore에 저장 및 실시간 반영
<br>

📌 Firebase 연동 흐름
- Firebase 콘솔에서 프로젝트 생성 및 Firestore 활성화
- flutterfire configure 명령어로 Flutter 프로젝트와 연동
- 필수 패키지 추가:
firebase_core: ^2.0.0  
cloud_firestore: ^4.0.0  
- main() 함수에서 Firebase 초기화:
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ProviderScope(child: MyApp()));
}
<br>
<br>
<br>

📌 리뷰 기능 구성
- Review 모델 클래스 생성:
class Review {
  final String id;
  final String content;
  final double mapX;
  final double mapY;
  final DateTime createdAt;
}
- ReviewRepository:
addReview(...): Firestore에 리뷰 저장
fetchReviews(mapX, mapY): 좌표 기반 리뷰 목록 불러오기  
- ReviewViewModel:
상태 기반으로 리뷰 리스트 관리 및 작성 기능 구현  
- ReviewPage:
ViewModel과 연결하여 리뷰 출력
텍스트 입력 및 리뷰 작성 UI 구현 완료
