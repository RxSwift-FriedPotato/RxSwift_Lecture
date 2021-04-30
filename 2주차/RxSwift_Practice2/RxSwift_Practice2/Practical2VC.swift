//
//  Practical2VC.swift
//  RxSwift_Practice2
//
//  Created by 홍진석 on 2021/04/28.
//

import UIKit
import RxSwift

class Practical2VC: UIViewController {
    var subject1 = PublishSubject<String>()
    //var subject2 = BehaviorSubject(value: " ")
    //var subject3 = ReplaySubject<String>.create(bufferSize: 2)

    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func characterClicked(_ sender: UIButton) {

        guard let characterName = sender.titleLabel?.text else{return}
        
        subject1.onNext(characterName)
        
    }

}
