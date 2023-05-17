//
//  SimpleViewController.swift
//  PageVCTutorial
//
//  Created by 조기열 on 2023/05/03.
//

import UIKit

extension Notification.Name {
    static let onTapped = Notification.Name("onTapped")
}

class SimpleVC: UIViewController {

    @IBOutlet weak var titleLabel: UILabel!
    
    var index: Int = 0
    var onTapped: ((Int) -> Void)? = nil
    
    init?(coder: NSCoder, index: Int) {
        super.init(coder: coder)
        self.index = index
        Swift.debugPrint(#fileID, #function, #line, "- index: \(index)")
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        Swift.debugPrint(#fileID, #function, #line, "- ")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Swift.debugPrint(#fileID, #function, #line, "- ")
        titleLabel.text = "index: \(index )"
        view.backgroundColor = UIColor.random
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(handleTapped)))
    }
    
    @objc
    fileprivate func handleTapped(_ sender: UITapGestureRecognizer) {
        NotificationCenter.default.post(name: .onTapped, object: self)
    }
}

extension SimpleVC {
    
    class func simpleVC(index: Int) -> SimpleVC {
        let storyboard = UIStoryboard(name: "SimpleVC", bundle: .main)
        let VC = storyboard.instantiateInitialViewController { coder in
            SimpleVC(coder: coder, index: index)
        }
        return VC!
    }
}
