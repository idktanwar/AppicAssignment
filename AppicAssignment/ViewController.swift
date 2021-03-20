//
//  ViewController.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit
import BTNavigationDropdownMenu

class ViewController: UIViewController {
    
    let items = ["CITY CENTRE COMMERCIAL CO.KSC", "PHARMA ZONE GENERAL CO"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuView = BTNavigationDropdownMenu(title: BTTitle.index(1), items: items)
        self.navigationItem.title = "\(items[0])" + "\u{2304}"
        
        menuView.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self?.navigationItem.title = "\(String(describing: self?.items[indexPath]))" + "\u{2304}"
        }
        
        self.navigationItem.titleView = menuView
        
    }
    
    
}

