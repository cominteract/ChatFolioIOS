//
//  FullScreenFeedDialog.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class FullScreenFeedDialog: UIViewController,AdapterInteractionInterface,UITextFieldDelegate {
    func onClickImage(adapterType: AdapterType) {
        
    }
    
    func onClickTitle(adapterType: AdapterType) {
        
    }
    
    func onClickDate(adapterType: AdapterType) {
        
    }
    
    func onClickComment(adapterType: AdapterType) {
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return false
    }

    
    @IBOutlet weak var fullScreenFeedImage: UIImageView!
    
    @IBOutlet weak var fullScreenFeedTitle: UILabel!
    
    @IBOutlet weak var fullScreenFeedDetails: UILabel!
    

    @IBOutlet weak var fullScreenFeedComment: UITextField!
    

    @IBOutlet weak var fullScreenFeedCommentsTable: UITableView!
    
    
    @IBAction func onClickOutside(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    @IBAction func fullScreenSendComment(_ sender: Any) {
        dataInterface.onPostedCommentToFeed(comment: fullScreenFeedComment.text!)
        fullScreenFeedComment.text = ""
        fullScreenFeedCommentsTable.reloadData()
    }
    
    
    var commentsAdapter = ChatFolioCommentsAdapter()
    
    
    var dataInterface : DataInterface! = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if(dataInterface.onSelectedFeedRetrieved() != nil)
        {
            fullScreenFeedImage.sd_setImage(with: URL(string: dataInterface.onSelectedFeedRetrieved().activityImageUrl), placeholderImage: UIImage(named: "cake"))
            fullScreenFeedTitle.text = dataInterface.onSelectedFeedRetrieved().activityDetails
            fullScreenFeedDetails.text = dataInterface.onSelectedFeedRetrieved().recipient.fullName
            
            let nibComments = UINib.init(nibName: "CommentTableViewCell", bundle: nil)
            fullScreenFeedCommentsTable.register(nibComments, forCellReuseIdentifier: "CommentTableViewCell")
            fullScreenFeedComment.delegate = self
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
        fullScreenFeedCommentsTable.delegate = commentsAdapter
        fullScreenFeedCommentsTable.dataSource = commentsAdapter
        fullScreenFeedCommentsTable.reloadData()
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
