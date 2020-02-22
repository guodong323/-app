//
//  AddViewController.m
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "AddViewController.h"

@interface AddViewController ()
//添加页面的四个控件
@property (weak, nonatomic) IBOutlet UITextField *namefield;
@property (weak, nonatomic) IBOutlet UITextField *numberfield;
@property (weak, nonatomic) IBOutlet UITextField *emailfield;
@property (weak, nonatomic) IBOutlet UIButton *SaveButton;

@end

@implementation AddViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    //监听文本框
    [self.namefield addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    [self.numberfield addTarget:self action:@selector(textChanged) forControlEvents:UIControlEventEditingChanged];
    //监听保存按钮
    [self.SaveButton addTarget:self action:@selector(addClick) forControlEvents:UIControlEventTouchUpInside];
}
//添加按钮的点击事件
-(void)addClick{
    //判断代理方法是否能响应
    if([self.delegate respondsToSelector:@selector(addViewController:withContact:)]){
        Contact *con = [[Contact alloc]init];
        con.name = self.namefield.text;
        con.number = self.numberfield.text;
        con.email = self.emailfield.text;
        [self.delegate addViewController:self withContact:con];
    }
    //返回上一个页面
    [self.navigationController popViewControllerAnimated:YES];
}

//判断文本框是否有字了
-(void)textChanged{
    self.SaveButton.enabled = self.namefield.text.length>0 && self.numberfield.text.length>0;
}


@end
