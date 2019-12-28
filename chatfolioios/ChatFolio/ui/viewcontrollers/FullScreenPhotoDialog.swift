//
//  FullScreenPhotoDialog.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FullScreenPhotoDialog: UIViewController, AdapterInteractionInterface, UITextFieldDelegate {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }
    func onClickImage(adapterType: AdapterType) {
        
    }
    
    func onClickTitle(adapterType: AdapterType) {
        
    }
    
    func onClickDate(adapterType: AdapterType) {
        
    }
    
    func onClickComment(adapterType: AdapterType) {
        
    }
    

    @IBOutlet weak var fullScreenPhotoImage: UIImageView!
    
    
    @IBOutlet weak var fullScreenPhotoTitle: UILabel!
    
    @IBOutlet weak var fullScreenPhotoMessageText: UITextField!
    
    @IBOutlet weak var fullScreenPhotoDetails: UILabel!
    
    @IBOutlet weak var fullScreenPhotoCommentsTable: UITableView!
    
    @IBOutlet weak var fullScreenSendCommentButton: UIButton!
    
    
    @IBAction func onFullscreenSendComment(_ sender: Any) {
        dataInterface.onPostedCommentToPhoto(comment: fullScreenPhotoMessageText.text!)
        fullScreenPhotoMessageText.text = ""
        fullScreenPhotoCommentsTable.reloadData()
    }
    
    @IBAction func onClickOutside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    var commentsAdapter = ChatFolioCommentsAdapter()
    
    
    var dataInterface : DataInterface! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataInterface.onSelectedPhotoRetrieved() != nil)
        {
            fullScreenPhotoImage.sd_setImage(with: URL(string: dataInterface.onSelectedPhotoRetrieved().imageUrl), placeholderImage: UIImage(named: "cake"))
            fullScreenPhotoTitle.text = dataInterface.onSelectedPhotoRetrieved().caption
            fullScreenPhotoDetails.text = dataInterface.onSelectedPhotoRetrieved().user.fullName
            
            let nibComments = UINib.init(nibName: "CommentTableViewCell", bundle: nil)
            fullScreenPhotoCommentsTable.register(nibComments, forCellReuseIdentifier: "CommentTableViewCell")
            fullScreenPhotoMessageText.delegate = self
            setComments()
        }
        // Do any additional setup after loading the view.
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        dataInterface = nil
    }
    
    func setComments()
    {
        commentsAdapter.initializeData(dataInterface_: dataInterface, adapterInterface_: self)
        fullScreenPhotoCommentsTable.delegate = commentsAdapter
        fullScreenPhotoCommentsTable.dataSource = commentsAdapter
        fullScreenPhotoCommentsTable.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
