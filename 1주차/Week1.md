1주차 목차

- [🧾RxSwift란?](#rxswift란)
  - [비동기](#비동기)
  - [RxSwift을 사용하는 이유](#rxswift을-사용하는-이유)
  - [RxSwift의 세 가지 구성요소](#rxswift의-세-가지-구성요소)
- [🧾Observable](#observable)
- [🧾Disposable](#disposable)

<br>

# 🧾RxSwift란?

RxSwift는 Reactive extension + Swift의 합성어로, 비동기 프로그래밍을 관찰 가능한 흐름으로 지원해주는 API입니다.

우선 '비동기'라는 용어에 대해서 알아봅시다!

<br>

## 비동기

비동기란 영어로 Asynchronous 라는 단어로, 사전적으로 '동시에 발생하지 않는'이라는 뜻을 갖고 있습니다.

즉, iOS에서 한 가지 일을 처리하는 동시에 다른 일도 함께 처리하는 것을 의미합니다.

<br>

iOS에서 비동기(Asynchronous) ↔ 동기(Synchronous)의 차이를 실감나게 살펴봅시다.

<img src="https://user-images.githubusercontent.com/70688424/115661296-307f8a80-a378-11eb-90ca-c0419e1c7e57.gif" width="70%">

1. 웹 url을 통해 이미지를 다운로드 하고 불러오는 작업
2. 시간 초를 세는 작업

두 가지의 작업을 동시에 진행할 때, 동기로 작업을 하게 되면 이미지를 불러오는 작업을 하는 동안 시간 초를 세는 작업은 일시적으로 멈추게 됩니다.

하지만, 비동기로 작업을 하게 되면 이미지를 불러오는 동시에, 시간 초를 세는 작업도 함께 진행하게 됩니다.

이외에도, 앞으로 iOS 개발을 하며 비동기 프로그래밍을 할 일이 종종 있을텐데요, 예를 들면

- 버튼을 눌렀을 때의 이벤트 반응
- 텍스트필드에 포커스가 잡힌 경우
- 인터넷에서 크기가 큰 이미지 파일을 받는 경우
- 디스크에 데이터를 저장하는 경우
- 오디오를 실행하는 경우

이런 작업들이 있습니다.

<br>

우리는 RxSwift를 배우기 전에도 UIKit을 통해 비동기를 경험했던 순간들이 있습니다. 예를 들면

- NotificationCenter : 백그라운드 진입 후 몇초 있다가 메시지 알림
- The delegate pattern : tableView의 didSelectRowAt과 같은 메소드
- closure

이런 작업들이 있고, RxSwift를 사용하지 않아도 비동기 처리를 할 수 있는 방법은 많습니다.

근데 굳이 RxSwift를 사용하는 이유는 뭘까요?

<br>

## RxSwift을 사용하는 이유

**코드의 일관성**

우선 Rxswift를 사용하면 일관성 있는 하나의 비동기 코드로 비동기 처리가 가능합니다.

사실, 아까 위에서 [비동기](#비동기)를 설명할 때 보여드렸던 예시에서는 RxSwift를 사용하지 않았습니다.

<pre>
<code>
    // MARK: - IBAction

    @IBAction func onLoadSync(_ sender: Any) {
        let image = loadImage(from: IMAGE_URL)
        imageView.image = image
    }

    @IBAction func onLoadAsync(_ sender: Any) {
        DispatchQueue.global().async { [self] in
            let image = loadImage(from: IMAGE_URL)
            
            DispatchQueue.main.async {
                self.imageView.image = image
            }
        }
    }
</code>
</pre>

DispatchQueue를 이용해 비동기 처리를 했던 것이고, iOS에서 비동기를 처리하는 방법은 다양하게 많은 방법이 있습니다.

하지만 지금처럼 아주 간단한 예시 작업이 아닌 실제 작업에서는 여러 쓰레드를 넘나 들고 Completion 메소드를 작성하며 처리 해야하기 때문에 가독성도 좋지 않고 골치 아픈 경우가 많지만, RxSwift는 그럴수록 Observable이라는 래퍼런스 타입 하나만으로 간결하고 깔끔하게 가독성 좋은 모습으로 처리할 수 있습니다.

<br>

**아키텍처의 확장**

Microsoft의 MVVM 아키텍처는 데이터 바인딩을 제공하는 플랫폼에서 만들어진 이벤트 중심 프로그램을 위해 특별히 개발되었기 때문에, RxSwift와 함께 사용했을 때 아주 간편하게 MVVM 디자인 패턴을 구현할 수 있습니다.

또한 Rx로 설계가 된 아키텍처 영역(ReactorKit, RxFlow 등)과 서비스 영역(MoyaSugar, RxBus, RxStarscream 등)의 기능도 활용할 수 있습니다.

<br>

**Side Effects를 통해 state 파악**

<pre>
<code>
    override func viewDidAppear(_ animated: Bool) {
      super.viewDidAppear(animated)
      
      setupUI()
      connectUIControls()
      createDataSource()
      listenForChanges()
    }
</code>
</pre>

위의 코드 같은 경우, 각각의 메소드들이 하는 일을 알 수 없으며 순서를 조금 바꾸면 전혀 다른 메소드가 될 수도 있습니다.

올바른 순서대로 메소드들이 작동할지도 알 수 없어요.

하지만 RxSwift를 활용한다면, Side Effect를 통해 코드의 현재 흐름을 확인하고 메소드가 실행되기 전의 작업을 직접 지정해줄 수 있다는 장점이 있습니다.

<br>

## RxSwift의 세 가지 구성요소

1. observables(생산자)
2. operators(연산자)
3. schedulers(스케쥴러)

<br>

**Observable**

RxSwift의 핵심입니다.

- 하나 이상의 Observer가 실시간으로 이벤트에 반응하고, UI를 업데이트하거나, 들어오는 데이터를 처리하고 활용할 수 있게 합니다.

- observer가 observable을 구독하는 형태입니다.

- 어떤 이벤트를 관찰하다 응답이 있을 시 반응을 해주는 구조인데, Observable이라는 레퍼런스 타입을 이용해서 값을 관찰합니다.

**Operators**

비동기 입력을 받아 부수작용 없이 return을 생성합니다.

Observer에서 나온 결과를 Operator를 통해 입력 및 출력이 가능한데, 이 말은 Side Effect를 발생시킬 수 있다는 것입니다.

**Schedulers**

RxSwift에서 기존의 DispatchQueue와 동일한 개념이지만 훨씬 강력하고 사용하기 쉽습니다.

<br>

# 🧾Observable

<img src="https://user-images.githubusercontent.com/70688424/115702260-ac42fc80-a3a3-11eb-9cec-0704618282bb.gif" width="70%">

이제 이 gif를 예시로, 비동기 처리를 RxSwift에서 어떻게 하는지 알아보도록 하겠습니다.

<br>

<pre>
<code>
    // MARK: - Observable 생성
    func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { image in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
</code>
</pre>

Observable\<T> 클래스는 Rx 코드기반으로, T형태의 데이터 Snapshot을 전달할 수 있는 일련의 이벤트를 비동기적으로 생성하는 기능입니다.

Observable event의 종류로는 next, completed, error가 있습니다.

- next : 최신/다음 데이터를 방출하는 이벤트입니다.
- completed : 성공적으로 next 이벤트가 완료되었을 때, complete 이벤트가 방출되며 종료합니다.
- error : Observable이 값을 방출하다 에러가 발생하면 error 이벤트를 방출하고 종료합니다.

위 코드블럭의 함수를 통해 Observable을 구독하는 Observer가 생성될 수 있습니다.

이제 '불러오기' 버튼의 코드를 확인해보겠습니다.

<pre>
<code>
    // MARK: - 불러오기 버튼
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil

        disposable = rxswiftLoadImage(from: LARGER_IMAGE_URL)
            .observeOn(MainScheduler.instance)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.imageView.image = image

                case let .error(err):
                    print(err.localizedDescription)

                case .completed:
                    break
                }
            })
    }
</code>
</pre>

Observer를 create 하는 함수에 이미지url을 넣고, Observable을 구독시켰습니다.

이후 next이벤트가 반응되게 되는데, next이벤트는 이미지뷰의 이미지를 바꾸도록 구성되어 있습니다.

그렇기 때문에 매번 '불러오기'버튼을 클릭할 때 마다 이미지가 변경되는 것입니다.

<br>

# 🧾Disposable

위의 Observable에 대한 코드블럭을 보면, Disposable이라는 단어들이 보일 것입니다.

dispose의 사전적 의미는 '처리하다’이며 disposable은 ‘처리할 수 있는’이라는 뜻을 가지고 있습니다.

개발을 하다보면 모종의 이유로 비동기 처리를 해 둔 작업을 멈춰야할 때가 있겠죠? 이 때 RxSwift에서는 Disposable을 사용합니다.

이벤트 취소를 ‘처리’한다는 개념으로 이해하면 좋을 것 같아요. 간단하게 말해서 Disposable은 작업 취소에 쓰이는 프로토콜이라고 할 수 있습니다.

한편 돌아가고 있는 여러 개의 비동기 작업을 한번에 취소하고 싶을 수도 있겠죠? 그럴 땐 DisposeBag를 이용하면 됩니다.

각각의 Disposable을 DisposeBag에 모아 담는다는 개념입니다.

Observable의 subscribe을 사용하면 모두 Disposable을 return(반환)하는데, 이를 이용하여 작업이 끝난 후 처분을 할 수 있으며, 작업 도중에 하던 작업을 취소하는 것도 가능합니다.

<img src="https://user-images.githubusercontent.com/70688424/115711818-f4b3e780-a3ae-11eb-8ed3-f80dd0488c6f.gif" width=70%>

이미지 불러오기 작업 또한, Disposable을 이용해 이미지가 불러와지던 도중에 작업을 취소시켜 이미지가 오지 않도록 할 수 있습니다.

<pre>
<code>
    // MARK: - Disposable 타입의 전역변수 선언
    var disposable: Disposable?

    // MARK: - 불러오기 버튼
    @IBAction func onLoadImage(_ sender: Any) {
        imageView.image = nil

        disposable = rxswiftLoadImage(from: LARGER_IMAGE_URL)
            .observeOn(MainScheduler.instance)
            .subscribe({ result in
                switch result {
                case let .next(image):
                    self.imageView.image = image

                case let .error(err):
                    print(err.localizedDescription)

                case .completed:
                    break
                }
            })
    }

    // MARK: - 취소하기 버튼
    @IBAction func onCancel(_ sender: Any) {
        disposable?.dispose()
    }

    // MARK: - Observable 생성
    func rxswiftLoadImage(from imageUrl: String) -> Observable<UIImage?> {
        return Observable.create { seal in
            asyncLoadImage(from: imageUrl) { image in
                seal.onNext(image)
                seal.onCompleted()
            }
            return Disposables.create()
        }
    }
}
</code>
</pre>

이전 [Observable](#observable)에서의 예시 코드에 '취소하기' 버튼의 코드를 추가한 코드블럭입니다.

전역변수로 disposable이라는 Disposable 타입의 변수가 선언 되어있습니다.

아까 Observable의 subscribe을 사용하면 모두 Disposable을 반환한다고 언급했었는데, '불러오기' 버튼을 통해 disposable 변수에 Disposable이 담기게 했습니다.

이후 '취소하기' 버튼에서 dispose()함수를 통해 이미지가 불러와지기 전에 처분되도록 하는 것입니다.

Disposable에는 여러가지 종류가 있습니다. 우선 가장 많이 쓰일법한 것 위주로 정리해두었습니다.

1.	Disposables
    -	Disposables.create() : Observable dispose 시점에서 처리할 동작이 없을 때
    -	Disposables.create{} : Observable dispose 시점에서 처리할 동작이 있을 때, {} 안에 코드를 넣어준다.

2.	BooleanDisposable() : dispose 상태 여부를 알고 싶을 때

    예를 들어 비동기 작업을 수행하는 Observable이 있다고 합시다. 더 이상 그 작업이 필요하지 않아서 Observable을 dispose한 뒤, 해당 작업의 결과를 수행하지 않기 위해 dispose 되었다는 상태값이 필요할 수 있습니다. 즉, dispose한 뒤 처리할 동작은 없지만 dispose 상태를 알아야 할 때 사용하는 것입니다.

3. CompositeDisposable : 여러 개의 disposable을 한번에 관리하고 싶을 때 key값을 이용하면 개별적으로 dispose도 가능하다.