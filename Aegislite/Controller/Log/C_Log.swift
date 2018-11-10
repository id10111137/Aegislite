//
//  C_Log.swift
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

class C_Log: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchDisplayDelegate, UICollectionViewDelegateFlowLayout {

    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
     let appDelegate = UIApplication.shared.delegate as! AppDelegate
    
    var Logs = [M_Log]()
    var filterData = [M_Log]()
    var isSearching = false
    var choose: String = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.navigationController?.navigationBar.topItem?.title = ""
        let bg = UIImage.init(named: "bg.png")
        let bgView = UIImageView.init(frame: self.view.frame)
        bgView.image = bg
        bgView.contentMode = .scaleAspectFill
        bgView.alpha = 0.5
        self.view.insertSubview(bgView, at: 0)
        collectionView.delegate = self
        collectionView.dataSource = self
        loadData()
        DispatchQueue.main.async {
            self.collectionView.reloadData()
        }
        searchBar.returnKeyType = UIReturnKeyType.done
        
    }
    
    
    
    func loadData(){
        
        let headers: HTTPHeaders = [
            "Authorization": "Bearer "+appDelegate.token,
            "Accept": "application/json"
        ]
        
        Alamofire.request("http://devcctv.sugihartdigital.id/api/get_log", method: .post, headers: headers).responseJSON { response in
            
            switch response.result {
            case .success(let value):
                let json = JSON(value)
                for item in json["data"].arrayValue {
                    
                    
                    self.Logs.append(M_Log(name_image: item["image"].stringValue))
                    
                    DispatchQueue.main.async {
                        self.collectionView.reloadData()
                    }
                }
            case .failure(let error):
                print(error)
            }
            
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if (isSearching){
            return filterData.count
        }
        return Logs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let yourWidth = collectionView.bounds.width/4.0
        let yourHeight = yourWidth
        
        return CGSize(width: yourWidth, height: yourHeight)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets.zero
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "rowcell", for: indexPath) as! A_Log_Cell
         if(isSearching){
            cell.Image_Log.sd_setImage(with: URL(string: ("http://devcctv.sugihartdigital.id/api/storagelog/"+filterData[indexPath.row].name_image)), placeholderImage: UIImage(named: "lp.png"))
         }else{
            cell.Image_Log.sd_setImage(with: URL(string: ("http://devcctv.sugihartdigital.id/api/storagelog/"+Logs[indexPath.row].name_image)), placeholderImage: UIImage(named: "lp.png"))
        }
        
        return cell
    }
    
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        if (isSearching){
            return filterData.count
        }
        return Logs.count
    }
    
  
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
//        if(isSearching){
//            appDelegate.id_remote = filterData[indexPath.row].id_remote
//            appDelegate.lamp_name = filterData[indexPath.row].lamp_name
//            appDelegate.lamp_category = filterData[indexPath.row].lamp_category
//            appDelegate.lamp_status = filterData[indexPath.row].lamp_status
//            choose = Remote[indexPath.row].lamp_category
//        }else{
//            appDelegate.id_remote = Remote[indexPath.row].id_remote
//            appDelegate.lamp_name = Remote[indexPath.row].lamp_name
//            appDelegate.lamp_category = Remote[indexPath.row].lamp_category
//            appDelegate.lamp_status = Remote[indexPath.row].lamp_status
//            choose = Remote[indexPath.row].lamp_category
//        }
//
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
            collectionView.reloadData()
        }else{
            isSearching = true
            filterData = Logs.filter({$0.name_image.localizedCaseInsensitiveContains(searchBar.text!)})
            collectionView.reloadData()
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
