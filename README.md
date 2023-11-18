# 일공이 (102)
> 근처 지역의 명소를 찾아 이를 방문하여 스탬프를 모으는 서비스

## 개요
### 기술 스택
- UIKit / UICollectionViewLayout / NSLayoutAnchor / UISheetPresentationController / NSDiffableDataSource /
  NSDiffableSnapshot / NSNotification / CIFilter
- MapKit / MKAnnotation / CLLocation / GeoJSON / KVO / Kingfisher
- MVC / Git Flow

### 프로젝트 기간
> 2023.10. ~ 2023. 11. (4주)

## 기능
### 핵심 기능
- 지도 상의 방문/미방문 장소조회
- 사용자 위치 권한 요청 및 조회
- 목적지 실시간 거리 / 방향 조회
- 스탬프 목록 조회
- 스탬프 상세 조회

### 구현 기능
- Custom View 활용하여 재사용 가능한 UI 소스를 분류 및 관리
- Swift Protocol를 활용하여 Realm에 대한 Repository 패턴 도입
- Realm API를 활용하여 방문 지역 데이터 저장 및 미방문 지역에 대한 Custom Annotation 적용
- NSNotification를 활용하여 사용자와 목적지 거리의 조건에 따른 반응형 화면 분기 처리
- CLLocationButton을 활용하여 사용자 위치에 대한 "한 번만 허용"에 대한 편의성 개선
- 실제 앱 서비스 출시를 가정한 Git branch를 분리한 Git flow 적용 및 PR 진행
- Google Firebase를 이용한 앱에 대한 사용자의 앱 사용 정보 수집
