//
//  RSAEncryptor.h
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/20.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface RSAEncryptor : NSObject

+ (void)keyWith:(void(^)(NSString *pubKey, NSString *priKey))block;

@end
