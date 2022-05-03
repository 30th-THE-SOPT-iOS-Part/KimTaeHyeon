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
    
    // MARK: - 팝업
    @IBAction func popUpButtonDidTap(_ sender: UIButton) {
        print("팝업")
        let popUp = PopUp(nibName: "PopUp", bundle: nil)
        popUp.modalTransitionStyle = .crossDissolve
        popUp.modalPresentationStyle = .overFullScreen
        
        // 애니메이션 없는 ❌
        present(popUp, animated: true)
        
        // 애니메이션 있는 ✅
//        present(popUp, animated: false) {
//            popUp.showWithAnimation()
//        }
    }
    
    // MARK: - 바텀시트
    @IBAction func bottomSheetButtonDidTap(_ sender: UIButton) {
        print("바텀시트")
        let bottomSheet = BottomSheet(nibName: "BottomSheet", bundle: nil)
        bottomSheet.modalTransitionStyle = .crossDissolve
        bottomSheet.modalPresentationStyle = .overFullScreen
        present(bottomSheet, animated: false) {
            bottomSheet.showWithAnimation()
        }
    }
    
    // MARK: - 탭 페이저
    @IBAction func tabPagerButtonDidTap(_ sender: UIButton) {
        print("탭 페이저")
    }
    
    @IBAction func dynamicBottomSheetButtonDidTap(_ sender: UIButton) {
        let dynamicBottomSheet = DynamicBottomSheetViewController(nibName: "DynamicBottomSheetViewController", bundle: nil)
        dynamicBottomSheet.modalPresentationStyle = .overFullScreen
        present(dynamicBottomSheet, animated: false) {
            dynamicBottomSheet.animateContainerHeight(300)
        }
    }
}
