//
//  MainViewController.swift
//  CustomView
//
//  Created by taehy.k on 2022/05/03.
//

import UIKit

class MainViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

extension MainViewController {
    
    @IBAction func popUpButtonDidTap(_ sender: UIButton) {
        print("팝업")
    }
    
    @IBAction func bottomSheetButtonDidTap(_ sender: UIButton) {
        print("바텀시트")
    }
    
    @IBAction func tabPagerButtonDidTap(_ sender: UIButton) {
        print("탭 페이저")
    }
}
