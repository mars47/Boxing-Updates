//
//  ContainerVC.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import UIKit

@objc
protocol Withdrawable {
    
    @objc optional func toggleLeftPanel()
    @objc optional func collapseSidePanels()
}

protocol Navigatable {
    
    var navigationController : UINavigationController { get }
    var delegate: ContainerVC { get }
    var mainStoryboard: UIStoryboard { get }
}

class ContainerVC: UIViewController {

    enum SlideOutState {
        
        case bothCollapsed
        case leftPanelExpanded
        case rightPanelExpanded
    }
    
    var navigationPanel: NavigationPanelVC?
    let centerPanelExpandedOffset: CGFloat = 60
    var centerNavigationController: UINavigationController!
    var newsFeedVC: NewsFeedVC!
    var currentState: SlideOutState = .bothCollapsed {
        didSet {
            let shouldShowShadow = currentState != .bothCollapsed
            showShadowForCenterViewController(shouldShowShadow)
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        newsFeedVC = UIStoryboard.newsFeedVC()
        newsFeedVC.containerVC = self
        newsFeedVC.navigationBar.largeTitleDisplayMode = .always
        newsFeedVC.centerNavigationController = centerNavigationController
        
        // wrap the centerViewController in a navigation controller, so we can push views to it
        // and display bar button items in the navigation bar
        
        /* viewControllers = [vc1, vc2, vc3].map{UINavigationController(rootViewController: $0)}
         http://swiftdeveloperblog.com/code-examples/create-uitabbarcontroller-programmatically/ */
        
        centerNavigationController = UINavigationController(rootViewController: newsFeedVC)
        view.addSubview(centerNavigationController.view)
        addChild(centerNavigationController)
        centerNavigationController.didMove(toParent: self)
//        let panGestureRecognizer = UIPanGestureRecognizer(target: self, action: #selector(handlePanGesture(_:)))
//        centerNavigationController.view.addGestureRecognizer(panGestureRecognizer)
    }
}

private extension UIStoryboard {
    
    static func mainStoryboard() -> UIStoryboard { return UIStoryboard(name: "Main", bundle: Bundle.main) }
    
    static func navigationPanel() -> NavigationPanelVC? {
        return mainStoryboard().instantiateViewController(withIdentifier: "NavigationPanelVC") as? NavigationPanelVC
    }

    static func newsFeedVC() -> NewsFeedVC? {
        
      return mainStoryboard().instantiateViewController(withIdentifier: "NewsFeed") as? NewsFeedVC
    }
}

// MARK: CenterViewController delegate

extension ContainerVC: Withdrawable {
    
    func toggleLeftPanel() {
        let notAlreadyExpanded = (currentState != .leftPanelExpanded)
        
        if notAlreadyExpanded {
            addLeftPanelViewController()
        }
        
        animateLeftPanel(shouldExpand: notAlreadyExpanded)
    }
    
    func collapseSidePanels() {
        
        switch currentState {
        case .rightPanelExpanded:
            print("Do nothing")  // toggleRightPanel()
        case .leftPanelExpanded:
            toggleLeftPanel()
        default:
            break
        }
    }
    
    func addLeftPanelViewController() {
        guard navigationPanel == nil else { return }
        
        if let vc = UIStoryboard.navigationPanel() {
            vc.mainStoryboard = UIStoryboard.mainStoryboard()
            vc.centerNavigationController = centerNavigationController
            vc.containerVC = self
            
            addChildSidePanelController(vc)
            navigationPanel = vc
        }
    }

    func animateLeftPanel(shouldExpand: Bool) {
        
        //   This method simply checks whether it’s been told to expand or collapse the side panel. If it should expand, then it sets the current state to indicate the left panel is expanded, and then animates the center panel so it’s open. Otherwise, it animates the center panel closed and then removes its view and sets the current state to indicate it’s closed.
        
        if shouldExpand {
            currentState = .leftPanelExpanded
            animateCenterPanelXPosition(
                targetPosition: centerNavigationController.view.frame.width - centerPanelExpandedOffset)
            
        } else {
            animateCenterPanelXPosition(targetPosition: 0) { finished in
                self.currentState = .bothCollapsed
                self.navigationPanel?.view.removeFromSuperview()
                self.navigationPanel = nil
            }
        }
    }
    
    func animateCenterPanelXPosition(targetPosition: CGFloat, completion: ((Bool) -> Void)? = nil) {
        
        //This is where the actual animation happens. The center view controller’s view is animated to the specified position, with a nice spring animation. The method also takes an optional completion closure, which it passes on to the UIView animation.
        
        UIView.animate(withDuration: 0.5,
                       delay: 0,
                       usingSpringWithDamping: 0.8,
                       initialSpringVelocity: 0,
                       options: .curveEaseInOut, animations: {
                        self.centerNavigationController.view.frame.origin.x = targetPosition
        }, completion: completion)
    }
    
    func showShadowForCenterViewController(_ shouldShowShadow: Bool) {
        
        if shouldShowShadow {
            centerNavigationController.view.layer.shadowOpacity = 0.8
           // centerNavigationController.view.layer.shadowColor = red247.cgColor

        } else {
            centerNavigationController.view.layer.shadowOpacity = 0.0
        }
    }
    
    func addChildSidePanelController(_ sidePanelController: NavigationPanelVC) {
        // n addition to what it was doing previously, the method will now set the center view controller as the side panels’ delegate.
        sidePanelController.containerVC = self
        view.insertSubview(sidePanelController.view, at: 0)
        
        addChild(sidePanelController)
        sidePanelController.didMove(toParent: self)
        //reverted 
    }
}
