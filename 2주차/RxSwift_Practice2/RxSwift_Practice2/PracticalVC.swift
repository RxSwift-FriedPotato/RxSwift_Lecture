//
//  PracticalVC.swift
//  RxSwift_Practice2
//
//  Created by 홍진석 on 2021/04/28.
//

import UIKit
import RxSwift

class PracticalVC: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    @IBAction func selectBtnClicked(_ sender: Any) {
        let nextVC = storyboard?.instantiateViewController(withIdentifier: "Practical2VC") as! Practical2VC
        
        nextVC.subject1.subscribe(onNext: { [weak self] character in
            self?.helloLabel.text = "Hello \(character)"
        }).disposed(by: disposeBag)
            
        navigationController?.pushViewController(nextVC, animated: true)
    }
}
