# 오누이 과제전형- Unsplash App

### 기술스택 
> 아키텍처 패턴: MVVM

> UI 레이아웃 구성 : 코드 - SnapKit

> 반응형 프로그래밍: RxSwift, RxCocoa

<br>

### 해결하지 못한 사항
> 페이징 처리와 무한 스크롤


<br>

### 고민 한 것
> 좋아요 여부 확인을 위해서 스크롤시 Reusable Cell이 로드될 때마다 매번 이를 위한 API 콜을 하는것이 적절한 방식인가

> RxSwift를 활용하여 MVVM 아키텍처를 어떻게 효율적으로 설계할 것인가

<br>

### 프로젝트 구조

```bash

├── API
│   └── UserService.swift
│
├── Controller
│   │
│   ├── ProfileViewController.swift
│   └── SearchViewController.swift
│
├── Extensions
│   │
│   ├── URL+Extensions.swift
│   └── URLRequest+Extensions.swift
│
├── Model
│   │ 
│   ├── DTO
│   │   ├── AuthorizationRequest.swift
│   │   └── AuthorizationResponse.swift
│   │
│   ├── Photo.swift
│   └── User.swift
│
├── View
│   ├── Items
│   │   │
│   │   └── WebImageView.swift
│   │
│   ├── Profile
│   │   │
│   │   ├── ProfileCell.swift
│   │   └── ProfileHeader.swift
│   │
│   └── Search
│       │
│       └── SearchCell.swift
│
├── ViewModel
│   │
│   ├── AuthManager.swift
│   │
│   ├── Profile
│   │   │
│   │   ├── ProfileCellViewModel.swift
│   │   └── ProfileViewModel.swift
│   │
│   └── Search
│       │
│       ├── SearchCellViewModel.swift
│       └── SearchViewModel.swift
│
├── ViewController.swift
├── SceneDelegate.swift
├── AppDelegate.swift
├── Info.plist
└── Base.lproj
    │
    └── LaunchScreen.storyboard
```