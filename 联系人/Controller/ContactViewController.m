//
//  ContactViewController.m
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "ContactViewController.h"
#import "AddViewController.h"
#import "Contact.h"
#import "EditViewController.h"

@interface ContactViewController ()<AddViewControllerDelegate,EditViewControllerDelegate>
//创造一个数组
@property(nonatomic,strong)NSMutableArray *contacts;

@end

@implementation ContactViewController
//懒加载
-(NSMutableArray *)contacts{
    if(_contacts == nil)
    {
        _contacts = [NSMutableArray array];
    }
    return _contacts;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    //创建注销item
    UIBarButtonItem *item = [[UIBarButtonItem alloc]initWithTitle:@"注销" style:UIBarButtonItemStyleDone target:self action:@selector(logout)];
    //将item放在左边
    self.navigationItem.leftBarButtonItem = item;
    //将LoginViewController.m中获取的账户名顺传过来
    self.navigationItem.title =[NSString stringWithFormat:@"%@的联系人",self.username];
   //解档联系人信息
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"contact.data"];
   self.contacts = [NSKeyedUnarchiver unarchiveObjectWithFile:filePath];
}
//cell的个数
-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.contacts.count;
}
//cell的样子
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *cellID = @"contact_cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    //在cell上显示相应的信息
    cell.textLabel.text = [self.contacts[indexPath.row]name];
    cell.detailTextLabel.text = [self.contacts[indexPath.row]number];
    return cell;
}

//添加联系人的代理方法（逆传）
-(void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact{
    //把数据放入数组当中
    [self.contacts addObject:contact];
    //刷新页面
    [self.tableView reloadData];
    
    //归档联系人的信息(直接放在数组里）
    NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
    NSString *filePath = [docPath stringByAppendingPathComponent:@"contact.data"];
    [NSKeyedArchiver archiveRootObject:self.contacts toFile:filePath];
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    UIViewController *vc = segue.destinationViewController;
    
    if([vc isKindOfClass:[AddViewController class]]){
        AddViewController *add = (AddViewController *)vc;
        add.delegate = self;
    }
    else
    {
        EditViewController *edit = (EditViewController *)vc;
        
        edit.delegate =self;
        NSIndexPath *path = [self.tableView indexPathForSelectedRow];
        
        Contact *con = self.contacts[path.row];
        
        edit.contact = con;
    }
   
}

//滑动删除tableview
-(void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    [self.contacts removeObject:self.contacts[indexPath.row]];
    //刷新页面
    [self.tableView reloadData];
}

//编辑联系人的代理方法
-(void)editViewController:(EditViewController *)editViewController withContact:(Contact *)contact{
   
    [self.tableView reloadData];
    
    //归档联系人信息
      NSString *docPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES)[0];
     NSString *filePath = [docPath stringByAppendingPathComponent:@"contact.data"];
     [NSKeyedArchiver archiveRootObject:self.contacts toFile:filePath];
}

//创建底部弹窗（注销时）
-(void)logout{
    UIAlertController *alertcon = [UIAlertController alertControllerWithTitle:@"注销" message:@"您确定要注销么？" preferredStyle:UIAlertControllerStyleActionSheet];
    //创建两个按钮
    UIAlertAction *actionsure = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        [self.navigationController popViewControllerAnimated:YES];
    }];
    UIAlertAction *actioncancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    //加到上面去
    [alertcon addAction:actionsure];
    [alertcon addAction:actioncancel];
    [self presentViewController:alertcon animated:YES completion:nil];
    
    
}
@end
