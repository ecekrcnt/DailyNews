//
//  ProfileViewController.swift
//  Daily News
//
//  Created by Ece KARAÇANTA on 25/09/2017.
//  Copyright © 2017 Ece KARAÇANTA. All rights reserved.
//

import UIKit

class ProfileViewController: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {

    @IBOutlet weak var image_profile: UIImageView!
    @IBOutlet weak var searchbar: UISearchBar!
    @IBAction func btn_exit(_ sender: Any) {
        let vc = self.storyboard?.instantiateViewController(withIdentifier: "LoginVCID")
        self.present(vc!, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    

    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "myCell", for: indexPath)
        return cell
        
    }
    

    

}
