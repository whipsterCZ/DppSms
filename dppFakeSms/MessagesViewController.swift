//
//  MessagesViewController.swift
//  dppFakeSms
//
//  Created by Daniel Kouba on 18/04/15.
//  Copyright (c) 2015 DéKá Studio. All rights reserved.
//

import UIKit

class MessagesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(animated: Bool) {
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "reload", name: "update", object: nil)
    }
    
    override func viewDidLoad() {
        
        
        //style tableView
        let nibName = UINib(nibName: "TableViewCell", bundle:nil)
        tableView.registerNib(nibName, forCellReuseIdentifier: "Cell")
        tableView.separatorStyle = .None
        tableView.allowsSelection = false
        
        
    }
    
    func reload(){
        tableView.reloadData()
    }
    
    
    @IBAction func genererateNew(sender: AnyObject) {
        DI.context.appDelegate.generateMessages()
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return DI.context.appDelegate.messages.count
    }
    
     func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as TableViewCell
        let message = DI.context.appDelegate.messages[indexPath.item]
        cell.dateLabel.text = message.getRecievedAt()
        cell.dateFromLabel.text = message.getFromDay()
        cell.dateToLabel.text = message.getToDay()
        cell.timeFromLabel.text = message.getFromTime()
        cell.timeToLabel.text = message.getToTime()
        cell.priceLabel.text = message.getPrice()
        cell.codeLabel.text = message.getCodeString()
        cell.codeIntLabel.text = message.getCodeInt()
        
        
        return cell
    }

    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 200.0
    }
}
