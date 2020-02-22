//
//  Contact.m
//  联系人
//
//  Created by 阿栋 on 2020/2/3.
//  Copyright © 2020 apple. All rights reserved.
//

#import "Contact.h"

@implementation Contact

//告诉系统归档哪些属性
-(void)encodeWithCoder:(NSCoder *)coder
{
    [coder encodeObject:self.name forKey:@"name"];
    [coder encodeObject:self.number forKey:@"number"];
    [coder encodeObject:self.email forKey:@"email"];
}

//告诉系统解档哪些属性
-(instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super init]) {
        self.name = [coder decodeObjectForKey:@"name"];
        self.number = [coder  decodeObjectForKey:@"number"];
        self.email = [coder decodeObjectForKey:@"email"];
    }
    return self;
}

@end
