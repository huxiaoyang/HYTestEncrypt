//
//  AES.h
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/19.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface AES : NSObject

#pragma mark -根据密匙初始化
-(instancetype) initWithKey:(NSString *) key;

#pragma mark -加密
-(NSString *) AES256EncryptWithString:(NSString *) str;

#pragma mark -解密
-(NSString *) AES256DecryptWithString:(NSString *) str;

#pragma mark -获取安全密匙
+(NSString*) getSecurityKey;

@end
