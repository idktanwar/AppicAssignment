//
//  ViewController.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit
import BTNavigationDropdownMenu

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tblView: UITableView!
    
    let items = ["CITY CENTRE COMMERCIAL CO.KSC", "PHARMA ZONE GENERAL CO"]
    
    var MIDs = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let menuView = BTNavigationDropdownMenu(title: BTTitle.index(1), items: items)
        self.navigationItem.title = "\(items[0])" + "\u{2304}"
        
        menuView.didSelectItemAtIndexHandler = { [weak self] (indexPath: Int) -> () in
            print("Did select item at index: \(indexPath)")
            self?.navigationItem.title = "\(String(describing: self?.items[indexPath]))" + "\u{2304}"
            self?.showFilterList(for: (String(describing: self?.items[indexPath])), index: indexPath)
        }
        self.navigationItem.titleView = menuView

        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        tblView.reloadData()
    }
    
    func showFilterList(for company: String, index: Int) {
        print("Present filter option")
       
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as! FilterViewController
        vc.index = index
        vc.delegate = self
        
        let navigationController = UINavigationController(rootViewController: vc)
         // Present View "Modally"
        self.present(navigationController, animated: true, completion: nil)
    }
    
    //MARK:- TableView Delegate/Datasource
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return MIDs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath) as UITableViewCell
        cell.textLabel?.text = " MID: " + MIDs[indexPath.row]
        return cell
    }
  
}

extension ViewController: ApplyMainDelegate {
    func applyFinalFilter(mid: [String]) {
        self.MIDs = mid
        tblView.reloadData()
    }
}
