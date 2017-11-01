//
//  AlertController.swift
//  PinterstLikeCollectionViewAndFlickrImageSearch
//
//  Created by Yuu Ogasa on 2017/11/01.
//  Copyright © 2017年 SundayCarpenter. All rights reserved.
//

import UIKit

struct AlertController{
    // *****************
    // MARK: Alert Message
    // *****************
    /// OK アラートメッセージダイアログを表示する
    ///
    /// - Parameters:
    ///   - title: タイトル
    ///   - message: メッセージ
    ///   - vc: 表示元VC & delegate
    ///   - nextSelector: 閉じた後実行するセレクタ
    static func showOkAlertMessage(title: String?, message: String?,
                                  vc: UIViewController, nextSelector: Selector?) {
        
        let alertController = UIAlertController(title: title,
                                                message: message,
                                                preferredStyle: .alert)
        
        let alertAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //OK
            let delegate = vc as? AlertMessageDelegate
            delegate?.completeActionAlertMessage(action: action,
                                                   nextSelector: nextSelector)
        }
        
        alertController.addAction(alertAction)
        
        // 表示
        vc.present(alertController, animated: true, completion: nil)
    }
    
    /// OK キャンセル 確認メッセージダイアログを表示する
    ///
    /// - Parameters:
    ///   - title: タイトル
    ///   - message: メッセージ
    ///   - vc: 表示元VC & delegate
    ///   - nextSelector: ダイアログを閉じた後実行するセレクタ ※OK・キャンセルどちらを押しても実行される
    static func showOkConfirmMessage(title: String, message: String?,
                                    vc: UIViewController, nextSelector: Selector?) {
        let alertController = UIAlertController(title: title,
                                                message: message, preferredStyle: .alert)
        
        let delegate = vc as? AlertMessageDelegate
        
        let okAction = UIAlertAction(title: "OK", style: .default) { (action) in
            //OK
            delegate?.completeActionAlertMessage(action: action, nextSelector: nextSelector)
        }
        alertController.addAction(okAction)
        
        let cancelAction = UIAlertAction(title: "キャンセル", style: .cancel) { (action) in
            //Cancel
            delegate?.completeActionAlertMessage(action: action, nextSelector: nextSelector)
        }
        
        alertController.addAction(cancelAction)
        
        //表示
        vc.present(alertController, animated: true, completion: nil)
    }
}
