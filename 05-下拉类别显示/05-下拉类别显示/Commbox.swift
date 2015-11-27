//
//  Commbox.swift
//  05-下拉类别显示
//
//  Created by mqy on 15/8/25.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

class Commbox: UIView,UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate {
    //下拉列表
    private var talView:UITableView = UITableView();
    internal var tableArray:NSMutableArray?//下拉列表数据
    
    internal var textField:UITextField?//文本输入框
    
    private var showList:Bool = false //是否弹出下拉列表
    
    private var tabHeight:CGFloat //下拉列表的高度
    
    private var frameHeight:CGFloat //frame的高度
    
    override init(var frame: CGRect) {
        
        if  frame.size.height < 200{
            frameHeight = 200
        }else{
            frameHeight = frame.size.height
        }
        
        tabHeight = frameHeight - 30
        frame.size.height = 30.0
        super.init(frame: frame)
        
       showList = false
        
        talView = UITableView(frame: CGRectMake(0, 30, frame.size.width + 80 , 0), style: UITableViewStyle.Plain)
        talView.delegate = self
        talView.dataSource = self
        talView.separatorColor = UIColor.lightGrayColor()
        talView.hidden = true
        self.addSubview(talView)
        
        textField = UITextField(frame: CGRectMake(0, 0, frame.size.width + 80, 30))
        textField!.font = UIFont.systemFontOfSize(15)
        textField!.borderStyle = UITextBorderStyle.RoundedRect
        textField!.addTarget(self, action: "dropDown", forControlEvents: UIControlEvents.AllTouchEvents)
        self.addSubview(textField!)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func dropDown(){
        
        textField?.resignFirstResponder()
        //如果已经下拉不动作
        if showList {
            return
        }else{
            
            var sf = frame
            sf.size.height = frameHeight
            
            self.superview?.bringSubviewToFront(self)
            talView.hidden = false
            showList = true
            var frameNew = talView.frame

            talView.frame.size.height = 0
            frameNew.size.height = tabHeight
            UIView.beginAnimations("ResizeForKeyBoard", context: nil)
            UIView.setAnimationCurve(UIViewAnimationCurve.Linear)
            
            frame = sf
            talView.frame = frameNew
            UIView.commitAnimations()
        }
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tableArray!.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cellID = "cell "
        
        var cell = talView .dequeueReusableCellWithIdentifier(cellID)
        if cell == nil{
            cell = UITableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellID)
        }
        cell!.textLabel!.text = tableArray!.objectAtIndex(indexPath.row) as? String
        cell!.textLabel!.font = UIFont.systemFontOfSize(15.0)
        cell!.accessoryType = UITableViewCellAccessoryType.None
        cell!.selectionStyle = UITableViewCellSelectionStyle.Gray
        return cell!
    }
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 35
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
         textField!.text = tableArray!.objectAtIndex(indexPath.row) as? String
        showList = false
        tableView.hidden = true
        
        frame.size.height  = 30
        tableView.frame.size.height = 0
    }


}
