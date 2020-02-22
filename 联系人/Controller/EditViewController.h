//
//  EditViewController.h
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
NS_ASSUME_NONNULL_BEGIN

@class EditViewController;
@protocol EditViewControllerDelegate <NSObject>
@optional
//代理要执行的方法，把模型的信息传过去
-(void)editViewController:(EditViewController *)editViewController withContact:(Contact *)contact;

@end
@interface EditViewController : UIViewController

@property(nonatomic,strong) Contact *contact;
@property(nonatomic,weak) id<EditViewControllerDelegate> delegate;
@end

NS_ASSUME_NONNULL_END
