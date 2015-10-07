//
//  AddBlogController.swift
//  MiniBlog
//
//  Created by Allister Alambra on 10/6/15.
//  Copyright © 2015 Seer Technologies, Inc. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class AddBlogController: BaseController{
    
    var addBlogView: AddBlogView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Load Targeted Xibs
        self.loadXibName("AddBlogView")
        self.addBlogView = (self.view as! AddBlogView)
        
        // Initialize UI Elements
        self.initializeNavigationBar()
        
    }
    
    // MARK: CoreData Methods
    func postBlog(){
        let appDelegate = UIApplication.sharedApplication().delegate as! AppDelegate
        let managedContext = appDelegate.managedObjectContext
        let entity =  NSEntityDescription.entityForName("Post", inManagedObjectContext:managedContext)
        let post:Post = Post(entity: entity!, insertIntoManagedObjectContext: managedContext)
        post.title = self.addBlogView?.blogTitleTextField.text
        post.content = self.addBlogView?.blogPostTextView.text
        post.date = NSDate()
        
        let authEntity =  NSEntityDescription.entityForName("Author", inManagedObjectContext:managedContext)
        let auth:Author = Author(entity: authEntity!,
            insertIntoManagedObjectContext: managedContext)
        auth.name = SessionManager.sharedInstance.sessionName
        post.post_author = auth
        
        do {
            try managedContext.save()
            self.navigationController?.popViewControllerAnimated(true)
        } catch let error as NSError  {
            print("Could not save \(error), \(error.userInfo)")
        }
    }
    
    // MARK: Controller Initializers
    
    func initializeNavigationBar(){
        
        let addBlogButtonItem = UIBarButtonItem(title: "Post", style: .Plain, target: self, action: Selector("postBlog"))
        self.navigationItem.rightBarButtonItem = addBlogButtonItem
        self.navigationController?.setNavigationBarHidden(false, animated: true)
        
    }
    
}