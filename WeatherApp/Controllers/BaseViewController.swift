//
//  BaseViewController.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/21/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit

class BaseViewController: UIViewController {

    var sideMenuOverlay: UIView?
    var swipeGesture: UISwipeGestureRecognizer?
    var navController: NavigationController?
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navController = self.navigationController as? NavigationController
        addSideMenuNavigationButton()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    //MARK: - HamburgerMenu Helpers
    
    /*------------------------------------------------------------------
     *  Function Name   :   addSideMenuNavigationButton
     *  Purpose         :   Adds hamburger menu button in navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func addSideMenuNavigationButton() {
        let hamburgerButton = UIBarButtonItem(image: UIImage(named: "hamburgerIcon"), style: .plain, target:self, action: #selector(toggleSideMenu))
        hamburgerButton.tintColor = UIColor.white
        self.navigationItem.leftBarButtonItem = hamburgerButton
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   toggleSideMenu
     *  Purpose         :   hide or show the side menu based on current state
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func toggleSideMenu() {
        self.view.endEditing(true)
        if self.isSideMenuOpen() {
            self.hideSideMenu()
            
        } else {
            self.addGestureOverlayForCurrentView()
            self.showSideMenu()
        }
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   isSideMenuOpen
     *  Purpose         :   decides whether the side menu is open
     *  Parameters      :   None
     *  Return Value    :   a bool that indicates whether the side menu is open or not
     ------------------------------------------------------------------*/
    func isSideMenuOpen() -> Bool {
        let frame = self.navigationController?.view.frame
        if frame?.origin.x != 0 {
            return true
        }
        return false
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   hideSideMenu
     *  Purpose         :   hides side menu with animation
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func hideSideMenu() {
        self.sideMenuOverlay?.removeFromSuperview()
        UIView.animate(withDuration: 0.6) { () -> Void in
            if let navController = self.navigationController {
                var frame = navController.view.frame
                frame.origin.x = 0
                navController.view.frame = frame
            }
        }
        if let gesture = swipeGesture {
            self.navigationController?.view.removeGestureRecognizer(gesture)
        }
        
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   showSideMenu
     *  Purpose         :   opens side menu with animation
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func showSideMenu() {
        
        UIView.animate(withDuration: 0.5) { () -> Void in
            if let navController = self.navigationController {
                var frame = navController.view.frame
                frame.origin.x += 280
                navController.view.frame = frame
            }
        }
        NotificationCenter.default
            .post(name: NSNotification.Name(
                rawValue: "SideMenuDidOpen"), object: nil)
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   addGestureOverlayForCurrentView
     *  Purpose         :   adds swipe and tap gestures to the right view
     *                      when side menu is open
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func addGestureOverlayForCurrentView() {
        if self.sideMenuOverlay == nil {
            self.sideMenuOverlay = UIView(frame: self.view.bounds)
            let tapGestureDismiss = UITapGestureRecognizer(target: self, action: #selector(hideSideMenu))
            self.sideMenuOverlay!.addGestureRecognizer(tapGestureDismiss)
            self.swipeGesture = UISwipeGestureRecognizer(
                target: self, action: #selector(hideSideMenu))
            self.swipeGesture!.direction = .left
            self.sideMenuOverlay?.addGestureRecognizer(self.swipeGesture!)
        }
        self.view.addSubview(self.sideMenuOverlay!)
    }


    func pause() {
        activityIndicator = UIActivityIndicatorView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
    }
    func restore() {
        activityIndicator.stopAnimating()
        UIApplication.shared.endIgnoringInteractionEvents()
    }
}
