//
//  PopUp.swift
//  CustomView
//
//  Created by taehy.k on 2022/05/03.
//

import UIKit

class PopUp: UIViewController {

    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var imageView: NSLayoutConstraint!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var joinButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    private func setupUI() {
        containerView.layer.cornerRadius = 16
        joinButton.layer.cornerRadius = 8
    }
    
    @IBAction func closeButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
    
    @IBAction func joinButtonDidTap(_ sender: Any) {
        dismiss(animated: true)
    }
}

extension PopUp {
    /**
     - 애니메이션을 곁들인
     */
    func showWithAnimation() {
        self.containerView.transform = CGAffineTransform(scaleX: 0.001, y: 0.001)
        UIView.animate(withDuration: 0.3) {
            self.containerView.transform = CGAffineTransform(scaleX: 1.05, y: 1.05)
        } completion: { _ in
            UIView.animate(withDuration: 0.05) {
                self.containerView.transform = CGAffineTransform.identity
            }
        }
    }
}
