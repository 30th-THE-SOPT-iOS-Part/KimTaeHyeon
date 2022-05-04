//
//  DynamicBottomSheetViewController.swift
//  CustomView
//
//  Created by taehy.k on 2022/05/03.
//

import UIKit

class DynamicBottomSheetViewController: UIViewController {

    // ------------------------------------
    // MARK: - Outlets
    // ------------------------------------
    @IBOutlet weak var dimmedView: UIView!
    @IBOutlet weak var containerView: UIView!
    
    @IBOutlet weak var sheetHeight: NSLayoutConstraint!
    @IBOutlet weak var sheetBottom: NSLayoutConstraint!
    
    // ------------------------------------
    // MARK: - Properties
    // ------------------------------------
    private let maxDimmedAlpha: CGFloat = 0.6
    private let defaultHeight: CGFloat = 300
    private let dismissibleHeight: CGFloat = 150
    private let maximumContainerHeight: CGFloat = UIScreen.main.bounds.height - 200
    private var currentContainerHeight: CGFloat = 300
    
    var childViewController: UIViewController
    
    init(childViewController: UIViewController) {
        self.childViewController = childViewController
        super.init(nibName: String(describing: DynamicBottomSheetViewController.self),
                   bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupPanGesture()
    }
    
    private func setupUI() {
        view.backgroundColor = .clear
        sheetHeight.constant = 0
        containerView.layer.cornerRadius = 20
        containerView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        
        // child vc setup
        addChild(childViewController)
        containerView.addSubview(childViewController.view)
        childViewController.didMove(toParent: self)
        
        guard let childSuperView = childViewController.view.superview else { return }
        
        NSLayoutConstraint.activate([
            childViewController.view.bottomAnchor.constraint(equalTo: childSuperView.bottomAnchor),
            childViewController.view.topAnchor.constraint(equalTo: childSuperView.topAnchor),
            childViewController.view.leftAnchor.constraint(equalTo: childSuperView.leftAnchor),
            childViewController.view.rightAnchor.constraint(equalTo: childSuperView.rightAnchor)
        ])
        
        childViewController.view.translatesAutoresizingMaskIntoConstraints = false
    }
    
    private func setupPanGesture() {
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.handlePanGesture(gesture:)))
        panGesture.delaysTouchesBegan = false
        panGesture.delaysTouchesEnded = false
        view.addGestureRecognizer(panGesture)
    }

    @objc func handlePanGesture(gesture: UIPanGestureRecognizer) {
        let translation = gesture.translation(in: view)
        let isDraggingDown = translation.y > 0
        let newHeight = currentContainerHeight - translation.y
        
        switch gesture.state {
        case .changed:
            if newHeight < maximumContainerHeight {
                sheetHeight?.constant = newHeight
                view.layoutIfNeeded()
            }
        case .ended:
            if newHeight < dismissibleHeight {
                animateDismissView()
            }
            else if newHeight < defaultHeight {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight < maximumContainerHeight && isDraggingDown {
                animateContainerHeight(defaultHeight)
            }
            else if newHeight > defaultHeight && !isDraggingDown {
                animateContainerHeight(maximumContainerHeight)
            }
        default:
            break
        }
    }
}

// MARK: - Animations
extension DynamicBottomSheetViewController {
    func animateContainerHeight(_ height: CGFloat) {
        UIView.animate(withDuration: 0.4) {
            self.sheetHeight?.constant = height
            self.view.layoutIfNeeded()
        }
        currentContainerHeight = height
    }
    
    func animatePresentContainer() {
        UIView.animate(withDuration: 0.3) {
            self.sheetBottom?.constant = 0
            self.view.layoutIfNeeded()
        }
    }
    
    func animateShowDimmedView() {
        dimmedView.alpha = 0
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = self.maxDimmedAlpha
        }
    }
    
    func animateDismissView() {
        dimmedView.alpha = maxDimmedAlpha
        UIView.animate(withDuration: 0.4) {
            self.dimmedView.alpha = 0
            self.sheetHeight.constant = 0
            self.view.layoutIfNeeded()
        } completion: { _ in
            self.dismiss(animated: false)
        }
    }
}
