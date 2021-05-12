//
//  OOP
//
//  Created by Admin on 13.03.2021.
//  Copyright © 2021 Ivan Budovich. All rights reserved.
//

import UIKit

protocol Presentable: UIViewController {
    func configure()
    var customTransitionDelegate: ModalDelegate {get}
}

extension Presentable{
    func configure()  {
        modalPresentationStyle = .custom
        transitioningDelegate = customTransitionDelegate
    }
}

class ModalDelegate: NSObject, UIViewControllerTransitioningDelegate {
    func presentationController(forPresented presented: UIViewController, presenting: UIViewController?, source: UIViewController) -> UIPresentationController? {
        return PresentationController(presentedViewController: presented, presenting: presenting)
    }
    
}

class PresentationController: UIPresentationController {
    let dimmingView: UIView = {
        let dimmingView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        dimmingView.translatesAutoresizingMaskIntoConstraints = false
        return dimmingView
    }()
    override func presentationTransitionWillBegin() {
        super.presentationTransitionWillBegin()
        
        let superView = presentingViewController.view!
        superView.addSubview(dimmingView)
        NSLayoutConstraint.activate([dimmingView.leadingAnchor.constraint(equalTo: superView.leadingAnchor), dimmingView.trailingAnchor.constraint(equalTo: superView.trailingAnchor), dimmingView.bottomAnchor.constraint(equalTo: superView.bottomAnchor), dimmingView.topAnchor.constraint(equalTo: superView.topAnchor)])
        dimmingView.alpha = 1
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {_ in self.dimmingView.alpha = 1}, completion: nil)
        
    }
    
    
    override func dismissalTransitionWillBegin() {
        super.dismissalTransitionWillBegin()
        presentedViewController.transitionCoordinator?.animate(alongsideTransition: {_ in self.dimmingView.alpha = 0}, completion: {_ in self.dimmingView.removeFromSuperview()})
        
    }
    
    override var frameOfPresentedViewInContainerView: CGRect{
        let bounds = presentingViewController.view.bounds
        let size = CGSize(width: UIScreen.main.bounds.size.width, height: 375)
        let origin = CGPoint(x: 0, y: bounds.maxY - size.height + 25)
        return CGRect(origin: origin, size: size)
    }
    
    override init(presentedViewController: UIViewController, presenting presentingViewController: UIViewController?) {
        super.init(presentedViewController: presentedViewController, presenting: presentingViewController)
        presentedView?.autoresizingMask = [.flexibleTopMargin, .flexibleBottomMargin, .flexibleLeftMargin, .flexibleRightMargin]
        presentedView?.translatesAutoresizingMaskIntoConstraints = true
    }
    
}
