<h1 align="center"> 🗺️ flutter_local_search_app 🔍 </h1> 

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
- 응답 데이터를 바탕으로 Location 모델 클래스 생성
- LocationRepository 클래스 생성 후 검색 메서드 구현
- flutter_riverpod으로 ViewModel 구성
- HomePage에서 ViewModel과 연결하여 검색 기능 실행
<br>

### 3. Firestore를 이용한 리뷰 저장 및 조회 기능
- 검색 결과 클릭 시 ReviewPage로 이동하여 해당 지역의 리뷰 확인 가능
- mapX, mapY 좌표 기준으로 리뷰 필터링
- 리뷰 작성 후 Firestore에 저장 및 실시간 반영
- Firebase 콘솔에서 프로젝트 생성 및 Firestore 활성화
<br>

## 🔥 Trouble Shooting
### 1. 📦 uuid 패키지 관련 Target of URI doesn't exist 오류
[문제상황]  
- 리뷰 ID를 생성하기 위해 import 'package:uuid/uuid.dart';를 했는데 오류 발생
<pre> <code> Target of URI doesn't exist: 'package:uuid/uuid.dart'. </code> </pre>

[원인분석]  
- pubspec.yaml에 uuid 패키지를 추가하지 않고 import만 해둔 상태  
- Flutter는 의존성 패키지가 명시되지 않으면 import 불가  

[해결방법]  
- pubspec.yaml에 다음을 추가
- 반드시 flutter pub get 실행하여 패키지 설치
<pre> <code>
  dependencies:
    uuid: ^4.0.0
</code> </pre>
<br>

### 2. 🌐 Naver API 호출 시 클라이언트 ID/Secret 누락 문제
[문제상황]  
- Dio를 통한 지역 검색 API 호출 시 응답이 오지 않거나 403 Forbidden 오류 발생

[원인분석]  
- X-Naver-Client-Id와 X-Naver-Client-Secret이 요청 헤더에 누락되었거나 잘못 입력됨
- dio 인스턴스를 매번 새로 만들면서 header 세팅이 누락됨

[해결방법]  
- LocationRepository에서 공통 Dio 인스턴스를 생성하고 interceptor 또는 BaseOptions로 헤더 세팅
<pre><code>
 final dio = Dio(BaseOptions(
  baseUrl: 'https://openapi.naver.com',
  headers: {
    'X-Naver-Client-Id': '내 ID',
    'X-Naver-Client-Secret': '내 Secret',
  },
));
</code></pre>
<br>

### 3. 🧵 StateNotifier에서 비동기 메서드 상태 동기화 문제
[문제상황]  
- addReview() 호출 후에도 리뷰가 바로 반영되지 않고 새로고침해야 보임

[원인분석]  
- addReview()에서 await 없이 Firestore에 저장하거나
- ViewModel 내에서 상태 업데이트 누락 (state = [...state, newReview] 등)

[해결방법]  
- 상태를 불변성 유지하며 새로 갱신
<pre><code>
  final newReview = await _repository.addReview(...);
  state = [...state, newReview];
</code></pre>
<br>

### 4. 🎯 Navigator를 통한 페이지 이동 시 데이터 누락
[문제상황]  
- ReviewPage로 이동 시 title이 null로 찍히거나 오류 발생

[원인분석]  
- ReviewPage의 생성자에 required인 title 값을 전달하지 않음

[해결방법]  
- Navigator.push() 시 모든 파라미터 전달 확인
<pre><code>
  Navigator.push(
  context,
  MaterialPageRoute(
    builder: (_) => ReviewPage(
      mapX: location.mapx,
      mapY: location.mapy,
      title: location.title,
    ),
  ),
);
</code></pre>
<br>

### 5. 🧩 하단 리뷰 입력창 위치 문제
[문제상황]  
- 키보드를 열면 입력창이 화면 바깥으로 밀리거나 너무 아래에 붙어 있음

[원인분석]  
- Scaffold 내에서 입력창이 SafeArea 없이 배치되었거나
- 키보드가 올라올 때 레이아웃이 밀림

[해결방법]  
- resizeToAvoidBottomInset: true 설정 유지
- 하단 입력창은 bottomNavigationBar에 배치하고 MediaQuery로 패딩 처리
<pre><code>
  bottomNavigationBar: Padding(
  padding: EdgeInsets.only(
    bottom: MediaQuery.of(context).viewInsets.bottom,
  ),
  child: YourInputWidget(),
)
</code></pre>
<br>
<br>
<br>
