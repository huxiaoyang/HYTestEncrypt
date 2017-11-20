//
//  RSAEncryptor.m
//  HYTestEncrypt
//
//  Created by ucredit-XiaoYang on 2017/11/20.
//  Copyright © 2017年 xiaoyang. All rights reserved.
//

#import "RSAEncryptor.h"
#import <Security/Security.h>
#import <openssl/rsa.h>
#import <openssl/pem.h>


@implementation RSAEncryptor

+ (void)keyWith:(void(^)(NSString *pubKey, NSString *priKey))block {
    
    /* 产生RSA密钥 */
    RSA *rsa = NULL;
    rsa = RSA_new();
    
    //产生一个模为num位的密钥对，e为公开的加密指数，一般为65537（0x10001）
    /* Deprecated version */
    //    rsa = RSA_generate_key(1024,0x10001,NULL,NULL);
    
    /* New version */
    BIGNUM *bne = BN_new();
    unsigned int e = RSA_3;
    int result = BN_set_word(bne, e);
    result = RSA_generate_key_ex(rsa, 1024, bne, NULL);
    
    // 路径
    NSString *documentsPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
    
    /* 提取公钥字符串 */
    // 最终存储的地方，所以需要创建一个路径去存储字符串
    NSString *pubPath = [documentsPath stringByAppendingPathComponent:@"PubFile.txt"];
    FILE* pubWrite = NULL;
    pubWrite = fopen([pubPath UTF8String], "wb");
    if(pubWrite == NULL)
        NSLog(@"Read Filed.");
    else
    {
        PEM_write_RSA_PUBKEY(pubWrite,rsa);
        PEM_write_RSA_PUBKEY(stdout,rsa);
        fclose(pubWrite);
    }
    
    NSString *str=[NSString stringWithContentsOfFile:pubPath encoding:NSUTF8StringEncoding error:nil];
    str = [str stringByReplacingOccurrencesOfString:@"-----BEGIN PUBLIC KEY-----" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"-----END PUBLIC KEY-----" withString:@""];
    str = [str stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    /*提取私钥字符串*/
    NSString *priPath = [documentsPath stringByAppendingPathComponent:@"PriFile.txt"];
    FILE *priWtire = NULL;
    priWtire = fopen([priPath UTF8String], "wb");
    
    EVP_PKEY *pkey = NULL;
    if (priWtire == NULL) {
        NSLog(@"Read Filed.");
    }else {
        //函数使用PKCS#8标准保存EVP_PKEY里面的私钥到文件或者BIO中，并采用PKCS#5
        //v2.0的标准加密私钥。enc参数定义了使用的加密算法。跟其他PEM的IO函数不一样的是，本函数的加密是基于PKCS#8层次上的，而不是基于PEM信息字段的，所以这两个函数也是单独实现的函数，而不是宏定义函数。如果enc参数为NULL，那么就不会执行加密操作，只是使用PKCS#8私钥 信息结构。成功执行返回大于0 的数，否则返回0。
        pkey = EVP_PKEY_new();
        EVP_PKEY_assign_RSA(pkey, rsa);
        PEM_write_PKCS8PrivateKey(priWtire, pkey, NULL, NULL, 0, 0, NULL);
        PEM_write_PKCS8PrivateKey(stdout, pkey, NULL, NULL, 0, 0, NULL);
        fclose(priWtire);
    }
    NSString *priStr=[NSString stringWithContentsOfFile:priPath encoding:NSUTF8StringEncoding error:nil];
    priStr = [priStr stringByReplacingOccurrencesOfString:@"-----BEGIN PRIVATE KEY-----" withString:@""];
    priStr = [priStr stringByReplacingOccurrencesOfString:@"-----END PRIVATE KEY-----" withString:@""];
    priStr = [priStr stringByReplacingOccurrencesOfString:@"\n" withString:@""];
    
    block(str,priStr);
}

@end
