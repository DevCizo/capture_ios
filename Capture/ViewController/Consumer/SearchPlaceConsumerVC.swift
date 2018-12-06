//
//  SessionConsumerVC.swift
//  Capture
//
//  Created by Hitesh Thummar on 30/11/18.
//  Copyright © 2018 Hitesh Thummar. All rights reserved.
//

import UIKit
import SkyFloatingLabelTextField
class SearchPlaceConsumerVC: UIViewController {

    @IBOutlet weak var tableview: UITableView!
    @IBOutlet weak var txtSearch: SkyFloatingLabelTextField!
    var placeArr:[NSDictionary] = []
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableview.delegate = self
        tableview.dataSource = self
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        self.tableview.rowHeight = UITableViewAutomaticDimension;

        txtSearch.delegate = self
    }

    @IBAction func btnBack(_ sender: UIButton) {
        self.navigationController?.popViewController(animated: true)
    }
}



extension SearchPlaceConsumerVC:UITableViewDataSource,UITableViewDelegate
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.placeArr.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableview.dequeueReusableCell(withIdentifier: "SearchPlaceConsumerCell", for: indexPath) as! SearchPlaceConsumerCell
        let dict = self.placeArr[indexPath.row]
        
        if let nm = dict.value(forKeyPath: "structured_formatting.main_text")
        {
            cell.lblDesc.text = "\(nm)"
        }
        return cell
    }
}

extension SearchPlaceConsumerVC:UITextFieldDelegate
{
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
       
        let text: NSString = (textField.text ?? "") as NSString
        let resultString = text.replacingCharacters(in: range, with: string)
        if resultString.count > 2
        {
                callApi(place: resultString)
        }
        return true
    }
}

//Call api
extension SearchPlaceConsumerVC
{
    func callApi(place:String)  {
        
        let apiURL = "https://maps.googleapis.com/maps/api/place/autocomplete/json?input=\(place)&key=\(GOOGLE_MAP_KEY)"
        
        APICall.call_API_ALL(url: apiURL, param: [:]) { (dict) in
            
            if let arr = dict.value(forKey: "predictions") as? [NSDictionary]
            {
                self.placeArr = arr
                self.tableview.reloadData()
            }
        }
    }
}

class SearchPlaceConsumerCell: UITableViewCell {
    
    @IBOutlet weak var lblDesc: UILabel!
    
}
