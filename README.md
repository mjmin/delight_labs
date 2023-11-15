# delight_labs

안녕하세요. 

iOS 개발자 지원자 김민지입니다. 

주어진 내용에 따라 페이먼트 앱을 만들었습니다.

감사합니다. ☺️


## 개발환경
- 개발도구 : XCode
- 사용언어 : Swift

## Workflow
- Day / Month 스위치 선택 시, 오른쪽 날짜 및 그래프가 변경됩니다.
- Transactions 에서 All/Expense/Income 선택 시, 해당 내역이 각 최대 20, 10, 10개씩 출력됩니다.


## Architecture
해당 프로젝트는 Model-View-ViewModel(MVVM) 아키텍처로 구성되었습니다.

### View
- View는 모두 UIKit 및 라이브러리 사용하여 CodeBase로 구성되어 있습니다.
- MainView는 하나의 CollectionView로 이루어져 있습니다.
  - CollectionView 구성
    ```
      ├─ CollectionHeaderView
      ├─ GraphTitleCell
      ├─ GraphCell
      ├─ TransactionTitleCell
      ├─ TransactionTableCell
      ├─ ..
    ```
  - 각각의 파트를 CollectionViewCell로 나누어 구성하였으며, Recent Transactions의 아이템들은 각각의 CollectionViewCell입니다.
  - GraphCell는 DGCharts를 사용하여 구성하였습니다.
  - 
### ViewModel
- TransactionListViewModel 은 Transaction의 list로 구성되어 있습니다.
  - 해당 ViewModel을 통해 TransactionType(All/Expense/Income) 에 대한 값에 접근할 수 있습니다.


## Labrary Dependencies
Swift Package Manager를 사용하여 관리하였습니다. 
- AutoLayout Libraries
  - [Then](https://github.com/devxoul/Then) 
  - [SnapKit](https://github.com/SnapKit/SnapKit)
- Graph Libirary
  - [DGCharts](https://github.com/danielgindi/Charts) 
 
