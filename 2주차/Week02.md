2주차 목차

- [🧾Subject란?](#subject란)
  - [Observable vs Observer](#observable-vs-observer)
  - [Subject_vs_Observable](#subject-vs-observable)
- [🧾PublishSubject](#publishsubject)
- [🧾BehaviorSubject](#behaviorsubject)
- [🧾ReplaySubject](#replaysubject)
- [🧾AsyncSubject](#asyncsubject)
- [🧾Relay란?](#relay)
    -  - [Relay vs Subject](#relay-vs-subject)

<br>

# 🧾Subject란?

- 개발을 할 때 실시간으로 Observable에 값을 추가하고 subscriber를 할 수 있는 무엇인가가 필요해요.
- 이 때 Observable, Observer의 역할을 모두 할 수 있어요.
- 다만 차이는 **multicast** 방식으로 여러개의 observer를 subscribe 할 수 있습니다. 
    - <-> Observable은 unicast 방식 (https://gist.github.com/sujinnaljin/dd5783fe5297cf0943d79a5076f98c02 참고)

<br>

## Observable vs Observer

- Observable은 관찰 가능한 상태를 유지하면 Event를 전달해요.
- 해당 Event를 Observer에게 전달하고 Observer에서 처리합니다.
- Subscribe : 구독하다 , Observer : 구독자
- observable는 이벤트를 방출하고, Observer는 이를 구독해서 이벤트를 처리하는 것이다.
- observable.subscribe를 하면 내부에서 생성되는 observer에 대한 subscription을 만든다. => self.asObservable().subscribe(observer) 

<br>

## Subject vs Observable

| Observable | Subject |
| ------ | ------ |
| 함수, state X | state O, data를 메모리에 저장 |
| 각각의 옵저버에 대해 코드가 실행| 같은 코드 실행, 모든 옵저버에 대해 오직 한번만 |
| Data Producer | Date Producer and Consumer |
| 용도 : 간단한 하나의 옵저버가 필요할 때 | 용도 : 데이터가 자주 바뀔때, 옵저버와 옵저버 사이의 Proxy 역할 |

추가적으로 Subject는 ObserverType를 따르고 있어 바로 on 함수를 구현 가능하다. 
Observable, Observer들 간의 interaction, 유연성있는 코드도 가능하겠네요.

<br>

# 🧾PublishSubject

<br>

- 구독한 뒤에  Observable이 보낸 이벤트를 전달받아요
- element 없이 빈 상태로 생성되고, subscribe한 시점 이후에 발생되는 이벤트만 전달받아요.

```swift
        let disposeBag = DisposeBag()
        let subject = PublishSubject<String>()
        
        subject.onNext("Hi")
        
        let o1 = subject.subscribe {print (">>1",$0)}
        o1.disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")

        let o2 = subject.subscribe{print(">>2",$0)}
        o2.disposed(by: disposeBag)
        
        subject.onNext("c")
        subject.onNext("d")
```

출력 결과는?
<pre>
>>1 next(a)
>>1 next(b)
>>1 next(c)
>>2 next(c)
>>1 next(d)
>>2 next(d)
</pre>



# 🧾BehaviorSubject

<br>

- 구독  후에 발생한 시점 이전에 발생한 이벤트 중 가장 최신의 이벤트를 전달받아요.
- PublishSubject와 유사하지만 반드시 초기값을 가지고 생성된다는 점이 달라요!


```swift
        let disposeBag = DisposeBag()
        
        let subject = BehaviorSubject<String>(value: "start") //observer
        
        subject.onNext("Hi")
        
        let o1 = subject.subscribe {print (">>1",$0)}
        o1.disposed(by: disposeBag)
        
        subject.onNext("a")
        subject.onNext("b")

        let o2 = subject.subscribe{print(">>2",$0)}
        o2.disposed(by: disposeBag)
        
        subject.onNext("c")
        subject.onNext("d")
```

출력결과는?
<pre>
>>1 next(Hi)
>>1 next(a)
>>1 next(b)
>>2 next(b)
>>1 next(c)
>>2 next(c)
>>1 next(d)
>>2 next(d)
</pre>

# 🧾ReplaySubject

- Broadcasts new events to all subscribers, and the specified bufferSize number of previous events to new subscribers.
- ReplaySubject는 구독 전에 발생한 이벤트를 버퍼에 넣고, 버퍼에 있던 이벤트를 구독 후에 전달해요.
- 미리 **사이즈**를 정해줘야해요. - 몇 개의 기본값?을 가질지 지정
- 메모리 관리를 신경쓰지 않으려면 createUnbounded 로 설정해줄 수 있긴해요. - 조심!
- 만약 버퍼 크기가 0이라면 PublishSubject와 같은 역할을 해요.
- 어떻게 본다면 BehaviorSubject와 유사해요!
- 버퍼사이즈만큼의 최신 이벤트를 전달받아요.

```swift

let rsubject = ReplaySubject<String>.create(bufferSize : 3) //버퍼사이즈를 바꾼다면?

rsubject.onNext("First")
rsubject.onNext("Second")
rsubject.onNext("Third")

rsubject.subscribe { event in
    print(event)
}//.dispose()를 넣는다면?

rsubject.onNext("Fourth")
rsubject.onNext("Fifth")

// 어떻게 출력될까요?

```
<br> 


# 🧾AsyncSubject

- 다른 Subject와 달리 이벤트를 전달하는 시점이 달라요.
- completed 이벤트가 전달되기 전까진 어떠한 이벤트도 전달하지 않아요.(<-> 다른 것들은 방출하면 바로 전달하죠.)
- completed되면 그 시점에서 가장 최근 이벤트 하나만 next로 전달해요.

```swift
let asubject = AsyncSubject<Int>()
asubject.onNext(1)
asubject.onNext(2)
asubject.onNext(3)
asubject.onCompleted()
aSubject.subscribe({event in
                    print(event)

})
asubject.onNext(4)
asubject.onNext(5)
```

<br>

# 🧾Relay

- RxCocoa 클래스를 이용합니다,
    - RxSwift 는 Cocoa, UIKit에 대해선 알지 못해요.
    - 이를 사용하기 위해선 RXCocoa를 이용하자!
- PublishRelay, BehaviorRelay, ReplayRelay가 있으며 Wrapper 클래스에요.
    - Wrapper 클래스란 data -> 객체로 포장해주는 클래스를 의미해요.
- deprecated된 Vairable을 대신해서 BehaviorRelay를 사용할 수 있다 하네요.
- .asObservable()를 이용하여 Subject 형태로 변환해요.

<br>

##  Relay vs Subject

- onNext 대신 accept를 사용합니다. (subject와는 달라요.)
- error, completed는 전달하지 않아요.
- Relay는 .completed, .error를 발생하지 않고 Dispose되기 전까지 계속 작동하기 때문에 UI Event에서 사용하기 적절합니다.

| Relay | Subject |
| ------ | ------ |
| emit : accept 사용 | emit : onNext 사용 |
| dispose 되어야 종료 | .completed, .error 이벤트 발생 시 구독 종료 |
| next 만 이벤트 전달 | next, error, completed  이벤트 전달 |

```swift

var BR = BehaviorRelay(value: " ")
var observable : Observable<String>{
    return BR.asObservable()
}

BR.accept("event")
```


