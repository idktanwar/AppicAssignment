//
//  FilterViewController.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit

class FilterViewController: UIViewController {

    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnBrand: UIButton!
    @IBOutlet weak var companyName: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnClear: UIButton!
    
    var index = 0
    var companyname = ["CITY CENTRE COMMERCIAL CO.KSC", "PHARMA ZONE GENERAL CO"]
    let filterCategory = ["Select Account Number", "Select Brand",  "Select Locations"]
    
    //TODO: REMOVE
    let accountCount = 0
    let brandCount = 0
    let locationCount = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apply Filter"
        setupUI()
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        tblView.reloadData()
        
    }
    
    private func setupUI() {
        self.applyView.layer.cornerRadius = 10
        
        self.companyName.layer.cornerRadius = 8
        self.companyName.setTitle(companyname[index] , for: .normal)
        companyName.sizeToFit()
        
        btnAccount.setTitle("Acc No.: \(accountCount)", for: .normal)
        btnAccount.layer.cornerRadius = 5
        
        btnBrand.setTitle("Brand : \(accountCount)", for: .normal)
        btnBrand.layer.cornerRadius = 5
        
        btnLocation.setTitle("Location : \(accountCount)", for: .normal)
        btnLocation.layer.cornerRadius = 5
        
        
        btnBrand.sizeToFit()
        btnBrand.addLeftPadding(10)
        btnLocation.sizeToFit()
        btnLocation.addLeftPadding(10)
        btnAccount.sizeToFit()
        btnAccount.addLeftPadding(10)
    }
    
    @IBAction func clearAllFilter(_ sender: Any) {
        
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "maincell", for: indexPath) as! FilterMainCell
        
        cell.lblFilterName.text = filterCategory[indexPath.row]
        cell.lblFilterCount.text = "0"
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}
