//
//  LoginViewController.m
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "LoginViewController.h"
#import "ContactViewController.h"
@interface LoginViewController ()
{
    //创造一个全局的缓冲圆圈（viewdidload和login都要用到）
    UIActivityIndicatorView *activityView;
}

//登录界面的五个控件
@property (weak, nonatomic) IBOutlet UITextField *nameField;
@property (weak, nonatomic) IBOutlet UITextField *passwordField;
@property (weak, nonatomic) IBOutlet UIButton *LoginButton;
@property (weak, nonatomic) IBOutlet UISwitch *remPassword;
@property (weak, nonatomic) IBOutlet UISwitch *autoLogin;

@end

@implementation LoginViewController
- (IBAction)remPassword:(UISwitch *)sender {
    if(!sender.isOn){
        [self.autoLogin setOn:NO animated:YES];
    }
    
}
- (IBAction)autoLogin:(UISwitch *)sender {
    if (sender.isOn) {
        [self.remPassword setOn:YES animated:YES];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
        
        //监听账户密码的文本框是否发生变化（编辑状态改变）
    [self.nameField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
    [self.passwordField addTarget:self action:@selector(textChange) forControlEvents:UIControlEventEditingChanged];
        
        //监听登录按钮
    [self.LoginButton addTarget:self action:@selector(login) forControlEvents:UIControlEventTouchUpInside];
    
    
     
        //恢复开关状态
    NSUserDefaults *rem = [NSUserDefaults standardUserDefaults];
    self.remPassword.on = [rem boolForKey:@"remPasswordKey"];
    self.autoLogin.on = [rem boolForKey:@"autoLoginKey"];
    
        //恢复文本框
    self.nameField.text = [rem objectForKey:@"nameFieldKey"];
    if (self.remPassword.isOn)
    {
        self.passwordField.text = [rem objectForKey:@"passwordFieldKey"];
    }
    
    if(self.autoLogin.isOn)
    {
        [self login];
    }
    
    
        //登录时缓冲（模拟网络请求）
    activityView = [[UIActivityIndicatorView alloc]initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleLarge];
    activityView.color = [UIColor blueColor];
    activityView.backgroundColor = [UIColor yellowColor];
    activityView.center = CGPointMake(self.view.frame.size.width/2,self.view.frame.size.height/2+100);
    [self.view addSubview:activityView];
        
    [self textChange];
    
    }





-(void)login{
    //设置转圈时间
    [activityView startAnimating];
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.8 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
    if ([self.nameField.text isEqualToString:@"1"] && [self.passwordField.text isEqualToString:@"1"])
    {
        //用手动型segue进行页面跳转（主界面）
        [self performSegueWithIdentifier:@"login2contacts" sender:nil];
        //保存状态(偏好设置）
        NSUserDefaults *rem = [NSUserDefaults standardUserDefaults];
        [rem setBool:self.remPassword.isOn forKey:@"remPasswordKey"];
        [rem setBool:self.autoLogin.isOn forKey:@"autoLoginKey"];
        [rem setObject:self.nameField.text forKey:@"nameFieldKey"];
        [rem setObject:self.passwordField.text forKey:@"passwordFieldKey"];
        [rem synchronize];
}
    else
    {
        // 用手动型segue进行页面跳转（错误页面）
        [self performSegueWithIdentifier:@"error" sender:nil];
    }
        //停止转圈
        [self->activityView stopAnimating];
    });
        
}

    //利用segue来进行传值(顺传)
-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if ([segue.identifier isEqualToString:@"login2contacts"])
    {
        //获取用户名（即输入的用户名传给contact.username）
        ContactViewController *contact = segue.destinationViewController;
        contact.username = self.nameField.text;
    }
    if([segue.identifier isEqualToString:@"error"])
    {
            
    }
}

    //判断文本框是否有字了
-(void)textChange{
    if(self.nameField.text.length>0 && self.passwordField.text.length>0)
    {
        //两个文本框都有内容
        self.LoginButton.enabled = YES;
    }
    else
    {
        self.LoginButton.enabled = NO;
    }
}

@end
