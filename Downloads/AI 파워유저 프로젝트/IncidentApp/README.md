# 장애 처리 MVP 앱

macOS용 장애 처리 관리 앱입니다. SwiftUI로 개발되었으며 장애 등록부터 처리 완료까지의 워크플로우를 관리합니다.

## 기능

- **Phase 1**: 장애 내용 입력 및 등록
- **Phase 2**: 담당자 장애 접수 확인
- **Phase 3**: 장애 처리 진행
- **Phase 4**: 처리 완료 및 새 장애 등록

## 요구사항

- macOS 12.0 (Monterey) 이상
- Swift 5.9 이상
- Xcode 15.0 이상 (개발 시)

## 빌드 및 실행

### 커맨드라인에서 빌드

```bash
# 프로젝트 디렉토리로 이동
cd IncidentApp

# 디버그 빌드
swift build

# 릴리즈 빌드
swift build -c release

# 앱 실행
swift run
```

### Xcode에서 빌드

1. Xcode에서 Package.swift 파일 열기
2. Product > Build (⌘B) 선택
3. Product > Run (⌘R) 선택

### 앱 번들 생성

```bash
# 릴리즈 빌드 및 앱 번들 생성
./build.sh
```

생성된 앱은 `build/IncidentApp.app` 경로에 저장됩니다.

## 사용 방법

1. 앱 실행 후 장애 내용을 입력합니다
2. "등록" 버튼을 클릭하여 장애를 등록합니다
3. "담당자 장애 접수 완료" 버튼을 클릭합니다
4. "장애 처리 완료" 버튼을 클릭합니다
5. 완료 화면에서 "새 장애 등록하기"를 클릭하여 새로운 장애를 등록할 수 있습니다

## API 정보

앱은 다음 API 엔드포인트를 사용합니다:
- URL: `https://gateway.ax.gsretail.com/ext/v1/workflows/run`
- 인증: Bearer 토큰 방식

## 에러 처리

- 네트워크 오류 시 알림 표시
- API 응답 오류 시 사용자에게 오류 메시지 표시
- 입력 유효성 검사 (빈 입력 방지)

## 개발 구조

```
IncidentApp/
├── Sources/
│   ├── IncidentApp.swift    # 앱 진입점
│   ├── Models/
│   │   └── AppState.swift   # 상태 관리
│   ├── Services/
│   │   └── ApiService.swift # API 통신
│   └── Views/
│       ├── ContentView.swift
│       ├── Phase1InputView.swift
│       ├── Phase2ReceptionView.swift
│       ├── Phase3ProcessingView.swift
│       └── Phase4CompletionView.swift
└── Package.swift
```