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
    var filterMerchantData: MerchantData?
    
    //TODO: REMOVE
    var accountCount = 0 {
        didSet {
            btnAccount.setTitle("A/C No.: \(accountCount)", for: .normal)
        }
    }
    var brandCount = 0 {
        didSet {
            btnBrand.setTitle("Brand : \(brandCount)", for: .normal)
        }
    }
    var locationCount = 0 {
        didSet {
            btnLocation.setTitle("A/C No.: \(locationCount)", for: .normal)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Apply Filter"
        setupUI()
        
        tblView.rowHeight = UITableView.automaticDimension
        tblView.delegate = self
        tblView.dataSource = self
        tblView.tableFooterView = UIView()
        fetchData()
    }
    
    private func setupUI() {
        self.applyView.layer.cornerRadius = 10
        
        self.companyName.layer.cornerRadius = 8
        self.companyName.setTitle(companyname[index] , for: .normal)
        companyName.sizeToFit()
        
        btnAccount.layer.cornerRadius = 5
        btnBrand.layer.cornerRadius = 5
        btnLocation.layer.cornerRadius = 5
        
        btnBrand.sizeToFit()
        btnBrand.addLeftPadding(10)
        btnLocation.sizeToFit()
        btnLocation.addLeftPadding(10)
        btnAccount.sizeToFit()
        btnAccount.addLeftPadding(10)
    }
    
    func fetchData() {
        if let path = Bundle.main.path(forResource: "testjson", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                filterMerchantData = try JSONDecoder().decode(MerchantData.self, from: data)
                tblView.reloadData()
              } catch {
                    print("Failed to decode")
              }
        }
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
        if indexPath.row == 0 {
            let count = filterMerchantData?.filterData[index].accountList.count
            accountCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }else if indexPath.row == 1 {
            let count = filterMerchantData?.filterData[index].brandList.count
            brandCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }else {
            let count = filterMerchantData?.filterData[index].locationList.count
            locationCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}
