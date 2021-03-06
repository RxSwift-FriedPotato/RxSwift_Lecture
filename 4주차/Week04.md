4์ฃผ์ฐจ ๋ชฉ์ฐจ

- [๐งพTraits๋?](#traits๋)
    - [๐ Traits์ ์ข๋ฅ](#-traits์-์ข๋ฅ)
- [๐งพSingle](#single)
    - [๐ Single ์ฌ์ฉํ๊ธฐ](#-single-์ฌ์ฉํ๊ธฐ)
- [๐งพCompletable๋?](#completable)
    - [๐ Completable ์ฌ์ฉํ๊ธฐ](#-completable-์ฌ์ฉํ๊ธฐ)
- [๐งพMaybe๋?](#maybe)
    - [๐ Maybe ์ฌ์ฉํ๊ธฐ](#-maybe-์ฌ์ฉํ๊ธฐ)

<br>

# ๐งพTraits๋?

RxSwift์์ [Traits](https://github.com/ReactiveX/RxSwift/blob/main/Documentation/Traits.md#rxswift-traits)๋ฅผ ํตํด ๋ชํํ ์ด๋ฒคํธ ๋ฐ์๊ท์น์ ๊ฐ์ง Observable์ ์ฌ์ฉํ  ์ ์๋๋ก ์ง์ํฉ๋๋ค.

Traits๋ ์ฝ๋์ ๋ชํํจ๊ณผ ์ง๊ด์ฑ์ ๊ฐ์ง๊ณ ์ ํ  ๋ ์ ํ์ ์ผ๋ก ์ฌ์ฉํ๋ฉด ๋๊ณ , ์ฝ๋์ ์๋๋ฅผ ๋ถ๋ชํ ํ  ์ ์๋ค๋ ์ฅ์ ์ด ์์ต๋๋ค.

์ฃผ๋ก UI์ ํนํ๋ Observable์ ์์ฑํ๋๋ฐ ์ฌ์ฉ๋๋ฉฐ Single, Completable, Maybe ์ธ ๊ฐ์ง ์ข๋ฅ๊ฐ ์์ต๋๋ค.

RxCocoa์๋ ๋ ๋ค๋ฅธ Traits๋ค์ด ์๋๋ฐ(Driver, Signal, ControlProperty, ControlEvent), ์ฐ๋ฆฌ๋ ์ฐ์  RxSwift์ Traits์ ๋ํด์ ๊ณต๋ถํด๋ด์๋ค!


### ๐ Traits์ ์ข๋ฅ

1. Single : ์ผ๋ จ์ ์์๋ฅผ ๋ฐฉ์ถํ๋ ๋์  ํญ์ ๋จ์ผ ์์ ๋๋ ์๋ฌ๋ฅผ ๋ฐฉ์ถํ๋๋ก ๋ณด์ฅํ๋ ์ํ์ค
  
2. Completable : ์ด๋ฒคํธ์ ๋ํด ์๋ฃ ๋๋ ์๋ฌ๋ฅผ ๋ฐฉ์ถํ๊ณ , ์์๋ ์๋ฌด๊ฒ๋ ๋ฐฉ์ถํ์ง ์๋ ๊ฒ์ ๋ณด์ฅํ๋ ์ํ์ค

3. Maybe : Single๊ณผ Completable์ ์ค๊ฐ ํน์ฑ์ ๊ฐ์ง๋ ์ํ์ค

<br>

# ๐งพSingle

Single์ Observable์ ๋ณํ์ผ๋ก, ์ผ๋ จ์ ์์๋ฅผ ๋ฐฉ์ถํ๋ ๋์  **ํญ์ ๋จ์ผ ์์** ๋๋ **์ค๋ฅ๋ฅผ ๋ฐฉ์ถ**ํ๋๋ก ๋ณด์ฅํฉ๋๋ค.

- ์ ํํ ํ๋์ ์์ ๋๋ error๋ฅผ ๋ฐฉ์ถํฉ๋๋ค.
- ๋ถ์์์ฉ์ ๊ณต์ ํ์ง ์์ต๋๋ค.

Single์ ์ผ๋ฐ์ ์ผ๋ก ์๋ต, ์ค๋ฅ๋ง ๋ฐํํ ์ ์๋ HTTP Request ์๋ต์ ์ฒ๋ฆฌํ๋๋ฐ ์ฌ์ฉ๋๋ฉฐ, ๋จ์ผ์์๋ฅผ ์ฌ์ฉํ์ฌ ๋ฌดํ ์คํธ๋ฆผ ์์๊ฐ ์๋ ๋จ์ผ ์์๋ง ๊ด๋ฆฌํ๋ ๊ฒฝ์ฐ๋ฅผ ๋ชจ๋ธํ๋๋ฐ ์ฌ์ฉํ ์ ์์ต๋๋ค.

Observable์ ์ฒ๋ฆฌํ๋ onNext, onError, onComplete ์ธ ๊ฐ์ง ์ฒ๋ฆฌ๊ฐ ํ์ ์์ผ๋ฉฐ, Success์ Failure๋ง ์ฒ๋ฆฌํ๋ฉด ๋ฉ๋๋ค.

๊ธฐ๋ณธ์ ์ผ๋ก Single์ Observable์ด๋ฏ๋ก ๊ธฐํ Observable ์ฐ์ฐ์๋ค์ ์ฌ์ฉํ  ์ ์์ต๋๋ค. (map, just ๋ฑ๋ฑ)

<br>

<img width="500" alt="single" src="https://user-images.githubusercontent.com/70695311/118115170-95804a80-b423-11eb-854e-f1105cfc2150.png">

<br>

### ๐ Single ์ฌ์ฉํ๊ธฐ

Single์ Observable์ ์์ฑํ๋ ๊ฒ๊ณผ ๋งค์ฐ ์ ์ฌํฉ๋๋ค.<br>**Single\<T>.create()**

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

์์ ์์๋ url์ด nil์ด๋ฉด failure๋ฅผ, url์ด google์ด๋ฉด ture, ์๋๋ฉด false์ ํ๋ฆ์ ๋ฐฉ์ถํ๋ Single์ ์์ฑํ๋ ์์์๋๋ค.

์์์ ์์ฑ๋ Single์ ๋ค์๊ณผ ๊ฐ์ด ๊ตฌ๋ํ์ฌ ์ฌ์ฉํ  ์ ์์ต๋๋ค.

```
getRequest(url: "https://www.github.com")
    .subscribe(onSuccess: { success in
        print("url ํ๋ณ: ", success)
    }, onFailure: { error in
        print("Error: ", error)
    })
    .dispose()
```

```
<์ถ๋ ฅ๊ฒฐ๊ณผ>
url ํ๋ณ: false
```

onSuccess : Single์ ์์ ์ด ๋ฐฐ์ถํ๋ ํ๋์ ๊ฐ์ ์ด ๋ฉ์๋๋ฅผ ํตํด ์ ๋ฌํฉ๋๋ค.<br>
onFailure : Single์ ํญ๋ชฉ์ ๋ฐฐ์ถํ  ์ ์์ ๋ ์ด ๋ฉ์๋๋ฅผ ํตํด Throwable ๊ฐ์ฒด๋ฅผ ์ ๋ฌํฉ๋๋ค.

Single์ ์ด ๋ฉ์๋๋ค ์ค ํ๋๋ง, ๊ทธ๋ฆฌ๊ณ  ํ ๋ฒ๋ง ํธ์ถํ๋ฉฐ, ๋ฉ์๋๊ฐ ํธ์ถ๋๋ฉด Single์ ์๋ช์ฃผ๊ธฐ๊ฐ ๋๋๊ณ  ๊ตฌ๋๋ ์ข๋ฃ๋ฉ๋๋ค.

# ๐งพCompletable

- completed, error ๋ ๊ฐ์ง ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ  ์ ์๋ค.
- ์๋ฌด element๋ ๋ฐฉ์ถํ์ง ์๊ธฐ์ ๋จ์ ์๋ฃ ์ฌ๋ถ๋ง ์๊ณ  ์ถ์๋ ์จ์.
- ์ธ์ ์จ์ผํ ๊น? - ์๋ฃ์ ๋ฐ๋ฅธ ์์์ ์ ๊ฒฝ์ฐ์ง ์๋ ๊ฒฝ์ฐ์ ์ ์ฉ
- Completable๋ก ์ํ์ค ํ ๋ณํ์ด ํ์ํ  ๋๋ .ignoreElements( )๋ฅผ ์ด์ฉํ์. 

<br>

<img width="500" alt="completable" src="https://user-images.githubusercontent.com/70695311/118115175-96b17780-b423-11eb-8573-b4163d65f6c0.png">

<br>

### ๐ Completable ์ฌ์ฉํ๊ธฐ

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

//์ฌ์ฉ๋ฒ
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

# ๐งพMaybe

- success(value), completed, error 3๊ฐ์ง ์ด๋ฒคํธ๋ฅผ ๋ฐฉ์ถํ  ์ ์๋ค. 
- Signle, Completable ์ฌ์ด์ ์๋ Observable์ ๋ณํ
        - element๋ฅผ ๋ฐฉ์ถ ํ  ์ ์๋ค. -> Single์ ํน์ง
        - element๋ฅผ ๋ฐฉ์ถํ์ง ์๊ณ  ์๋ฃ(์ฑ๊ณต)ํ  ์ ์๋ค. -> Completable์ ํน์ง 
- 0 ๋๋ 1๊ฐ์ element๋ฅผ ํฌํจํ๋ Observable sequence
- single๊ณผ ๋ฌ๋ฆฌ ๋ฐฉ์ถ์์ด ์๋ฃ๊ฐ ๊ฐ๋ฅํ๋ค. 

<br>

<img width="500" alt="maybe" src="https://user-images.githubusercontent.com/70695311/118115177-974a0e00-b423-11eb-8fdd-2240121a4d7f.png">

<br>

### ๐ Maybe ์ฌ์ฉํ๊ธฐ

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
