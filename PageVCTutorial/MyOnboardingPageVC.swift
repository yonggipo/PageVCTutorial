//
//  MyOnboardingPageVC.swift
//  PageVCTutorial
//
//  Created by 조기열 on 2023/05/03.
//

import Foundation
import UIKit

class MyOnboardingPageVC: UIPageViewController {
    
    // MARK: - Properties
    
    var nums = [0, 1, 2, 3, 4, 5, 6]
    var pageVCs: [SimpleVC] = []
    var currentIndex: Int? = nil
    var currentPageChanged: ((Int) -> Void)? = nil
    
    fileprivate var tempCurrentIndex: Int? = nil
    
    // MARK: - View Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Swift.debugPrint(#fileID, #function, #line, "- ")
        
        pageVCs = nums.map { SimpleVC.simpleVC(index: $0) }
        
        setViewControllers([pageVCs[0]], direction: .forward, animated: true) { value in
            Swift.debugPrint(#fileID, #function, #line, "- value: \(value)")
        }
        
        dataSource = self
        delegate = self
    }
    
    func goNext() {
        Swift.debugPrint(#fileID, #function, #line, "- ")
        
        let currentPageIndex = currentIndex ?? 0
        var nextPageIndex = currentPageIndex + 1
        
        if nextPageIndex >= pageVCs.count {
            nextPageIndex = 0
        }
        
        setViewControllers([pageVCs[nextPageIndex]], direction: .forward, animated: true) { [weak self] value in
            Swift.debugPrint(#fileID, #function, #line, "- value: \(value)")
            guard let self = self else { return }
            self.currentIndex = nextPageIndex
            self.currentPageChanged?(nextPageIndex)
        }
    }
    
    func goPrevious() {
        Swift.debugPrint(#fileID, #function, #line, "- ")
        
        let currentPageIndex = currentIndex ?? 0
        var previousPage = currentPageIndex - 1
        
        if previousPage < 0 {
            previousPage = pageVCs.count - 1
        }
        
        setViewControllers([pageVCs[previousPage]], direction: .reverse, animated: true) { [weak self] value in
            Swift.debugPrint(#fileID, #function, #line, "- value: \(value)")
            guard let self = self else { return }
            self.currentIndex = previousPage
            self.currentPageChanged?(previousPage)
        }
    }
}

// MARK: - UIPageViewControllerDataSource

extension MyOnboardingPageVC: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        let currentPageIndex = pageVCs.firstIndex(of: viewController as! SimpleVC) ?? 0
        
        // if currentPageIndex == 0 { return nil }
        if currentPageIndex == 0 {
            return pageVCs[pageVCs.count - 1]
        }

        return pageVCs[currentPageIndex - 1]
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        let currentPageIndex = pageVCs.firstIndex(of: viewController as! SimpleVC) ?? 0
        
        // if currentPageIndex == pageVCs.count - 1 { return nil }
        if currentPageIndex == pageVCs.count - 1 {
            return pageVCs[0]
        }
        
        return pageVCs[currentPageIndex + 1]
    }
}

// MARK: - UIPageViewControllerDelegate

extension MyOnboardingPageVC: UIPageViewControllerDelegate {
    
    func pageViewController(_ pageViewController: UIPageViewController, willTransitionTo pendingViewControllers: [UIViewController]) {
        
        guard let firstVC = pendingViewControllers.first else { return }
        
        tempCurrentIndex = pageVCs.firstIndex(of: firstVC as! SimpleVC)
        
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
        if !completed { return }
        
        currentIndex = tempCurrentIndex
        if let currentIndex = currentIndex {
            currentPageChanged?(currentIndex)
        }
    }
}
 
