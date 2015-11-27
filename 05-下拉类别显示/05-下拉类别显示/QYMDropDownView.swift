//
//  SCSDropDownView.swift
//  05-下拉类别显示
//
//  Created by mqy on 15/8/21.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit


//
class QYMDropDownView: UIView,UITableViewDelegate,UITableViewDataSource {

    //下拉列表
    private  var mTableView:UITableView = UITableView()
    //文本框
    private var btnSender:UIButton = UIButton()
    //下拉列表数据
    private var list:NSArray = NSArray()
    //下拉列表中存储的数据，用于动态添加 删除数据
    let arrayMu = NSMutableArray()
    var showList:Bool = false
    private var btnRight:UIButton = {
        
         let button = UIButton(frame: CGRectMake(0, 0, 28, 28))
        
        button.setImage(UIImage(named: "actionItem_Selected"), forState: UIControlState.Selected)
        return button
        
        }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    /// MARK - 设置控件的大小位置，显示情况
    //设置显示，点击按钮出现tableviewcell
 func  initWithDropDown(btn :UIButton,height:CGFloat,arrayList: NSArray) ->QYMDropDownView{
        
        //将按钮传递过来
        btnSender = btn;
        
        //设置显示的大小
          frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btn.frame.height, btn.frame.width, 0)
        
         list = arrayList
        
        layer.masksToBounds = false
        layer.cornerRadius = 4
        layer.shadowOffset = CGSizeMake(-5, 5)
        layer.shadowRadius = 5
        layer.shadowOpacity = 0.5
        
        mTableView  = UITableView(frame: CGRectMake(0, 0, btn.frame.width, 0))
        mTableView.delegate = self
        mTableView.dataSource = self
        mTableView.layer.cornerRadius = 4
    
//        mTableView.backgroundColor = UIColor(red: 255/256.0, green: 252/256.0, blue: 195/256.0, alpha: 1)
    mTableView.backgroundColor = UIColor.whiteColor()
        mTableView.separatorStyle = UITableViewCellSeparatorStyle.SingleLine
        mTableView.bounces = false
        mTableView.separatorColor = UIColor.darkGrayColor()
    
       //设置动画显示
        UIView.beginAnimations(nil , context: nil)
        UIView.setAnimationDuration(0.5)
        frame = CGRectMake(btn.frame.origin.x, btn.frame.origin.y + btn.frame.height, btn.frame.width, height)
        mTableView.frame = CGRectMake(0, 0, btn.frame.width, height)
        
        //结束动画
        UIView .commitAnimations()
        
        btn.superview!.addSubview(self)
        self.addSubview(mTableView)
    
        return self
        
    }

    //设置隐藏按钮
    func hideDropDown(dbtn :UIButton){
       
        //使用动画隐藏
        UIView .beginAnimations(nil , context: nil)
        UIView.setAnimationDuration(0.5)
        
        frame = CGRectMake(dbtn.frame.origin.x, dbtn.frame.origin.y + dbtn.frame.height, dbtn.frame.width, 0)
        mTableView.frame = CGRectMake(0, 0, dbtn.frame.width, 0)
        //结束动画
        UIView .commitAnimations()
        showList = false
    }
    
/// 数据源，代理方法的实现
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return list.count
    }
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return 28
    }
    
     //cell
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        //可重用ID
        let  ID = "cell"
        
        var cell = tableView.dequeueReusableCellWithIdentifier(ID)
        
        if cell == nil{
            
            //自定义cell
            cell = QYMDropDownTableViewCell(style: UITableViewCellStyle.Default, reuseIdentifier: ID)
            cell!.textLabel!.font = UIFont.systemFontOfSize(15)
            cell!.textLabel!.textAlignment = NSTextAlignment.Left
        }
        let str = list.objectAtIndex(indexPath.row) as? String
        cell!.textLabel?.text = str
        cell?.textLabel?.textColor = UIColor.darkGrayColor()
        
        return cell!
    }
    //设置尾部view显示
    func tableView(tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
        let footerButton = UIButton(frame: CGRectMake(0, 0,btnSender.frame.width , 100))
        
        footerButton.setTitle("确定", forState: UIControlState.Normal)
        footerButton.backgroundColor = UIColor.whiteColor()
        footerButton.setTitleColor(UIColor(red: 8/256.0, green: 160/256.0, blue: 4/256.0, alpha: 1), forState: UIControlState.Normal)
        footerButton.addTarget(self, action: "clickFooter", forControlEvents: UIControlEvents.TouchUpInside)
        return footerButton
    }
    //尾部标题
    func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String? {
        return "确实"
    }
    
    func clickFooter(){
        hideDropDown(btnSender)
    }
    

        //点击cell
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        //获取Cell
        let cell = tableView.cellForRowAtIndexPath(indexPath) as! QYMDropDownTableViewCell
        
        //按钮按钮文本
        let btnStr = cell.textLabel!.text!
        
        //定义可变数组用于存放按钮字符串
        let mustr = NSMutableString()
        
        //点击Cell后，不选中的状态
        if (cell.isSelect == true)
        {

            cell.cellImage.removeFromSuperview()
            cell.isSelect = false
            
            
            var i:Int = 0;
            for sttr in arrayMu
            {
                if sttr as! String == btnStr
                {
                    arrayMu.removeObjectAtIndex(i)
                    break
                }
                i++
                
            }
        }
        else//点击Cell后，选中的状态
        {
            let imageV = UIImageView(image: UIImage(named: "actionItem_Selected"))
            
            imageV.frame = CGRectMake(122, 7, 14, 14)
            
            cell.cellImage = imageV
            
            cell.addSubview(cell.cellImage)
            
            cell.isSelect = true
 
            arrayMu.addObject(btnStr)
        
        }

        if arrayMu.count > 0
        {
            for sttr in arrayMu
            {
                mustr.appendString(sttr as! String)
            }

            btnSender.setTitle(mustr as String, forState: UIControlState.Normal)
        
        }
        
    }


}

