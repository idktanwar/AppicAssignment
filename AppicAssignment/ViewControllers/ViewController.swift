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
            self?.showFilterList(for: (String(describing: self?.items[indexPath])))
        }
        self.navigationItem.titleView = menuView

    }
    
    func showFilterList(for company: String) {
        print("Present filter option")
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.companyname = company
        
        let navigationController = UINavigationController(rootViewController: vc)
        
         // Present View "Modally"
        self.present(navigationController, animated: true, completion: nil)
    }
    
    
}

