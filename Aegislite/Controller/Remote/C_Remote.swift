//
//  C_Remote.swift
//  Aegislite
//
//  Created by Tatang Roswandi Ganda Wijaya on 07/11/18.
//  Copyright © 2018 Tatang Roswandi Ganda Wijaya. All rights reserved.
//

import UIKit
import CocoaMQTT
import Alamofire
import SwiftyJSON
import Floaty
import SDWebImage
import PopupDialog


class C_Remote: UIViewController,  UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {

    
    @IBOutlet weak var floaty: Floaty!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var Streaming = [M_Streaming]()
    var filterData = [M_Streaming]()
    var isSearching = false
    var choose: String = ""
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
             self.navigationController?.navigationBar.topItem?.title = ""
        floaty.addItem("Add Barcode", icon: UIImage(named: "br.png")!, handler: { item in
            //            self.performSegue(withIdentifier: "id_seg_profil", sender: self)
        })
        floaty.addItem("Add Manual", icon: UIImage(named: "ma.png")!, handler: { item in
            //            self.performSegue(withIdentifier: "id_seg_profil", sender: self)
        })
        self.view.addSubview(floaty)
        tableView.delegate = self
        tableView.dataSource = self
        loadData()
        searchBar.returnKeyType = UIReturnKeyType.done
    }
    
    func loadData(){
        Streaming.append(M_Streaming(id_streaming: 1, image_streaming: "", name_streaming: "Lamp Model Dingding",category: "Lampu",type: "ON"))
        Streaming.append(M_Streaming(id_streaming: 2, image_streaming: "", name_streaming: "Lamp Model TAMAN",category: "Switch",type: "ON"))
        Streaming.append(M_Streaming(id_streaming: 3, image_streaming: "", name_streaming: "Lamp Model LUAR",category: "Camera",type: "ON"))
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
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if (isSearching){
            return filterData.count
        }
        return Streaming.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "rowcell") as! A_Row_Streaming
        
        if(isSearching){
            cell.name_streaming.text = filterData[indexPath.row].name_streaming
            cell.category.text = filterData[indexPath.row].category
            cell.type.text = filterData[indexPath.row].type
            cell.image_streaming.sd_setImage(with: URL(string: (filterData[indexPath.row].image_streaming)), placeholderImage: UIImage(named: "lp.png"))
        }else{
            cell.name_streaming.text = Streaming[indexPath.row].name_streaming
            cell.category.text = Streaming[indexPath.row].category
            cell.type.text = Streaming[indexPath.row].type
            cell.image_streaming.sd_setImage(with: URL(string: (Streaming[indexPath.row].image_streaming)), placeholderImage: UIImage(named: "lp.png"))
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150.0
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if(isSearching){
            appDelegate.id_streaming = filterData[indexPath.row].id_streaming
            appDelegate.name_streaming = filterData[indexPath.row].name_streaming
            appDelegate.type = filterData[indexPath.row].type
            appDelegate.category = filterData[indexPath.row].category
            choose = filterData[indexPath.row].category
        }else{
            appDelegate.id_streaming = Streaming[indexPath.row].id_streaming
            appDelegate.name_streaming = Streaming[indexPath.row].name_streaming
            appDelegate.type = Streaming[indexPath.row].type
            appDelegate.category = Streaming[indexPath.row].category
            choose = Streaming[indexPath.row].category
        }
        
//        if(choose == "Camera"){
//            self.performSegue(withIdentifier: "id_seg_camera", sender: self)
//        }else{
//            self.performSegue(withIdentifier: "id_seg_streaming_detail", sender: self)
//        }
        
        
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if(searchBar.text == nil || searchBar.text == ""){
            isSearching = false
            view.endEditing(true)
            tableView.reloadData()
        }else{
            isSearching = true
            filterData = Streaming.filter({$0.name_streaming.localizedCaseInsensitiveContains(searchBar.text!)})
            tableView.reloadData()
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
