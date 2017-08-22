//
//  NavigationController.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/21/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit

class NavigationController: UINavigationController {
    
    //MARK: - ViewLifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setDefaultNavigationBarProperties()
    }
    
    override init(rootViewController: UIViewController) {
        super.init(rootViewController: rootViewController)
    }
    
    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    
    //MARK: - NavigationBar Customisation
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationBarDefaultProperties
     *  Purpose         :   set initial set of properties required for navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func setDefaultNavigationBarProperties() {
        self.navigationBar.isTranslucent = false
        self.setNavigationBarTintColor(color: Utility.getNavBarBGColor())
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        //to set status bar style to light content
        self.navigationBar.barStyle = UIBarStyle.default
        hideNavigationBarBottomBorder()
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationTitle
     *  Purpose         :   for setting navigation title
     *  Parameters      :   navigation title as string
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func setNavigationTitle(title: String) {
        self.visibleViewController?.navigationItem.title = title
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationBarTintColor
     *  Purpose         :   for setting navigation bar tint color
     *  Parameters      :   UIColor
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func setNavigationBarTintColor(color: UIColor) {
        self.navigationBar.barTintColor  = color
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   changeBottomBorderLineColor
     *  Purpose         :   to change 1px bottom border line of navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func changeBottomBorderLineColor(color: UIColor) {
        let navigationBar = self.navigationBar
        let navBorder: UIView = UIView(frame: CGRect(x: 0, y:
            navigationBar.frame.size.height,
                                                     width: navigationBar.frame.size.width,
                                                     height: 1))
        navBorder.backgroundColor = color
        navBorder.isOpaque = true
        self.navigationBar.addSubview(navBorder)
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   hideNavigationBarBottomBorder
     *  Purpose         :   to hide 1px bottom border line of navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func hideNavigationBarBottomBorder() {
        navigationBar.setBackgroundImage(UIImage(), for: .default)
        navigationBar.shadowImage = UIImage()
    }
    
    //MARK: - Add different bar items
    
    
    
        
    /*------------------------------------------------------------------
     *  Function Name   :   createBarButton
     *  Purpose         :   creates a button using the attributes given
     *  Parameters      :   button title, button image, button tag and
     *                      position is to determine left or right barbutton.
     *                      Position: false - left bar button, true - right bar button
     *  Return Value    :   created UIButton
     ------------------------------------------------------------------*/
    public func createBarButton(titleText: String?,
                                image: UIImage?, tag: Int!, position: Bool) -> UIButton {
        
        let barButton = UIButton(frame: CGRect(x: 0, y: 0, width: 100, height: 30))
        if position {
            barButton.titleEdgeInsets.top = 0
            barButton.titleEdgeInsets.left = 0
            barButton.titleEdgeInsets.bottom = 0
            barButton.titleEdgeInsets.right = -10
            barButton.titleLabel?.textAlignment = .right
            barButton.setTitleColor(UIColor.white, for: .normal)
            
        } else {
            barButton.titleEdgeInsets.top = 0
            barButton.titleEdgeInsets.left = -40
            barButton.titleEdgeInsets.bottom = 0
            barButton.titleEdgeInsets.right = 0
        }
        
        barButton.tag = tag
        if let titleString: String = titleText {
            barButton.setTitle(titleString, for: UIControlState.normal)
        }
        if let titleImage: UIImage = image {
            barButton.setImage(titleImage, for: .normal)
        }
        barButton.frame.size.width = barButton.intrinsicContentSize.width
        return barButton
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   addCustomLeftNavigationItem
     *  Purpose         :   For adding custom left navigation item
     *  Parameters      :   customLeftBarBtnItem UIBarButtonItem object
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func addCustomLeftNavigationItem(customLeftBarBtnItem: UIBarButtonItem) {
        self.visibleViewController?.navigationItem.setHidesBackButton(true, animated: false)
        self.visibleViewController?.navigationItem.leftBarButtonItem = customLeftBarBtnItem
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   addCustomRightNavigationItems
     *  Purpose         :   For adding custom right navigation items
     *  Parameters      :   an array of right bar buttons
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    private func addCustomRightNavigationItems(barbuttonArray: Array<UIBarButtonItem>) {
        self.visibleViewController?.navigationItem.rightBarButtonItems = barbuttonArray
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationTitlewithSubTitle
     *  Purpose         :   for showing title and subtitle in navigation bar
     *  Parameters      :   title and subtitle string that need to display
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func setNavigationTitlewithSubTitle(title: String?, subtitle: String?) {
        let titleLabel = UILabel(frame: CGRect(x: 0, y: -5, width: 0, height: 0))
        titleLabel.backgroundColor = UIColor.clear
        titleLabel.textColor = UIColor.white
        titleLabel.font = UIFont.boldSystemFont(ofSize: 17)
        titleLabel.text = title
        titleLabel.sizeToFit()
        
        let subtitleLabel = UILabel(frame: CGRect(x: 0, y: 18, width: 0, height: 0))
        subtitleLabel.backgroundColor = UIColor.clear
        subtitleLabel.textColor = UIColor.white
        subtitleLabel.font = UIFont.systemFont(ofSize: 11)
        subtitleLabel.text = subtitle
        subtitleLabel.sizeToFit()
        
        let titleView = UIView(frame: CGRect(x: 0, y: 0,
                                             width: max(titleLabel.frame.size.width,
                                                        subtitleLabel.frame.size.width),
                                             height: 30))
        titleLabel.center.x = titleView.center.x
        subtitleLabel.center.x = titleView.center.x
        titleView.addSubview(titleLabel)
        titleView.addSubview(subtitleLabel)
        
        self.visibleViewController?.navigationItem.titleView = titleView
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationTitleView
     *  Purpose         :   add title and a set of subtitles in navigation bar
     *  Parameters      :   array of titles
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func setNavigationTitleView(views: Array<String>) {
        let titleView: UIView = UIView(frame: CGRect(
            x: self.view.frame.width/2-80,
            y: 20, width: 160, height: 44))
        for label: String in views {
            let titleLabel: UILabel = UILabel()
            titleLabel.text = label
            titleLabel.textColor = UIColor.white
            titleLabel.frame = CGRect(x: -10, y:22, width: 160, height: 22 )
            titleLabel.textAlignment = .center
            titleView.addSubview(titleLabel)
            
        }
        self.visibleViewController?.navigationItem.titleView = titleView
    }
    
    
    /*------------------------------------------------------------------
     *  Function Name   :   setNavigationTitleImage
     *  Purpose         :   Will set the passed image name as title image
     *  Parameters      :   imageName as String
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    
    func setNavigationTitleImage(named imageName: String) {
        
        let titleImage = UIImage(named: imageName)
        let rectSize = CGSize(width: 90, height: 20)
        // Actually do the resizing to the rect using the ImageContext stuff
        let rect = CGRect(x: 0, y: 0, width: rectSize.width, height: rectSize.height)
        UIGraphicsBeginImageContextWithOptions(rectSize, false, 2.0)
        titleImage?.draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        self.visibleViewController?.navigationItem.titleView =
            UIImageView(image: newImage)
    }
    
    //: MARK: - Button Actions
    
    func leftBarButtonAction() {
        //override this in child class as required
    }
    
    func rightBarButtonAction(sender: AnyObject) {
        //override this in child class as required
    }
    
    //: MARK: - Hide/show navigation items
    
    /*------------------------------------------------------------------
     *  Function Name   :   hideBackButton
     *  Purpose         :   For hiding the left navigation item
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func hideBackButton() {
        self.visibleViewController?.navigationItem.setHidesBackButton(true, animated: false)
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   hideRightNavigationItem
     *  Purpose         :   For hiding the Right navigation item
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func hideRightNavigationItem() {
        self.visibleViewController?.navigationItem.setRightBarButton(nil, animated: false)
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   hideNavigationBar
     *  Purpose         :   for hiding navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func hideNavigationBar() {
        self.isNavigationBarHidden = true
    }
    
    /*------------------------------------------------------------------
     *  Function Name   :   showNavigationBar
     *  Purpose         :   for unhiding navigation bar
     *  Parameters      :   None
     *  Return Value    :   None
     ------------------------------------------------------------------*/
    func showNavigationBar() {
        self.isNavigationBarHidden = false
    }
    
    //: MARK: - Popup view controllers
    func popViewController() {
        self.popViewController(animated: false)
    }
}
