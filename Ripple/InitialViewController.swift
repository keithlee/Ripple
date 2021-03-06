//
//  PageViewController.swift
//  Ripple
//
//  Created by Keith Lee on 12/22/16.
//  Copyright © 2016 Keith Lee. All rights reserved.
//

import UIKit
import RippleKit

class InitialViewController: UIViewController {

    var pageViewController: UIPageViewController!
    let healthManager:HealthManager = HealthManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        healthManager.authorizeHealthKit { (success, error: Error?) in
            if let error = error {
                let alertController = UIAlertController.init(title: "error", message: error.localizedDescription, preferredStyle: .alert)
                let OKAction = UIAlertAction(title: "OK", style: .default) { (action) in
                    // dismiss by default
                }
                alertController.addAction(OKAction)
                self.present(alertController, animated: true, completion: nil)
            }
        }
        
        self.pageViewController = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "PageViewController") as! UIPageViewController
        self.pageViewController.dataSource = self
        updateTheme()
        
        if let firstViewController = orderedViewControllers.first {
            self.pageViewController.setViewControllers([firstViewController], direction: .forward, animated: true, completion: nil)
        }
        
        self.pageViewController.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.size.width, height: self.view.frame.size.height)
        
        self.addChildViewController(self.pageViewController)
        self.view.addSubview(self.pageViewController.view)
        self.pageViewController.didMove(toParentViewController: self)
        
        NotificationCenter.default.addObserver(self, selector: #selector(updateTheme), name: Notification.Name(nightThemeChangedNotificationId), object: nil)

    }
    
    func updateTheme() {
        self.pageViewController.view.backgroundColor = (UserDefaults.ripple?.bool(forKey: nightThemeKey) ?? false) ? UIColor.rippleNight : UIColor.rippleGrey
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    fileprivate(set) lazy var orderedViewControllers: [UIViewController] = {
        return [
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "AppViewController"),
            UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SettingsViewController"),
        ]
    }()
}

extension InitialViewController: UIPageViewControllerDataSource {
    
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let previousIndex = index - 1
        guard previousIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > previousIndex else {
            return nil
        }
        
        return orderedViewControllers[previousIndex]
    }
    func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
        
        guard let index = orderedViewControllers.index(of: viewController) else {
            return nil
        }
        let nextIndex = index + 1
        guard nextIndex >= 0 else {
            return nil
        }
        guard orderedViewControllers.count > nextIndex else {
            return nil
        }
        
        return orderedViewControllers[nextIndex]
    }
}
