//
//  BottomSheet.swift
//  CustomView
//
//  Created by taehy.k on 2022/05/03.
//

import UIKit

class BottomSheet: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var bottomSheetHeight: NSLayoutConstraint!

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismiss(animated: true)
    }
    
    private func setupUI() {
        bottomSheetHeight.constant = 0
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
    
    func showWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.bottomSheetHeight.constant = 330
            self?.view.layoutIfNeeded()
        }
    }
}
