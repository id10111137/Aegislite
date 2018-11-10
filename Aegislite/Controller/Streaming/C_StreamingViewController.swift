//
//  C_StreamingViewController.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 06/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog

class C_StreamingViewController: UIViewController,  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
  
    
   
    @IBOutlet weak var searchbar: UISearchBar!
    @IBOutlet weak var TableView: UITableView!
    @IBOutlet weak var floaty_streaming: Floaty!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var Remote = [M_Remote]()
    var filterData = [M_Remote]()
    var isSearching = false
     var choose: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        floaty_streaming.addItem("Add Barcode", icon: UIImage(named: "br.png")!, handler: { item in
            self.performSegue(withIdentifier: "id_seg_barcode", sender: self)
        })
        floaty_streaming.addItem("Add Manual", icon: UIImage(named: "ma.png")!, handler: { item in
                        self.performSegue(withIdentifier: "id_seg_add", sender: self)
        })
        self.view.addSubview(floaty_streaming)
        TableView.delegate = self
        TableView.dataSource = self
        loadData()
        searchbar.returnKeyType = UIReturnKeyType.done
        
        
    
    }
    
    override func viewDidAppear(_ animated: Bool) {
        let nv = navigationController!
        let image = UIImage(named: "Logo")
        let ImageView = UIImageView(image: image)
        let bnw = nv.navigationBar.frame.size.width
        let bnh = nv.navigationBar.frame.size.height
        
        ImageView.frame = CGRect(x:0, y:0, width: bnw, height: bnh)
        
        ImageView.contentMode = .scaleAspectFit
        ImageView.center = nv.navigationBar.center
        navigationItem.titleView = ImageView
        
    }
    
    func loadData(){
         Remote.append(M_Remote(id_remote: 1, lamp_image: "", lamp_name: "Lamp Model Dingding",lamp_category: "Lampu",lamp_status: "ON"))
         Remote.append(M_Remote(id_remote: 2, lamp_image: "", lamp_name: "Lamp Model TAMAN",lamp_category: "Switch",lamp_status: "ON"))
         Remote.append(M_Remote(id_remote: 3, lamp_image: "", lamp_name: "Lamp Model LUAR",lamp_category: "Camera",lamp_status: "ON"))
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isSearching){
            return filterData.count
        }
        return Remote.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell") as! A_RemoteTableViewCell
        
        if(isSearching){
            cell.lamp_name.text = filterData[indexPath.row].lamp_name
            cell.lamp_category.text = filterData[indexPath.row].lamp_category
            cell.lamp_status.text = filterData[indexPath.row].lamp_status
            cell.lamp_image.sd_setImage(with: URL(string: (filterData[indexPath.row].lamp_image)), placeholderImage: UIImage(named: "lp.png"))
        }else{
            cell.lamp_name.text = Remote[indexPath.row].lamp_name
            cell.lamp_category.text = Remote[indexPath.row].lamp_category
            cell.lamp_status.text = Remote[indexPath.row].lamp_status
            cell.lamp_image.sd_setImage(with: URL(string: (Remote[indexPath.row].lamp_image)), placeholderImage: UIImage(named: "lp.png"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
       
        if(isSearching){
            appDelegate.id_remote = filterData[indexPath.row].id_remote
            appDelegate.lamp_name = filterData[indexPath.row].lamp_name
            appDelegate.lamp_category = filterData[indexPath.row].lamp_category
            appDelegate.lamp_status = filterData[indexPath.row].lamp_status
            choose = Remote[indexPath.row].lamp_category
        }else{
            appDelegate.id_remote = Remote[indexPath.row].id_remote
            appDelegate.lamp_name = Remote[indexPath.row].lamp_name
            appDelegate.lamp_category = Remote[indexPath.row].lamp_category
            appDelegate.lamp_status = Remote[indexPath.row].lamp_status
            choose = Remote[indexPath.row].lamp_category
        }

        if(choose == "Camera"){
            self.performSegue(withIdentifier: "id_seg_camera", sender: self)
        }else{
            self.performSegue(withIdentifier: "id_seg_streaming_detail", sender: self)
        }
        
       
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchbar.text == nil || searchbar.text == ""){
            isSearching = false
            view.endEditing(true)
            TableView.reloadData()
        }else{
            isSearching = true
            filterData = Remote.filter({$0.lamp_category.localizedCaseInsensitiveContains(searchbar.text!)})
            TableView.reloadData()
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
