//
//  RxCocoaVC.swift
//  RxSwift_Practice2
//
//  Created by 홍진석 on 2021/04/29.
//

import UIKit
import RxCocoa
import RxSwift

class RxCocoaVC: UIViewController {

    let disposebag = DisposeBag()
    var BR = BehaviorRelay(value: " ")
    var BS = BehaviorSubject(value: " ")
    
    var observable : Observable<String>{
        return BR.asObservable()
    }
    
    @IBOutlet weak var switchLabel: UILabel!
    @IBOutlet weak var rxSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        rxSwitch.rx.isOn.subscribe { (enable) in
            self.switchLabel.text = enable.element! ? "On" : "Off"
            self.BR.accept(self.switchLabel.text ?? " ")
        }.disposed(by: disposebag)
        
        observable.subscribe { (event) in
            print(event)
        }.disposed(by: disposebag)
        
    }


}
