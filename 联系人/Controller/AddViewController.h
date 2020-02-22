//
//  AddViewController.h
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Contact.h"
NS_ASSUME_NONNULL_BEGIN

@class AddViewController;
@protocol AddViewControllerDelegate <NSObject>
@optional
//代理的方法
-(void)addViewController:(AddViewController *)addViewController withContact:(Contact *)contact;

@end

@interface AddViewController : UIViewController
//代理的属性
@property(nonatomic,weak) id<AddViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
