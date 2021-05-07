
3주차 목차
- [Operators란?](#operators란)
  - [just](#just)
  - [from](#from)
  - [map](#map)
  - [filter](#filter)

# 🛠Operators란?
- 쉽게 Observable을 생성하고 변형하고 합치는 등 다양하게 연산을 할 수 있도록 도와주는 역할을 합니다.
- 엄청나게 많은 [Operators](http://reactivex.io/documentation/ko/operators.html)가 존재... 다 알 수 없으니 제일 많이 사용되는 4가지만 우선적으로 알아봐요!! ><

## just
- 하나의 element를 observable로 만드는 역할
```swift
func exJust1() {
        Observable.just("Hello World")
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
```

출력결과는 ?
```swift
Hello World
```

## from
- array, dictionary, set 등의 배열 형태를 observable sequence로 만드는 역할
```swift
func exFrom1() {
        Observable.from(["RxSwift", "In", "4", "Hours"])
            .subscribe(onNext: { str in
                print(str)
            })
            .disposed(by: disposeBag)
    }
```

출력결과는 ?
```swift
RxSwift
In
4
Hours
```

## map
- 위에서 내려온 데이터를 가공하는 역할
```swift
func exMap1() {
    print("\nexMap1()")
    Observable.just("Hello")
        .map { str in "\(str) RxSwift" }
        .subscribe(onNext: { str in
            print(str)
        })
        .disposed(by: disposeBag)
}
```
출력결과는 ? 
```swift
exMap1()
Hello RxSwift
```

```swift
func exMap2() {
    print("\nexMap2()")
    Observable.from(["with", "곰튀김"])
        .map { $0.count }
        .subscribe(onNext: { str in
            print(str)
        })
        .disposed(by: disposeBag)
}
```
출력결과는 ? 
```swift
exMap2()
4
3
```

## filter
- 위에서 내려온 데이터를 선별하는 역할
```swift
func exFilter() {
    print("\nexFilter()")
    Observable.from([1, 2, 3, 4, 5, 6, 7, 8, 9, 10])
        .filter { $0 % 2 == 0 }
        .subscribe(onNext: { n in
            print(n)
        })
        .disposed(by: disposeBag)
}
```
출력결과는?
```swift
exFilter()
2
4
6
8
10
```
