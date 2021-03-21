//
//  FilterViewController.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit


protocol ApplyMainDelegate:class {
    func applyFinalFilter(mid: [String])
}

class FilterViewController: UIViewController {
    
    @IBOutlet weak var applyView: UIView!
    @IBOutlet weak var btnAccount: UIButton!
    @IBOutlet weak var btnLocation: UIButton!
    @IBOutlet weak var btnBrand: UIButton!
    @IBOutlet weak var companyName: UIButton!
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var btnClear: UIButton!
    
    weak var delegate: ApplyMainDelegate?
    
    var index = 0  //used for selected filter on main page of navigation title
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
            btnLocation.setTitle("Locations : \(locationCount)", for: .normal)
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
        if let applied = UserDefaults.standard.value(forKey: APPLY_STRING) as? Bool {
            if  applied == false {
                if let path = Bundle.main.path(forResource: "testjson", ofType: "json") {
                    do {
                        let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
                        filterMerchantData = try JSONDecoder().decode(MerchantData.self, from: data)
                        Constant.APP_DELEGATE.filteredMerchantData = filterMerchantData?.filterData[index]
                        tblView.reloadData()
                    } catch {
                        print("Failed to decode")
                    }
                }
            }
        }
    }
    
    @IBAction func clearAllFilter(_ sender: Any) {
        UserDefaults.standard.setValue(false, forKey: APPLY_STRING)
        fetchData()
    }
}

extension FilterViewController: UITableViewDelegate, UITableViewDataSource, FilterDetailDelegate {
    
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
            let count = Constant.APP_DELEGATE.filteredMerchantData?.accountList.count
            accountCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }else if indexPath.row == 1 {
            let count = Constant.APP_DELEGATE.filteredMerchantData?.brandList.count
            brandCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }else {
            let count = Constant.APP_DELEGATE.filteredMerchantData?.locationList.count
            locationCount = count ?? 0
            cell.lblFilterCount.text = String(count ?? 0)
            
        }
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "FilterDetailVC") as! FilterDetailVC
        vc.delegate = self
        if indexPath.row == 2 {
            vc.title = "Select Locations"
            vc.listItems = Constant.APP_DELEGATE.filteredMerchantData?.locationList ?? []
            vc.CategorySelected = 2
        }
        else if indexPath.row == 1 {
            vc.title = "Select Brands"
            vc.listItems = Constant.APP_DELEGATE.filteredMerchantData?.brandList ?? []
            vc.CategorySelected = 1
            
        }else {
            vc.title = "Select Accounts"
            vc.listItems = Constant.APP_DELEGATE.filteredMerchantData?.accountList ?? []
            vc.CategorySelected = 0
            
        }
        
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 80
    }
}

extension FilterViewController{
    func applyFilterToMain() {
        tblView.reloadData()
    }
}

extension FilterViewController {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view ==  applyView {
                
                UserDefaults.standard.setValue(true, forKey: APPLY_STRING)
                
                //get the  MIDS
                var MID = [String]()
                let hierarchy = Constant.APP_DELEGATE.filteredMerchantData?.hierarchy
                
                hierarchy?.forEach({ (data) in
                    let brandList = data.brandNameList
                    
                    brandList.forEach { (brandData) in
                        let locationList = brandData.locationNameList
                        
                        locationList.forEach { (locationData) in
                            let merchantNumberList = locationData.merchantNumber
                            merchantNumberList.forEach { (merchant) in
                                MID.append(merchant.mid)
                            }
                        }
                    }
                    
                })
                
                self.dismiss(animated: true) {
                    if self.delegate != nil {
                        self.delegate?.applyFinalFilter(mid: MID)
                    }
                }
            }
        }
    }
}

