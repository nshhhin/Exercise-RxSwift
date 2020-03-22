//
//  ViewController.swift
//  Exercise1
//
//  Created by 新納真次郎 on 2020/02/01.
//  Copyright © 2020 新納真次郎. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa
import RxOptional

class ViewController: UIViewController {

    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var sendButton: UIButton!
    @IBOutlet weak var displayLabel: UILabel!

    let disposeBag = DisposeBag()

    let nameFieldSize: Int = 10
    let limitLabel: (Int) -> String = {
        return "あと\($0)文字"
    }

    override func viewDidLoad() {
        super.viewDidLoad()
//        textField.rx.text.orEmpty
//        .bind(to: displayLabel.rx.text)
//        .disposed(by: disposeBag)


        textField.rx.text.map{ [weak self] text -> String? in
            guard let text = text else { return nil }
            guard let nameFieldSize = self?.nameFieldSize else { return nil }
            let limitCount = nameFieldSize - text.count
            return self?.limitLabel(limitCount)
        }
        .filterNil()
        .bind(to: displayLabel.rx.text)
        .disposed(by: disposeBag)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


}
