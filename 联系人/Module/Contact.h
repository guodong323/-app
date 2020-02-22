//
//  Contact.h
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface Contact : NSObject <NSCoding>
//模型的属性
@property(nonatomic,copy) NSString *name;
@property(nonatomic,copy) NSString *number;
@property(nonatomic,copy) NSString *email;
@end

NS_ASSUME_NONNULL_END
