//
//  FirstViewController.swift
//  Seminar3
//
//  Created by taehy.k on 2022/04/25.
//

import UIKit

class FirstViewController: UIViewController {

    @IBOutlet weak var dataLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    @IBAction func nextButtonDidTap(_ sender: Any) {
        guard let secondViewController = self.storyboard?.instantiateViewController(withIdentifier: "SecondViewController") as? SecondViewController else {
            return
        }
        // 위임을 꼭 해주세요!
        secondViewController.delegate = self
        self.navigationController?.pushViewController(secondViewController, animated: true)
    }
}

extension FirstViewController: SecondViewControllerDelegate {
    func sendData(data: String) {
        dataLabel.text = data
    }
}
