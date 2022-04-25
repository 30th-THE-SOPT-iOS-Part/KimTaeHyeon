//
//  SecondViewController.swift
//  Seminar3
//
//  Created by taehy.k on 2022/04/25.
//

import UIKit

// 프로토콜 정의
protocol SecondViewControllerDelegate: AnyObject {
    func sendData(data: String)
}

class SecondViewController: UIViewController {

    @IBOutlet weak var dataTextField: UITextField!
    
    weak var delegate: SecondViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func sendDataButtonDidTap(_ sender: Any) {
        if let text = dataTextField.text {
            delegate?.sendData(data: text)
        }
        self.navigationController?.popViewController(animated: true)
    }
}
