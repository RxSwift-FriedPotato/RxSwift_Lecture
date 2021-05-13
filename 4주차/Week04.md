4주차 목차

- [🧾Traits란?](#traits란)
    - [📌 Traits의 종류](#-traits의-종류)
- [🧾Single](#single)
    - [📌 Single 사용하기](#-single-사용하기)
- [🧾Completable란?](#completable)
    - [📌 Completable 사용하기](#-completable-사용하기)
- [🧾Maybe란?](#maybe)
    - [📌 Completable 사용하기](#-maybe-사용하기)

<br>

# 🧾Traits란?

RxSwift에서 [Traits](https://github.com/ReactiveX/RxSwift/blob/main/Documentation/Traits.md#rxswift-traits)를 통해 명확한 이벤트 발생규칙을 가진 Observable을 사용할 수 있도록 지원합니다.

Traits는 코드의 명확함과 직관성을 가지고자 할 때 선택적으로 사용하면 되고, 코드의 의도를 분명히 할 수 있다는 장점이 있습니다.

주로 UI에 특화된 Observable을 생성하는데 사용되며 Single, Completable, Maybe 세 가지 종류가 있습니다.

RxCocoa에는 또 다른 Traits들이 있는데(Driver, Signal, ControlProperty, ControlEvent), 우리는 우선 RxSwift의 Traits에 대해서 공부해봅시다!


### 📌 Traits의 종류

1. Single : 일련의 요소를 방출하는 대신 항상 단일 요소 또는 에러를 방출하도록 보장하는 시퀀스
  
2. Completable : 이벤트에 대해 완료 또는 에러를 방출하고, 요소는 아무것도 방출하지 않는 것을 보장하는 시퀀스

3. Maybe : Single과 Completable의 중간 특성을 가지는 시퀀스

<br>

# 🧾Single

Single은 Observable의 변형으로, 일련의 요소를 방출하는 대신 **항상 단일 요소** 또는 **오류를 방출**하도록 보장합니다.

- 정확히 하나의 요소 또는 error를 방출합니다.
- 부수작용을 공유하지 않습니다.

Single을 일반적으로 응답, 오류만 반환할수 있는 HTTP Request 응답을 처리하는데 사용되며, 단일요소를 사용하여 무한 스트림 요소가 아닌 단일 요소만 관리하는 경우를 모델하는데 사용할수 있습니다.

Observable을 처리하는 onNext, onError, onComplete 세 가지 처리가 필요 없으며, Success와 Failure만 처리하면 됩니다.

기본적으로 Single은 Observable이므로 기타 Observable 연산자들을 사용할 수 있습니다. (map, just 등등)

<br>

<img width="500" alt="single" src="https://user-images.githubusercontent.com/70695311/118115170-95804a80-b423-11eb-854e-f1105cfc2150.png">

<br>

### 📌 Single 사용하기

Single은 Observable을 생성하는 것과 매우 유사합니다.<br>**Single\<T>.create()**

```
func getRequest(url: String?) -> Single<Bool> {
    return Single<Bool>.create { single in
        guard let url = url else {
            single(.failure(NSError.init(domain: "error", code: -1, userInfo: nil)))
            return Disposables.create()
        }

        if url == "https://www.google.com" {
            single(.success(true))
        } else {
            single(.success(false))
        }

        return Disposables.create()
    }
}
```

위의 예시는 url이 nil이면 failure를, url이 google이면 ture, 아니면 false의 흐름을 방출하는 Single을 생성하는 예시입니다.

위에서 생성된 Single은 다음과 같이 구독하여 사용할 수 있습니다.

```
getRequest(url: "https://www.github.com")
    .subscribe(onSuccess: { success in
        print("url 판별: ", success)
    }, onFailure: { error in
        print("Error: ", error)
    })
    .dispose()
```

```
<출력결과>
url 판별: false
```

onSuccess : Single은 자신이 배출하는 하나의 값을 이 메서드를 통해 전달합니다.<br>
onFailure : Single은 항목을 배출할 수 없을 때 이 메서드를 통해 Throwable 객체를 전달합니다.

Single은 이 메서드들 중 하나만, 그리고 한 번만 호출하며, 메서드가 호출되면 Single의 생명주기가 끝나고 구독도 종료됩니다.

# 🧾Completable

- completed, error 두 가지 이벤트를 방출할 수 있다.
- 아무 element도 방출하지 않기에 단순 완료 여부만 알고 싶을때 써요.
- 언제써야할까? - 완료에 따른 요소에 신경쓰지 않는 경우에 유용
- Completable로 시퀀스 형 변환이 필요할 때는 .ignoreElements( )를 이용하자. 

<br>

<img width="500" alt="completable" src="https://user-images.githubusercontent.com/70695311/118115175-96b17780-b423-11eb-8573-b4163d65f6c0.png">

<br>

### 📌 Completable 사용하기

```swift
func completable() -> Completable {
    return Completable.create { completable in 
    // Store some data locally
    
        guard success else { 
            completable(.error(CacheError.failedCaching)) 
            return Disposables.create {} 
            } 
    
        completable(.completed)     
    
        return Disposables.create {} 
    } 
} 

completable().subscribe(
    onCompleted: { print("Completed with no error") 
    }, 
    
    onError: { error in print("Completed with an error: \(error.localizedDescription)") 
    } 
).disposed(by: disposeBag)

//사용법
getRepo("ReactiveX/RxSwift")
    .subscribe { event in
        switch event {
            case .success(let json):
                print("JSON: ", json)
            case .error(let error):
                print("Error: ", error)
        }
    }
    .disposed(by: disposeBag)
```

# 🧾Maybe

- success(value), completed, error 3가지 이벤트를 방출할 수 있다. 
- Signle, Completable 사이에 있는 Observable의 변형
        - element를 방출 할 수 있다. -> Single의 특징
        - element를 방출하지 않고 완료(성공)할 수 있다. -> Completable의 특징 
- 0 또는 1개의 element를 포함하는 Observable sequence
- single과 달리 방출없이 완료가 가능하다. 

<br>

<img width="500" alt="maybe" src="https://user-images.githubusercontent.com/70695311/118115177-974a0e00-b423-11eb-8fdd-2240121a4d7f.png">

<br>
### 📌 Maybe 사용하기

```swift
func maybe() -> Maybe<String> {
    return Maybe<String>.create { maybe in 
        maybe(.success("RxSwift")) 
        // or
        maybe(.completed) 
        // or 
        maybe(.error(error)) 
        
        return Disposables.create {} 
        } 
} 

maybe().subscribe( 
    onSuccess: { 
        element in print("Completed with element \(element)") 
    }, 
    onError: { error in print("Completed with an error \(error.localizedDescription)") 
    }, 
    onCompleted: { print("Completed with no element") 
} ).disposed(by: disposeBag
```
