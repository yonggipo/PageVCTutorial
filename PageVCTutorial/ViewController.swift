//
//  ViewController.swift
//  PageVCTutorial
//
//  Created by 조기열 on 2023/05/03.
//

import UIKit
import Combine

class ViewController: UIViewController {
    
    enum DirectionType: Int {
        case leading   = 0
        case trailing  = 1
    }
    
    var subscriptions = Set<AnyCancellable>()
    
    @IBOutlet weak var leadingButton: UIButton!
    @IBOutlet weak var trailingButton: UIButton!
    @IBOutlet weak var onboardingContainerView: UIView!
    @IBOutlet weak var pageController: UIPageControl!
    
    var embededMyOnboardingPageVC: MyOnboardingPageVC? {
        get {
            return children.first { $0 is MyOnboardingPageVC } as? MyOnboardingPageVC
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
       
        pageController.numberOfPages = embededMyOnboardingPageVC?.pageVCs.count ?? 0
        pageController.currentPage = 0
        
        embededMyOnboardingPageVC?.currentPageChanged = { [weak self] currentPage in
            self?.pageController.currentPage = currentPage
        }
        
        [leadingButton, trailingButton].forEach { $0.addTarget(self, action: #selector(handleOnboarding), for: .touchUpInside) }
        
//        Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { [weak self] _ in
//            guard let self = self else { return }
//            embededMyOnboardingPageVC?.goNext()
//        }
        
        NotificationCenter
            .default
            .publisher(for: .onTapped)
            .compactMap { $0.object as? SimpleVC }
            .map { $0.index }
            .print("📢 noti")
            .sink { Swift.debugPrint(#fileID, #function, #line, "- index: \($0)") }
            .store(in: &subscriptions)
    }
    
    @objc
    fileprivate func handleOnboarding(_ sender: UIButton) {
        Swift.debugPrint(#fileID, #function, #line, "- sender: \(sender.tag)")
        let directionType = DirectionType(rawValue: sender.tag)
        
        switch directionType {
        case .leading:
            print("leading")
            embededMyOnboardingPageVC?.goPrevious()
        case .trailing:
            print("trailing")
            embededMyOnboardingPageVC?.goNext()
        default:
            break
        }
    }
}

