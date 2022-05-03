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
    
    private var originBeforeAnimation: CGRect = .zero

    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        dismissWithAnimation()
    }
    
    private func setupUI() {
        bottomSheetHeight.constant = 0
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
    }
}

// MARK: - Animations

extension BottomSheet {
    func showWithAnimation() {
        UIView.animate(withDuration: 0.3) { [weak self] in
            self?.bottomSheetHeight.constant = 330
            self?.view.layoutIfNeeded()
        }
    }
    
    private func dismissWithAnimation() {
        UIView.animate(withDuration: 0.3, animations: { [weak self] in
            self?.bottomSheetHeight.constant = 0
            self?.view.layoutIfNeeded()
        }, completion: { _ in
            self.dismiss(animated: false)
        })
    }
}
