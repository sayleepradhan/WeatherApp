//
//  SideMenuViewController.swift
//  WeatherApp
//
//  Created by Saylee Pradhan on 8/21/17.
//  Copyright © 2017 Saylee Pradhan. All rights reserved.
//

import UIKit

class SideMenuViewController: BaseViewController,UITableViewDataSource, UITableViewDelegate {

    @IBOutlet weak var sideMenuTable: UITableView!

    
//    override init(nibName nibNameOrNil: String?, bundle nibBundleOrNil: Bundle?) {
//        super.init(nibName: nibNameOrNil, bundle: nibBundleOrNil)
//    }
//    
//    required init?(coder aDecoder: NSCoder) {
//        fatalError("init(coder:) has not been implemented")
//    }
    
    //MARK: - View Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        initialize()
        //addSideMenuToggleNotification()
        self.sideMenuTable.tableFooterView = UIView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let topNavigationController = self.navController {
            let frame = UIScreen.main.bounds
            topNavigationController.view.frame = frame
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func initialize() {
        self.navController?.hideNavigationBar()
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! BaseViewController
        self.navController = NavigationController(rootViewController: viewController)
        self.addChildViewController(self.navController!)
        self.view.addSubview((self.navController?.view)!)
    }
    
    //MARK: - Helper Methods
    func showNextViewController(controller: BaseViewController) {
        _ = self.navController?.popToRootViewController(animated: false)
        self.navController?.pushViewController(controller, animated: false)
        self.dismissSideMenu()
    }
    
    func dismissSideMenu() {
        UIView.animate(withDuration: 0.6) { () -> Void in
            if let navController = self.navController {
                var frame = navController.view.frame
                frame.origin.x = 0
                navController.view.frame = frame
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellId = indexPath.row == 0 ? "first" : "second"
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.row == 0 {
            loadCurrentWeather()
        } else {
            loadForecastInfo()
        }
        tableView.deselectRow(at: indexPath, animated: true)
    }
    func loadCurrentWeather() {
        let viewController = storyboard?.instantiateViewController(withIdentifier: "ViewController") as! BaseViewController
        showNextViewController(controller: viewController)
    }
    
    func loadForecastInfo() {
        let sboard = UIStoryboard(name: "Main", bundle: nil)
        let viewController = sboard.instantiateViewController(withIdentifier: "ForecastViewController") as! BaseViewController
        showNextViewController(controller: viewController)
    }
}
