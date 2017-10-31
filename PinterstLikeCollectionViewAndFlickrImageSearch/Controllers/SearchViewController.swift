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
    var searchViewProvider:SearchViewProvider = SearchViewProvider()
    let flickrAPIManager = FlickrAPIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI parts
        setupCollectionView()
        setupSearchBarConf()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CollectionView
extension SearchViewController{
    private func setupCollectionView() {
        if let layout = collectionView.collectionViewLayout as? PinterestLayout{
            layout.delegate = searchViewProvider
        }
        
        collectionView.dataSource = searchViewProvider
        registerNib()
    }
    
    /// Nibを登録する
    private func registerNib() {
        
        let emptyCellNib = UINib(nibName: EmptyCell.nibName, bundle: Bundle.main)
        collectionView.register(emptyCellNib, forCellWithReuseIdentifier: EmptyCell.identifier)
        
        let photoCellNib = UINib(nibName: PhotoCell.nibName, bundle: Bundle.main)
        collectionView.register(photoCellNib, forCellWithReuseIdentifier: PhotoCell.identifier)
    }
}

// MARK: - Search Bar
extension SearchViewController{
    private func setupSearchBarConf() {
        setupDelegate()
        setupShowCancelButton()
        setupPrompt()
        setupPlaceHolder()
        setupKeyboard()
    }
    
    private func setupDelegate() {
        searchBar.delegate = self
    }
    
    /// キャンセルボタンを付加する
    private func setupShowCancelButton() {
        searchBar.showsCancelButton = true
    }
    
    /// タイトルを付加する
    private func setupPrompt() {
        searchBar.prompt = "タイトル"
    }
    
    /// プレースホルダーを付加する
    private func setupPlaceHolder() {
        searchBar.placeholder = "入力してください"
    }
    
    /// キーボードを付加する
    private func setupKeyboard() {
        searchBar.keyboardType = .default
    }
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
    /// 検索をクリックしたときに呼ばれる
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        print(#function)
        if let searchText = searchBar.text {
            print("searchText:\(searchText)")
            
            // start to search images
            flickrAPIManager.getImage(of: searchText)
            {[unowned self] result in
                switch result{
                case .success(let images):
                    self.searchViewProvider.photos = images
                    self.collectionView.reloadData()
                case .failure(let error):
                    print(error)
                }
            }
        }
    }
    
    /// サーチバーの中身が更新されるときに呼ばれる
    /// 日本語入力の場合、確定ボタンを押すタイミングで呼ばれる
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
        print(#function)
        print(searchText)
        
    }
    
    /// キャンセルボタンをクリックしたときに呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
    }
}


