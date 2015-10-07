//
//  UpdateBlogController.swift
//  MiniBlog
//
//  Created by Mac on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class UpdateBlogController: BaseController {
    
    var updateBlogView: AddBlogView?
    var postTitle: String?
    var postAuthor: String?
    var postContent: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("AddBlogView")
        self.updateBlogView = (self.view as! AddBlogView)
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        self.initializePostDetails()
    }
    
    // MARK: CoreData Methods
    func saveBlog(){
        
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        
        let fetchRequest = NSFetchRequest(entityName: "Post")
        fetchRequest.predicate = NSPredicate(format: "title = %@", self.postTitle!)
        
        do {
            if let fetchResults = try appDelegate.managedObjectContext.executeFetchRequest(fetchRequest) as? [NSManagedObject] {
                if fetchResults.count != 0 {
                    
                    let managedObject = fetchResults[0]
                    let newDate = NSDate()
                    managedObject.setValue(self.updateBlogView?.blogTitleTextField.text, forKey: "title")
                    managedObject.setValue(self.updateBlogView?.blogPostTextView.text, forKey: "content")
                    managedObject.setValue(newDate, forKey: "date")
                    
                    do {
                        try managedContext.save()
                        self.navigationController?.popViewControllerAnimated(true)
                    } catch let error as NSError  {
                        print("Could not save \(error), \(error.userInfo)")
                    }
                }
            }
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Controller Initializers
    
    func initializeNavigationBar(){
        
        if (self.postAuthor == SessionManager.sharedInstance.sessionName) {
            let addBlogButtonItem = UIBarButtonItem(title: "Save", style: .Plain, target: self, action: Selector("saveBlog"))
            self.navigationItem.rightBarButtonItem = addBlogButtonItem
        }
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
    func initializePostDetails() {
        self.updateBlogView?.blogTitleTextField.text = self.postTitle
        self.updateBlogView?.blogPostTextView.text = self.postContent
        
        if (self.postAuthor != SessionManager.sharedInstance.sessionName) {
            self.updateBlogView?.blogTitleTextField.enabled = false
            self.updateBlogView?.blogPostTextView.editable = false
        }
    }
    
}