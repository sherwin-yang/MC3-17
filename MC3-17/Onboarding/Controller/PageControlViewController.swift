//
//  PageControlViewController.swift
//  MC3-17
//
//  Created by Intan Yoshana on 02/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import UIKit

class PageControlViewController: UIPageViewController, UIPageViewControllerDelegate, UIPageViewControllerDataSource {

    
    lazy var orderedVC: [UIViewController] = {
        return [self.newVC(viewController: "screenOne"),
                self.newVC(viewController: "screenTwo"),
                self.newVC(viewController: "screenThree")
        ]
    }()
    
    var pageControl = UIPageControl()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.dataSource = self
        self.delegate = self
        
        if let firstVC = orderedVC.first {
            setViewControllers([firstVC], direction: .forward, animated: false, completion: nil)
        }
        
        configurePageControl()
    }
    
    func pageViewController(_ pageViewController: UIPageViewController, didFinishAnimating finished: Bool, previousViewControllers: [UIViewController], transitionCompleted completed: Bool) {
           let pageContentVC = pageViewController.viewControllers![0]
           self.pageControl.currentPage = orderedVC.firstIndex(of: pageContentVC)!
       }
       
       func configurePageControl() {
           pageControl = UIPageControl(frame: CGRect(x: 0, y: UIScreen.main.bounds.maxY - 234, width: UIScreen.main.bounds.width, height: 50))
           pageControl.numberOfPages = orderedVC.count
           pageControl.currentPage = 0
           pageControl.pageIndicatorTintColor = #colorLiteral(red: 0.8039215803, green: 0.8039215803, blue: 0.8039215803, alpha: 1)
           pageControl.currentPageIndicatorTintColor = .black
           self.view.addSubview(pageControl)
       }
       

       func newVC(viewController: String) -> UIViewController {
           return UIStoryboard(name: "Onboarding", bundle: nil).instantiateViewController(identifier: viewController)
       }
       
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerBefore viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedVC.firstIndex(of: viewController) else {
               return nil
           }
           
           let  previousIndex = viewControllerIndex - 1
           
           guard previousIndex >= 0 else {
               return nil
           }
           
           guard orderedVC.count > previousIndex else{
               return nil
           }
           
           return orderedVC[previousIndex]
       }
       
       func pageViewController(_ pageViewController: UIPageViewController, viewControllerAfter viewController: UIViewController) -> UIViewController? {
           guard let viewControllerIndex = orderedVC.firstIndex(of: viewController) else {
               return nil
           }
           
           let  nextIndex = viewControllerIndex + 1
           
           guard orderedVC.count > nextIndex else {
               return nil
           }
           
           guard orderedVC.count > nextIndex else {
               return nil
           }
           
           return orderedVC[nextIndex]
       }
    
}
