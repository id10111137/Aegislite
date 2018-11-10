//
//  C_User.swift
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

class C_User: UIViewController, UITableViewDataSource, UITableViewDelegate, UISearchBarDelegate  {
    


    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TableViews: UITableView!
    
    var Users = [M_User]()
    var filterData = [M_User]()
    
    @IBOutlet weak var floaty: Floaty!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isSearching = false
    var choose: Int = 0
    var tokens: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tokens = appDelegate.token
        
        floaty.addItem("Add Sequrty", icon: UIImage(named: "ma.png")!, handler: { item in
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
        
        TableViews.delegate = self
        TableViews.dataSource = self
        searchBar.delegate = self
        searchBar.returnKeyType = UIReturnKeyType.done
        loadUser()
        DispatchQueue.main.async {
            self.TableViews.reloadData()
        }
    }
    
    
    func loadUser(){

        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]

        Alamofire.request("http://devcctv.sugihartdigital.id/api/getuserlist", method: .post, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                    for item in json["data"].arrayValue {
                        self.Users.append(M_User(id : item["id"].intValue,
                                                  name: item["name"].stringValue,
                                                  username: item["username"].stringValue,
                                                  email:item["email"].stringValue,
                                                  created_at: item["created_at"].stringValue,
                                                  updated_at: item["updated_at"].stringValue,
                                                  regid: item["regid"].stringValue,
                                                  image: item["image"].stringValue,
                                                  phone: item["phone"].stringValue,
                                                  address: item["address"].stringValue,
                                                  is_admin: item["is_admin"].intValue
                        ))
                        
                        DispatchQueue.main.async {
                            self.TableViews.reloadData()
                        }
                    }
            case .failure(let error):
                print(error)
            }
            
        }
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (isSearching){
            return filterData.count
        }
        return Users.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "celluser") as! A_UserTableViewCell
        if(isSearching){
            cell.user_name.text = filterData[indexPath.row].name
            cell.user_phone.text = filterData[indexPath.row].phone
            cell.image_user.sd_setImage(with: URL(string: (filterData[indexPath.row].image)), placeholderImage: UIImage(named: "lp.png"))
        }else{
            cell.user_name.text = Users[indexPath.row].name
            cell.user_phone.text = Users[indexPath.row].phone
            cell.image_user.sd_setImage(with: URL(string: (Users[indexPath.row].image)), placeholderImage: UIImage(named: "lp.png"))
        }
       
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

        if(isSearching){
            appDelegate.id_streaming = filterData[indexPath.row].id
            appDelegate.name = filterData[indexPath.row].name
            appDelegate.username = filterData[indexPath.row].username
            appDelegate.email = filterData[indexPath.row].email
            appDelegate.created_at = filterData[indexPath.row].created_at
            appDelegate.updated_at = filterData[indexPath.row].updated_at
            appDelegate.regid = filterData[indexPath.row].regid
            appDelegate.image = filterData[indexPath.row].image
            appDelegate.phone = filterData[indexPath.row].phone
            appDelegate.address = filterData[indexPath.row].address
            appDelegate.isadmins = filterData[indexPath.row].is_admin
            
        }else{
            appDelegate.id_streaming = Users[indexPath.row].id
            appDelegate.name = Users[indexPath.row].name
            appDelegate.username = Users[indexPath.row].username
            appDelegate.email = Users[indexPath.row].email
            appDelegate.created_at = Users[indexPath.row].created_at
            appDelegate.updated_at = Users[indexPath.row].updated_at
            appDelegate.regid = Users[indexPath.row].regid
            appDelegate.image = Users[indexPath.row].image
            appDelegate.phone = Users[indexPath.row].phone
            appDelegate.address = Users[indexPath.row].address
            appDelegate.isadmins = Users[indexPath.row].is_admin
        }
        self.performSegue(withIdentifier: "id_seg_detail_user", sender: self)
    }
    
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            DispatchQueue.main.async {
                self.TableViews.reloadData()
            }
        }else{
            isSearching = true
            filterData = Users.filter({$0.phone.localizedCaseInsensitiveContains(searchBar.text!)})
            DispatchQueue.main.async {
                self.TableViews.reloadData()
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
