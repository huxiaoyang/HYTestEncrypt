//
//  AES.m
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/19.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import "AES.h"
#import "NSString+MD5.h"
#import "NSData+AES256.h"


@interface AES()

@property (nonatomic, strong) NSString *key;

@end


@implementation AES

#pragma mark -获取安全钥匙
+(NSString*) getSecurityKey {
    return @"加密的密匙";
}

#pragma mark -更加密码密匙初始化
-(instancetype)initWithKey:(NSString *)key {
    self = [super init];
    if (self) {
        _key = key;
    }
    return self;
}

#pragma mark -加密
-(NSString *)AES256EncryptWithString:(NSString *)str {
    NSData *dt1 = [str dataUsingEncoding:NSUTF8StringEncoding];
    
    NSData *dt2 = [dt1 AES256EncryptWithKey:[self.key MD5]];
    
    NSString *str2 = [dt2 base64EncodedStringWithOptions:NSDataBase64Encoding64CharacterLineLength];
    return str2;
}

#pragma mark -解密
-(NSString *) AES256DecryptWithString:(NSString *) str
{
    NSData *dt3 = [[NSData alloc] initWithBase64EncodedString:str options:NSDataBase64DecodingIgnoreUnknownCharacters];
    
    NSData *dt4 = [dt3 AES256DecryptWithKey:[self.key MD5]];
    
    NSString *str4 = [[NSString alloc] initWithData:dt4 encoding:NSUTF8StringEncoding];
    return str4;
}

@end
