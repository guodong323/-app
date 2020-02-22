//
//  EditViewController.m
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "EditViewController.h"
#import "Contact.h"
@interface EditViewController ()
//编辑联系人界面的几个控件
@property (weak, nonatomic) IBOutlet UITextField *name;
@property (weak, nonatomic) IBOutlet UITextField *number;
@property (weak, nonatomic) IBOutlet UITextField *email;
@property (weak, nonatomic) IBOutlet UIButton *EditButton;


@end

@implementation EditViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //设置初始的文本框内容（顺传）
    self.name.text = self.contact.name;
    self.number.text = self.contact.number;
    self.email.text = self.contact.email;
    
    [self.EditButton addTarget:self action:@selector(saveClick) forControlEvents:UIControlEventTouchUpInside];
    
}
//编辑按钮的点击事件
- (IBAction)editClick:(UIBarButtonItem *)sender {
    if ([sender.title isEqualToString:@"编辑"])
    {
        //改变文本框以及item的状态
        sender.title = @"取消";
        self.name.enabled =YES;
        self.number.enabled =YES;
        self.email.enabled = YES;
        self.EditButton.hidden = NO;
    }
    else
    {
        sender.title = @"编辑";
        self.name.enabled =NO;
        self.number.enabled =NO;
        self.email.enabled = NO;
        self.EditButton.hidden = YES;
        
        //恢复到传过来的模型数据
        self.name.text = self.contact.name;
        self.number.text = self.contact.number;
        self.email.text = self.contact.email;
    }
    
}

//点击保存按钮的点击事件
-(void)saveClick{
    
    Contact *con = [[Contact alloc]init];
    self.contact.name = self.name.text;
    self.contact.number = self.number.text;
    self.contact.email = self.email.text;
    
    if ([self.delegate respondsToSelector:@selector(editViewController:withContact:)]) {
        [self.delegate editViewController:self withContact:con];
    }
    [self.navigationController popViewControllerAnimated:YES];
}


@end
