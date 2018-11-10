//
//  C_Contact.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 05/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog

class C_Contact: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var floaty: Floaty!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var Contact = [M_Contact]()
    var filterData = [M_Contact]()
    
    var isSearching = false
    var choose: Int = 0
    var tokens: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tokens = appDelegate.token
        floaty.addItem("Add Contact", icon: UIImage(named: "ma.png")!, handler: { item in
            self.appDelegate.token = self.tokens
            self.performSegue(withIdentifier: "id_seg_Add", sender: self)
        })
        
        self.view.addSubview(floaty)
        // Do any additional setup after loading the view.
        
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        
        
        TableView.delegate = self
        TableView.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        loadContact()
        DispatchQueue.main.async {
            self.TableView.reloadData()
        }
    }
    
    
    func loadContact(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://devcctv.sugihartdigital.id/api/partnerlist", method: .post, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["data"].arrayValue {
                    self.Contact.append(M_Contact(id : item["id"].intValue,
                                             name: item["name"].stringValue,
                                             occupation: item["occupation"].stringValue,
                                             address:item["address"].stringValue,
                                             phone: item["phone"].stringValue,
                                             created_at: item["created_at"].stringValue,
                                             updated_at: item["updated_at"].stringValue,
                                             photo: item["photo"].stringValue
                    ))
                    
                    
                    DispatchQueue.main.async {
                        self.TableView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
                self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 170.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching){
            return filterData.count
        }
        return Contact.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cellrows") as! A_Contact_Cell
        if(isSearching){
            cell.Name_Contact.text = filterData[indexPath.row].name
            cell.Phone_Contact.text = filterData[indexPath.row].phone
            cell.Ocouption_Contact.text = filterData[indexPath.row].occupation
            cell.Address_Contact.text = filterData[indexPath.row].address
            cell.Image_Contact.sd_setImage(with: URL(string: (filterData[indexPath.row].photo)), placeholderImage: UIImage(named: "lp.png"))
        }else{
            cell.Name_Contact.text = Contact[indexPath.row].name
            cell.Phone_Contact.text = Contact[indexPath.row].phone
            cell.Ocouption_Contact.text = Contact[indexPath.row].occupation
            cell.Address_Contact.text = Contact[indexPath.row].address
            cell.Image_Contact.sd_setImage(with: URL(string: (Contact[indexPath.row].photo)), placeholderImage: UIImage(named: "lp.png"))
        }
        
        return cell
    }

    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isSearching){
            appDelegate.id_streaming = filterData[indexPath.row].id
            appDelegate.name = filterData[indexPath.row].name
            appDelegate.occupation = filterData[indexPath.row].occupation
            appDelegate.address = filterData[indexPath.row].address
            appDelegate.phone = filterData[indexPath.row].phone
            appDelegate.created_at = filterData[indexPath.row].created_at
            appDelegate.updated_at = filterData[indexPath.row].updated_at
            appDelegate.image = filterData[indexPath.row].photo
            
        }else{
            
            appDelegate.id_streaming = Contact[indexPath.row].id
            appDelegate.name = Contact[indexPath.row].name
            appDelegate.occupation = Contact[indexPath.row].occupation
            appDelegate.address = Contact[indexPath.row].address
            appDelegate.phone = Contact[indexPath.row].phone
            appDelegate.created_at = Contact[indexPath.row].created_at
            appDelegate.updated_at = Contact[indexPath.row].updated_at
            appDelegate.image = Contact[indexPath.row].photo
            
        }
        self.performSegue(withIdentifier: "id_seg_detailcontact", sender: self)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }else{
            isSearching = true
            filterData = Contact.filter({$0.name.localizedCaseInsensitiveContains(searchBar.text!)})
            DispatchQueue.main.async {
                self.TableView.reloadData()
            }
        }
    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
