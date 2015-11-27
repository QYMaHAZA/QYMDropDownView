//
//  ViewController.swift
//  05-下拉类别显示
//
//  Created by mqy on 15/8/21.
//  Copyright © 2015年 qyma. All rights reserved.
//

import UIKit

class ViewController: UIViewController {


    override func viewDidLoad() {
//        super.viewDidLoad()
//        let array = [ "测试1", "测试2", "测试3", "测试4", "测试5","测试6", "测试7"]
//     let commbox = Commbox(frame: CGRect(x: 70, y: 10, width: 140, height: 100))
//        commbox.textField?.placeholder = "请点击选择"
//        let tableArray = NSMutableArray()
//        tableArray.addObject(array)
//        commbox.tableArray = tableArray
//        view.addSubview(commbox)
    }
    private var dropDownView:QYMDropDownView?
    private var flag:Bool = false

    @IBOutlet weak var clickButton: UIButton!
    @IBAction func clickClickMe(sender: AnyObject) {
        //设置数据 
        let array = [ "测试1", "测试2", "测试3", "测试4", "测试5","测试6", "测试6"]
        if  !flag {

            let  f:CGFloat = 150
            dropDownView = QYMDropDownView().initWithDropDown(sender as! UIButton, height: f, arrayList: array)
            dropDownView!.showList = true
            flag = true
        }else{
            
            dropDownView!.hideDropDown(sender as! UIButton)
             flag = false
            dropDownView!.showList = false
        }
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

