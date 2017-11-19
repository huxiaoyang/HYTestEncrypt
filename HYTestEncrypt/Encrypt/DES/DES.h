//
//  DES.h
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/19.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CommonCrypto/CommonCrypto.h>


@interface DES : NSObject


+ (NSString*)encryptWithContent:(NSString*)content
                           type:(CCOperation)type
                            key:(NSString*)aKey;

@end
