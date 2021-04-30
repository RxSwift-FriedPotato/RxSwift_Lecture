//
//  SubjectVSObservableVC.swift
//  RxSwift_Practice2
//
//  Created by 홍진석 on 2021/04/28.
//

import UIKit
import RxSwift

class SubjectVSObservableVC: UIViewController {

    @IBOutlet weak var ob1: UILabel!
    @IBOutlet weak var ob2: UILabel!
    @IBOutlet weak var ob3: UILabel!
    
    
    @IBOutlet weak var sub1: UILabel!
    @IBOutlet weak var sub2: UILabel!
    @IBOutlet weak var sub3: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
   
    @IBAction func RoleBtnClicked(_ sender: Any) {
        let randomNumGenerator1 = Observable<Int>.create{ observer in
            observer.onNext(Int.random(in: 0 ..< 100))
            return Disposables.create()
        }
        
        randomNumGenerator1.subscribe(onNext: { (element) in
            self.ob1.text = "\(element)"
        }).dispose()
        randomNumGenerator1.subscribe(onNext: { (element) in
            self.ob2.text = "\(element)"
        })
        randomNumGenerator1.subscribe(onNext: { (element) in
            self.ob3.text = "\(element)"
        })
        
 
        let randomNumGenerator2 = BehaviorSubject(value: 0)
        randomNumGenerator2.onNext(Int.random(in: 0..<100))
        
        randomNumGenerator2.subscribe(onNext: { (element) in
            self.sub1.text = "\(element)"
        })
        randomNumGenerator2.subscribe(onNext: { (element) in
            self.sub2.text = "\(element)"
        })
        randomNumGenerator2.subscribe(onNext: { (element) in
            self.sub3.text = "\(element)"
        })
        
        //왜 warning이 생겼을까요?
    }
    
}
