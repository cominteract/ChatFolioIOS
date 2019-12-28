//
//  MainViewController.swift
//  ChatFolio
//
//  Created by Admin on 4/28/18.
//  Copyright © 2018 Admin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, DataAvailabilityInterface,AdapterInteractionInterface {
    func onMockDataRetrieved() {

    }
    
    func onClickImage(adapterType: AdapterType) {
        
    }
    
    func onClickTitle(adapterType: AdapterType) {
        
    }
    
    func onClickDate(adapterType: AdapterType) {
        
    }
    
    func onClickComment(adapterType: AdapterType) {
        
    }
    

    var dataInterface : DataInterface! = nil
    var appTransitionInterface : AppTransitionInterface! = nil
    override func viewDidLoad() {
        super.viewDidLoad()
        if let context = self.navigationController as? MainNavigation
        {
            dataInterface = context.dataInterface
            appTransitionInterface = context
            context.dataFragmentInterface = self
            if(!context.isLoaded)
            {
                appTransitionInterface.onInterfaceLoaded()
            }
            //context.dataFragmentInterface
        }
        // Do any additional setup after loading the view.
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
