//
//  ViewController.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/10/20.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit
import SVProgressHUD

class SearchViewController: UIViewController {
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    var searchViewProvider:SearchViewProvider = SearchViewProvider()
    
    var mySingleTap: UITapGestureRecognizer?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Set up UI parts
        setupCollectionView()
        setupSearchBarConf()
        
        //to close keyboard when the view is tapped
        setupSingleTap(view: self.view)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

// MARK: - CollectionView
extension SearchViewController{
    private func setupCollectionView() {
        #if false
            if let layout = collectionView.collectionViewLayout as? PinterestLayout{
                layout.delegate = searchViewProvider
            }
            
            collectionView.dataSource = searchViewProvider
            registerNib()
        #else
            registerNib()
            collectionView.dataSource = searchViewProvider
            collectionView.reloadData()
        #endif
    }
    
    /// Nibを登録する
    private func registerNib() {
        
        let emptyCellNib = UINib(nibName: EmptyCell.nibName,
                                 bundle: Bundle.main)
        collectionView.register(emptyCellNib,
                                forCellWithReuseIdentifier: EmptyCell.identifier)
        
        let photoCellNib = UINib(nibName: PhotoCell.nibName,
                                 bundle: Bundle.main)
        collectionView.register(photoCellNib,
                                forCellWithReuseIdentifier: PhotoCell.identifier)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout
extension SearchViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView,
                        layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return PhotoCell.cellSize()
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
        //searchBar.prompt = "タイトル"
    }
    
    /// プレースホルダーを付加する
    private func setupPlaceHolder() {
        //searchBar.placeholder = "入力してください"
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
            
            if searchText.isEmpty{
                                print("keyword is empty")
                                return
                            }
            
            print("start search for:\(searchText)")
            startSearch(searchText)
        }
    }
    
    /// サーチバーの中身が更新されるときに呼ばれる
    /// 日本語入力の場合、確定ボタンを押すタイミングで呼ばれる
    func searchBar(_ searchBar: UISearchBar,
                   textDidChange searchText: String) {
//        print(#function)
//        print(searchText)
//        
    }
    
    /// キャンセルボタンをクリックしたときに呼ばれる
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchBar.text = ""
        searchBar.resignFirstResponder()
        
        _ = cancelSearch()
    }
    
    func cancelSearch(){
        SVProgressHUD.dismiss()
        imageSearchContext.cancelSearch()
    }
}

// MARK: - Kick Search process
extension SearchViewController{
    
    /// 今何ページ目まで検索が終わっているか等、状態は気にせずリクエストすることに注意
    ///
    /// - Parameter keyword: 検索キーワード
    func startSearch(_ newKeyword:String) {
        // インジケータのみのHUDを表示する
        SVProgressHUD.show()
        
        // start to search images
        imageSearchContext.getImage(of: newKeyword)
        {[weak self] result in
            
            SVProgressHUD.dismiss()
            
            switch result{
            case .success(let images):
                DispatchQueue.main.async{
                    self?.scrollToTop()
                    self?.searchViewProvider.replace(with: images)
                    self?.collectionView.reloadData()
                }
                
            case .failure(let error):
                self?.handle(error)
            }
            
        }
    }
    
    func loadMorePage() {
        SVProgressHUD.show()
        
        // start to search images
        imageSearchContext.getMoreImage()
            {[weak self] result in
                switch result{
                case .success(let images):
                    self?.searchViewProvider.append(images)
                    self?.collectionView.reloadData()
                    
                case .failure(let error):
                    self?.handle(error)
                }
                
                // HUDを消去する
                SVProgressHUD.dismiss()
        }
    }
    
    
    func handle(_ error:ClientError) {
        //do error handling
        DispatchQueue.main.async {
            
            switch error{
            case .connectionError(let error):
                switch error{
                case .isNotReachable:
                    self.alert(LocalizableKey.noConnection,
                                message: "")
                }
                
            case .responseParseError(let er):
                //when search gives nothing, show alert
                if er.message == CommonDefines.photoInfoIsEmpty{
                    
                    // メインスレッドで実行
                    self.searchViewProvider.makesPhotosEmpty()
                    self.collectionView.reloadData()
                    self.alert(LocalizableKey.searchNoImageTitle.localized,
                                message: LocalizableKey.searchNoImageMessage.localized)
                    return
                    
                    
                }
                
            case .flickrImageSearchContextError(let error):
                switch error{
                case .alreadyFetching:return
                    
                case .noMorePage:
                    self.alert(LocalizableKey.searchNoImageTitle.localized,
                                message: "")
                    return
                case .noResponse:
                    self.alert(LocalizableKey.searchNoResponse.localized,
                                message: "")
                    return
                case .noPreviousPage:
                    self.alert(LocalizableKey.someErrorHappened.localized,
                               message: "")
                }
                
                
            default:
                print(error)
            }
        }
    }
}

// MARK: - Close　Keyboard
extension SearchViewController{
    /// シングルタップのジェスチャー設定
    /// キーボード以外をタップしてキーボードを閉じるため
    ///
    /// - Parameter view: タップするビュー
    func setupSingleTap(view: UIView) {
        mySingleTap = UITapGestureRecognizer(target: self,
                                             action: #selector(onSingleTap))
        mySingleTap?.delegate = self
        mySingleTap?.numberOfTapsRequired = 1
        
        view.addGestureRecognizer(mySingleTap!)
    }
    
    /// シングルタップイベントの処理をする
    /// キーボードを閉じる
    ///
    /// - Parameter recognizer: ジェスチャーリコグナイザー
    @objc func onSingleTap(recognizer: UITapGestureRecognizer) {
        closeKeyboard()
    }
    
    /// すべてのテキストフィールドのキーボードを閉じる
    func closeKeyboard() {
        searchBar.resignFirstResponder()
    }
}

//--------------------------------------
// MARK: - UIGestureRecognizerDelegate
//--------------------------------------
extension SearchViewController: UIGestureRecognizerDelegate {
    
    /// タッチを検知したときの処理を行う
    /// キーボード表示中のみ有効にするため
    ///
    /// - Parameters:
    ///   - gestureRecognizer: ジェスチャーリコグナイザー
    ///   - touch: タッチ
    /// - Returns: true 有効、 false 無効
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer,
                           shouldReceive touch: UITouch) -> Bool {
        if gestureRecognizer == mySingleTap {
            if searchBar.isFirstResponder {
                return true
            }
            else{
                return false
            }
        }
        return true
    }
}

extension SearchViewController:AlertMessageDelegate{
    func completeActionAlertMessage(action: UIAlertAction,
                                    nextSelector: Selector?) {
        //do something
    }
    
    
}

// MARK: - Paging
extension SearchViewController:UIScrollViewDelegate{
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard collectionView.isScrollEnd() else {
            return
        }
        
        if let keyword = searchBar.text {
            //if keyword is not empty,search keyword
            if keyword.isEmpty { return }
            
            // ここに来る時点では、
            // - 完全に通信が終わって最後まで行き着いたとき
            // - 行き着いてリクエストが始まっている
            // 場合がある。後者の場合、ここで「次のページが有るかどうか」を判定するのは不適切になる
            // ここでは、「すでにフェッチを開始しているかどうか」だけを見るべき
            do {
                // check necesity to aditional search request
                if imageSearchContext.isFetching  {
                    return
                }
            }
            
            loadMorePage()
        }
    }
    
    private func scrollToTop(){
        if imageSearchContext.currentPage == 1{
            collectionView.scrollToTop()
        }
    }
}

extension SearchViewController{
    func resetSearchResultAndView() {
        //手元のデータを削除
        searchViewProvider.makesPhotosEmpty()
        
        //viewもリセット
        collectionView.reloadData()
    }
}

extension SearchViewController{
    func alert(_ title:String, message:String) {
        AlertController.showOkAlertMessage(title: title,
                                           message: message,
                                           vc: self,
                                           nextSelector: nil)
    }
}
