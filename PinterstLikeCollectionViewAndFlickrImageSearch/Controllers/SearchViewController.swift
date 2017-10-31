//
//  ViewController.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchViewProvider:SearchViewProvider!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        searchViewProvider = SearchViewProvider()
        
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = searchViewProvider
        }
        
        collectionView.dataSource = searchViewProvider
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

