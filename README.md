# 일공이 (102)
> 근처 지역의 명소를 찾아 이를 방문하여 스탬프를 모으는 서비스

## 개요
### 호환성
iOS 15.0 +

### 📚 기술 스택
- UIKit / UICollectionViewLayout / NSLayoutAnchor / UISheetPresentationController / NSDiffableDataSource / NSDiffableSnapshot / NSNotification / CIFilter
- MapKit / MKAnnotation / CLLocation / GeoJSON / KVO / Kingfisher
- MVC / Git Flow

### 📅 프로젝트 기간
> 2023.10. ~ 2023. 11. (4주)

### 추후 업데이트 예정
- 위젯

## 화면 및 기능
### 📱 구현 화면

| 지도 화면 (축소) | 지도 화면 (확대) | 지도 화면(미방문/방문) |
|:-:|:-:|:-:|
| <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/8154d0d1-f5bc-407c-b719-fb44bf400c0b" alt="지도 화면 (축소)" width=200> | <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/ef6958f4-a810-4d26-ab19-a60261e3d7ad" alt="지도 화면 (확대)" width=200> | <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/31ecb842-4388-47ed-ab83-7b6aecd77ecf" alt="지도 방문/미방문 화면" width=200> |

| 도착 화면 | 지도 화면 (도착 후) |
|:-:|:-:|
| <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/07578c08-0984-4a0c-bb7a-39638304dec6" alt="지도 도착 화면" width=200> | <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/e3c483d4-e9a7-4bf8-b386-23b35d6d3bfb" alt="도착 화면" width=200> |

| 스탬프 목록 화면 | 스탬프 상세 화면 |
|:-:|:-:|
| <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/497afe1e-a2ea-4c51-a99d-46baa96b3731" alt="스탬프 목록 화면" width=200> | <img src="https://github.com/andy-archive/PassportTrails/assets/102043891/a4ce7c16-24e5-437c-a9a4-b5c2bb78615b" alt="스탬프 상세 화면" width=200> |

### 핵심 기능
- 지도 상 장소 조회 (방문/미방문)
- 사용자의 위치 권한 요청 및 조회
- 현재 위치와 목적지까지의 거리 & 방향 조회
- 스탬프 목록 및 상세 조회

## 트러블 슈팅
### [사용자와 목적지까지의 거리에 따른 반응형 화면 (present/dismiss)](https://github.com/andy-archive/PassportTrails/pull/13)


| Issues/PR #Number | Detail |
|:-:|-|
| [Issues #12](https://github.com/andy-archive/PassportTrails/issues/12) | - 사용자와 가장 가까운 annotation 사이의 거리가 특정 거리 이하(10m 예상)일 경우 모달창 띄우기 |
| | - 모달창을 내려도 무한히 함수를 호출하여 모달창을 계속 띄우는 문제 발생 |
| [PR #13](https://github.com/andy-archive/PassportTrails/pull/13) | - 현재 위치와 가장 가까운 Annotation 사이의 distance를 측정 |
| | - distance가 특정 이하일 경우 모달창을 띄우기 |

## 회고
### 아쉬운 점
#### MVC의 문제점 발생
> 비즈니스 로직 분리의 필요성 BUT 실행에 옮기지 못함
- 로직이 증가하며 점차 비대해지는 VC (View Controller)를 보면서 로직의 분리성을 느꼈습니다.
- 하지만 제한된 프로젝트 시간 내에 MVVM 패턴을 도입하기에는 기능 구현에도 차질이 생길 가능성이 매우 커서 시도하지 못했습니다.