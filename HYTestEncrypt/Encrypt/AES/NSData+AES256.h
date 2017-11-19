//
//  NSData+AES256.h
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/19.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSData (AES256)

/*
 加密
 (NSString*)key 32位秘钥
 返回加密后的 NSData
 */
- (NSData*)AES256EncryptWithKey:(NSString*)key ;

/*
 解密
 (NSString*)key 32位秘钥
 返回解密后的 NSData
 */
- (NSData*)AES256DecryptWithKey:(NSString*)key ;

@end
