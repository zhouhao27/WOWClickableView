//
//  ViewController.swift
//  WOWClickableView
//
//  Created by Zhou Hao on 03/11/16.
//  Copyright © 2016年 Zhou Hao. All rights reserved.
//

import UIKit

class ViewController: UIViewController , WOWClickableDelegate, UITableViewDataSource, UITableViewDelegate {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var clickableView: WOWClickableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
     
        clickableView.userInfo = String("test") as Any
        clickableView.delegate = self
        clickableView.backgroudImage = UIImage(named: "banner3")
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func onClick(view: WOWClickableView, userInfo: Any?) {
        let str = userInfo as! String
        print("clicked: \(str)")
    }

    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! Cell
        cell.cell1.userInfo = "cell1"
        cell.cell1.delegate = self
        cell.cell2.userInfo = "cell2"
        cell.cell2.delegate = self
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120.0
    }    

}

class Cell : UITableViewCell {
    @IBOutlet weak var cell1: WOWClickableView!
    @IBOutlet weak var cell2: WOWClickableView!
    
}

