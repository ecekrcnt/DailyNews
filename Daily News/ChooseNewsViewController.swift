//
//  ChooseNewsViewController.swift
//  Daily News
//
//  Created by Ece KARAÇANTA on 12/09/2017.
//  Copyright © 2017 Ece KARAÇANTA. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class ChooseNewsViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    @IBOutlet weak var collectionView: UICollectionView!
    var news:[NSDictionary] = []
    var selectedIds=[String]()

    override func viewDidLoad() {
        super.viewDidLoad()
        let itemSize = UIScreen.main.bounds.width/3 - 10
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsetsMake(20, 0, 10, 0)
        layout.itemSize = CGSize(width: itemSize, height: itemSize)
        layout.minimumInteritemSpacing = 10
        layout.minimumLineSpacing = 10
        collectionView.collectionViewLayout = layout
        
        let jsonArray = try? JSONSerialization.jsonObject(with: readjson(fileName: "NewsSource") as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as! NSArray
        for json in jsonArray! {
            let NewsSource = json as? NSDictionary
            news.append(NewsSource!)
        }
        collectionView.reloadData()
    }
    
    func readjson(fileName: String) -> NSData{
        let path = Bundle.main.path(forResource: fileName, ofType: "json")
        let jsonData = NSData(contentsOfFile: path!)
        
        return jsonData!
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Number of Views
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.news.count
    }
    
    //Populate View
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! CellCollectionViewCell
        cell.lbl_cell.text = self.news[indexPath.row].value(forKey: "name") as? String
        let url = NSURL(string: (self.news[indexPath.row].value(forKey: "image_url") as? String)!)
        cell.image_cell.af_setImage(withURL: url! as URL, placeholderImage: nil, filter: nil, imageTransition: .crossDissolve(0.5), runImageTransitionIfCached: true, completion: nil)
        
//        var borderColor: CGColor! = UIColor.clear.cgColor
//        var borderWidth = 0
//        if indexPath == indexPath{
//            borderColor = UIColor.clear.cgColor
//            borderWidth = 1 //or whatever you please
//        }else{
//            borderColor = UIColor.clear.cgColor
//            borderWidth = 0
//        }
//        
//        cell.layer.borderWidth = CGFloat(borderWidth)
//        cell.layer.borderColor = borderColor
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = collectionView.cellForItem(at: indexPath)
        let selectedSource = (self.news[indexPath.row].value(forKey: "id") as? String)!
        if selectedIds.contains(selectedSource){
            self.selectedIds.remove(at: self.selectedIds.index(of: selectedSource)!)
            cell?.backgroundColor = UIColor.clear
        }else{
            self.selectedIds.append((self.news[indexPath.row].value(forKey: "id") as? String)!)
            cell?.backgroundColor = UIColor.green 
        }
    }
}
