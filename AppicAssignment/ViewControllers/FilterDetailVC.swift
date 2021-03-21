//
//  FilterDetailVC.swift
//  AppicAssignment
//
//  Created by Dinesh Tanwar on 20/03/21.
//

import UIKit

protocol FilterDetailDelegate:class {
    func applyFilterToMain()
}

class FilterDetailVC: UIViewController {
    
    //MARK:- Property
    @IBOutlet weak var tblView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var applyView: UIView!
    
    weak var delegate: FilterDetailDelegate?

    
    var listItems:[String] = []
    var selectedItemsIndices:[IndexPath] = []
    var CategorySelected = 0
    
    //MARK:- LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tblView.delegate = self
        tblView.dataSource = self
        tblView.rowHeight = UITableView.automaticDimension
        tblView.tableFooterView = UIView()
        tblView.reloadData()
    }
    
    //MARK:-Methods
    func setupUI() {
        self.navigationItem.hidesBackButton = true
    }
    
    //MARK:- Selectors
    @IBAction func clearAllFilter(_ sender: Any) {
        //        for index in self.selectedItemsIndices {
        //            let cell = tblView.cellForRow(at: index) as! FilterDetailCell
        //            cell.btnSelected.setImage(UIImage(named: "unselected"), for: .normal)
        //        }
        //        self.selectedItemsIndices.removeAll()
    }
    
    @IBAction func selectedAllOption(_ sender: Any) {
        
    }
}

//MARK:- Tableview Delegate / Datasource
extension FilterDetailVC: UITableViewDataSource, UITableViewDelegate {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "detailcell", for: indexPath) as! FilterDetailCell
        self.selectedItemsIndices.append(indexPath)
        cell.lblSearchItem.text = listItems[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath) as! FilterDetailCell
        if self.selectedItemsIndices.contains(indexPath) {
            self.selectedItemsIndices.remove(at: self.selectedItemsIndices.firstIndex{$0 == indexPath}!)
            cell.btnSelected.setImage(UIImage(named: "unselected"), for: .normal)
        }else {
            self.selectedItemsIndices.append(indexPath)
            cell.btnSelected.setImage(UIImage(named: "selected"), for: .normal)
        }
        
    }
}

//MARK:-  touch delegate
extension FilterDetailVC {
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let touch = touches.first {
            if touch.view ==  applyView {
                UserDefaults.standard.setValue(true, forKey: APPLY_STRING)

                var filteredData = Constant.APP_DELEGATE.filteredMerchantData
                
                if CategorySelected == 0 {
                    //account selcted
                    let accountModel = filteredData!.accountList
                    var selectedItem = [String]()
                
                    for index in selectedItemsIndices {
                        let item = listItems[index.row]
                        _ = accountModel.filter({ (acc) -> Bool in
                            if acc == item {
                                selectedItem.append(acc)
                                return true
                            }else {
                                return false
                            }
                        })
                    }
                
                    filteredData?.accountList = selectedItem
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                    
                    //now filter the hierarchy
                    let hierarchyData = filteredData?.hierarchy
                    var hierarchyData1 = [Hierarchy]()
                    selectedItem.forEach { (accNo) in
                        _ = hierarchyData?.filter({ (data) -> Bool in
                            if data.accountNumber == accNo {
                                hierarchyData1.append(data)
                                return true
                            }
                            return false
                        })
                    }
                    
                    filteredData?.hierarchy = hierarchyData1
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                    
                }
                else if CategorySelected == 1 {
                    //for brandList filter
                    let brandModel = filteredData!.brandList
                    var selectedItem = [String]()
                
                    for index in selectedItemsIndices {
                        let item = listItems[index.row]
                        _ = brandModel.filter({ (brand) -> Bool in
                            if brand == item {
                                selectedItem.append(brand)
                                return true
                            }else {
                                return false
                            }
                        })
                    }
                
                    filteredData?.brandList = selectedItem
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                    
                    //now filter the hierarchy
                    let hierarchyData = filteredData?.hierarchy
                    
                    var hierarchyData1 = [Hierarchy]()
                    
                    hierarchyData?.forEach({ (data) in
                        var hierarchy = data
                        let brandList = data.brandNameList
                        var brandList1 = [BrandNameList]()
                        selectedItem.forEach { (brand) in
                            _ = brandList.filter { (brand1) -> Bool in
                                if brand1.brandName == brand {
                                    brandList1.append(brand1)
                                    return true
                                }
                                else {
                                    return false
                                }
                            }
                           
                        }
                        hierarchy.brandNameList = brandList1
                        hierarchyData1.append(hierarchy)
                    })
                    
                    filteredData?.hierarchy = hierarchyData1
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                    
                }
                else {
                    //for location filter
                    let locationModel = filteredData!.locationList
                    var selectedItem = [String]()
                
                    for index in selectedItemsIndices {
                        let item = listItems[index.row]
                        _ = locationModel.filter({ (location) -> Bool in
                            if location == item {
                                selectedItem.append(location)
                                return true
                            }else {
                                return false
                            }
                        })
                    }
                
                    filteredData?.locationList = selectedItem
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                    
                    //now filter the hierarchy
                    let hierarchyData = filteredData?.hierarchy
                    
                    var hierarchyData1 = [Hierarchy]()
                    
                    hierarchyData?.forEach({ (data) in
                        var hierarchy = data
                        let brandList = data.brandNameList
                        var brandListFiltered = [BrandNameList]()
                        
                        brandList.forEach { (brand1) in
                            var filterBrandItem = brand1
                            let locationList1 = brand1.locationNameList
                            var filterLocationList = [LocationNameList]()
                            selectedItem.forEach { (itemLocation) in
                                locationList1.forEach { (location) in
                                    if location.locationName == itemLocation {
                                        filterLocationList.append(location)
                                    }
                                }
                            }
                            filterBrandItem.locationNameList = filterLocationList
                            brandListFiltered.append(filterBrandItem)
                        }
                        
                        hierarchy.brandNameList = brandListFiltered
                        hierarchyData1.append(hierarchy)
                        
                    })
                    
                    filteredData?.hierarchy = hierarchyData1
                    Constant.APP_DELEGATE.filteredMerchantData = filteredData
                }
                
                if (delegate != nil) {
                    self.delegate?.applyFilterToMain()
                }
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}
