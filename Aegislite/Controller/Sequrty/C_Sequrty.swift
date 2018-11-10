//
//  C_Sequrty.swift
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

class C_Sequrty: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate  {

    
    @IBOutlet weak var floaty: Floaty!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    
    var Sequrty = [M_Sequrty]()
    var filterData = [M_Sequrty]()
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var isSearching = false
    var choose: Int = 0
    var tokens: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
             self.navigationController?.navigationBar.topItem?.title = ""
        
        tokens = appDelegate.token
    
        floaty.addItem("Add Sequrty", icon: UIImage(named: "ma.png")!, handler: { item in
            self.appDelegate.token = self.tokens
            self.performSegue(withIdentifier: "id_seg_add", sender: self)
        })
        
        self.view.addSubview(floaty)
        TableView.delegate = self
        TableView.dataSource = self
        searchBar.delegate = self
        loadData()
        searchBar.returnKeyType = UIReturnKeyType.done
        DispatchQueue.main.async {
            self.TableView.reloadData()
        }
        
        
    }
    
    func loadData(){
        
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]

        Alamofire.request("http://devcctv.sugihartdigital.id/api/security/get", method: .post, headers: headers).responseJSON { response in

            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["data"].arrayValue {
                            self.Sequrty.append(M_Sequrty(id_sequrty : item["id"].intValue,
                                                          image_sequrty: "",
                                                          occupation: item["occupation"].stringValue,
                                                          active: item["active"].stringValue,
                                                          name_sequrty: item["name"].stringValue,
                                                          phone_sequrty: item["phone"].stringValue,
                                                          created_at: item["created_at"].stringValue,
                                                          updated_at: item["updated_at"].stringValue
                            ))
                }
                
                DispatchQueue.main.async {
                    self.TableView.reloadData()
                }
                
            case .failure(let error):
                print(error)
            }

        }
    }
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isSearching){
            return filterData.count
        }
        return Sequrty.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "id_row_sequrty") as! A_Sequrty_Row
        
        if(isSearching){
            cell.name_sequrty.text = filterData[indexPath.row].name_sequrty
            cell.phone_sequrty.text = filterData[indexPath.row].phone_sequrty
            cell.ocouption_sequrty.text = filterData[indexPath.row].occupation
            cell.image_sequrty.sd_setImage(with: URL(string: (filterData[indexPath.row].image_sequrty)), placeholderImage: UIImage(named: "lp.png"))
        }else{
            cell.name_sequrty.text = Sequrty[indexPath.row].name_sequrty
            cell.phone_sequrty.text = Sequrty[indexPath.row].phone_sequrty
            cell.ocouption_sequrty.text = Sequrty[indexPath.row].occupation
            cell.image_sequrty.sd_setImage(with: URL(string: (Sequrty[indexPath.row].image_sequrty)), placeholderImage: UIImage(named: "lp.png"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isSearching){
            appDelegate.id_streaming = filterData[indexPath.row].id_sequrty
            appDelegate.name_streaming = filterData[indexPath.row].name_sequrty
            appDelegate.type = filterData[indexPath.row].phone_sequrty
            appDelegate.occupation = filterData[indexPath.row].occupation
            choose = filterData[indexPath.row].id_sequrty
        }else{
            appDelegate.id_streaming = Sequrty[indexPath.row].id_sequrty
            appDelegate.name_streaming = Sequrty[indexPath.row].name_sequrty
            appDelegate.type = Sequrty[indexPath.row].phone_sequrty
            appDelegate.occupation = Sequrty[indexPath.row].occupation
            choose = Sequrty[indexPath.row].id_sequrty
        }
            self.performSegue(withIdentifier: "id_seg_sequrty", sender: self)
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
            filterData = Sequrty.filter({$0.phone_sequrty.localizedCaseInsensitiveContains(searchBar.text!)})
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
