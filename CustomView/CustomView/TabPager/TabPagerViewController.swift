//
//  TabPagerViewController.swift
//  CustomView
//
//  Created by taehy.k on 2022/05/03.
//

import UIKit

/*
 Description
 
 - Tab Pager가 있는 Scene은 Storyboard로 만들었음.
 
 - TabStackView : Button으로 구성 (가장 상단 탭에 해당)
 - IndicatorView(BarView) : 탭 아래에서 움직이는 밑줄
 - ContainerView : PageViewController가 들어갈 공간(영역)
   ㄴ 해당 자리는 다양하게 구현 가능 (PageViewController를 사용해도 되고, ScrollView + StackView를 사용해도 되고, CollectionView를 사용해도 됨)
 
 - FirstViewController, SecondViewController, ThirdViewController는 PageViewController안에 들어가는 컨텐츠 뷰 컨트롤러임. (임의로 만든 더미 클래스)
 */

final class TabPagerViewController: UIViewController {

    // ------------------------------------------
    // Outlets
    // ------------------------------------------
    @IBOutlet weak var tabStackView: UIStackView!
    @IBOutlet weak var indicatorView: UIView!
    @IBOutlet weak var indicatorViewWidth: NSLayoutConstraint!
    @IBOutlet weak var indicatorLeading: NSLayoutConstraint!
    @IBOutlet weak var containerView: UIView!
    
    // ------------------------------------------
    // Properties
    // ------------------------------------------
    private let pageViewController = UIPageViewController(transitionStyle: .scroll, navigationOrientation: .horizontal)
    private var dataViewControllers: [UIViewController] = [FirstViewController(), SecondViewController(), ThirdViewController()]
    private var currentIndex: Int = 0
    private var selectedButton = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
        setupPageViewController()
    }
    
    // ------------------------------------------
    // Private Methods
    // ------------------------------------------
    private func setupUI() {
        indicatorViewWidth.constant = view.bounds.width / CGFloat(tabStackView.arrangedSubviews.count)
    }
    
    private func setupPageViewController() {
        self.addChild(pageViewController)
        self.containerView.addSubview(pageViewController.view)
        pageViewController.didMove(toParent: self)
        
        pageViewController.delegate = self
        pageViewController.dataSource = self
        
        if let firstViewController = dataViewControllers.first {
            pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }

        for subview in pageViewController.view.subviews {
            if let scrollView = subview as? UIScrollView {
                scrollView.delegate = self
            }
        }
    }
    
    // ------------------------------------------
    // 탭 클릭 시 (인디케이터 및 컨텐츠 스크롤)
    // ------------------------------------------
    @IBAction func tabDidtap(_ sender: UIButton) {
        guard let index = tabStackView.arrangedSubviews.firstIndex(where: { $0 === sender }),
              index != currentIndex else {
            return
        }
        
        selectedButton.toggle()

        UIView.animate(withDuration: 0.3) {
            self.indicatorLeading.constant = CGFloat(index) * self.indicatorView.frame.width
            self.view.layoutIfNeeded()
        }
        
        let content = dataViewControllers[index]
        pageViewController.setViewControllers(
            [content],
            direction: currentIndex < index ? .forward : .reverse,
            animated: true
        ) { [weak self] _ in
            self?.currentIndex = index
            self?.selectedButton.toggle()
        }
    }
}

// ------------------------------------------------------
// PageViewController Protocols (DataSource, Delegate)
// ------------------------------------------------------
extension TabPagerViewController: UIPageViewControllerDelegate, UIPageViewControllerDataSource {
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        guard let viewController = pageViewController.viewControllers?.first,
        let index = dataViewControllers.firstIndex(where: { $0 == viewController }) else {
            return
        }
//        print(index)
        currentIndex = index
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
//        currentIndex = index
        let previousIndex = index - 1
        if previousIndex < 0 {
            return nil
        }
        return dataViewControllers[previousIndex]
    }

    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        guard let index = dataViewControllers.firstIndex(of: viewController) else { return nil }
//        currentIndex = index
        let nextIndex = index + 1
        if nextIndex == dataViewControllers.count {
            return nil
        }
        return dataViewControllers[nextIndex]
    }
}

// ------------------------------------------------------
// ScrollView Delegate
// ------------------------------------------------------
extension TabPagerViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard !selectedButton else { return }
        let offsetX = scrollView.contentOffset.x
        let percentComplete = (offsetX - pageViewController.view.frame.width) / pageViewController.view.frame.width
        let constant = (CGFloat(currentIndex) + percentComplete) * indicatorView.frame.width
        indicatorView.frame.origin.x = constant
    }
}
