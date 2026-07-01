# 소통웨어 산업자동화 / SotongAutomationPromo

산업자동화 모니터링 시스템 사업 총괄 홍보사이트입니다.

## 프로젝트 개요

| 항목 | 내용 |
|------|------|
| 프로젝트명 | 소통웨어 산업자동화 / SotongAutomationPromo |
| 영문명 | Sotong Automation Monitoring System |
| 목적 | 산업자동화 모니터링 시스템 사업 총괄 홍보사이트 |
| 기술 스택 | Flutter Web |
| 문의 이메일 | sotongware@naver.com |

## 주요 소개 영역

- 생산라인 모니터링
- 작업순서 관리
- 바코드 연동
- PLC 연동
- MES 연동
- 작업자 Tool 연동
- CSV / 그래프 데이터 관리
- 라인별 PC 상태 모니터링
- 검사 데이터 관리

## 문의

- 이메일: [sotongware@naver.com](mailto:sotongware@naver.com)

## 로컬 실행 방법

```powershell
flutter pub get
flutter run -d chrome
```

## GitHub Pages 빌드 방법

```powershell
flutter clean
flutter pub get
dart format .
flutter analyze
flutter build web --base-href /SotongAutomationPromo/
```

## docs 폴더 생성 방법

```powershell
Remove-Item -Recurse -Force docs -ErrorAction SilentlyContinue
New-Item -ItemType Directory -Path docs
Copy-Item -Path build/web/* -Destination docs -Recurse
New-Item -ItemType File -Path docs/.nojekyll -Force
```

`docs/.nojekyll` 파일을 반드시 유지하세요.

## GitHub Pages 설정

1. GitHub 저장소 **Settings** → **Pages**
2. **Source**: Deploy from a branch
3. **Branch**: `main`
4. **Folder**: `/docs`
5. **Save**

## 배포 후 예상 주소

https://jtjeon73-hue.github.io/SotongAutomationPromo/

## 배포 후 확인할 것

- [ ] 404 오류 여부
- [ ] CSS/폰트/이미지 적용 여부
- [ ] 모바일 반응형 여부
- [ ] 카카오톡 공유 미리보기
- [ ] 새로고침 정상 여부

## 프로젝트 구조

```
lib/
├── main.dart
├── app.dart
├── theme/promo_theme.dart
├── screens/home_screen.dart
├── models/
├── data/sample_automation_data.dart
└── widgets/
web/
├── index.html
└── assets/og-image.svg
docs/          # GitHub Pages 배포용 (빌드 후 생성)
```

## 라이선스

Public Promo Site — 홍보 목적의 공개 사이트입니다.
