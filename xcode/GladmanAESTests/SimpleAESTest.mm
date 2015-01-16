//
//  SimpleAESTest.m
//  GladmanAES
//
//  Created by James Tomson on 1/16/15.
//  Copyright (c) 2015 Medidata Solutions, Inc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <XCTest/XCTest.h>

#include "aescpp.h"

#include <string>
#include <vector>

@interface SimpleAESTest : XCTestCase

@end

@implementation SimpleAESTest

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testRoundTrip {
    using namespace std;
    
    [self measureBlock:^{
        
        string s = "Oh hai there";
        string key = "8675309Jenny";
        
        string crypted;
        crypted.resize(s.size());
        
        {
            unsigned char iv[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
            AESencrypt cryptor((const unsigned char*)key.data());
            
            cryptor.ofb_crypt((unsigned char*)s.c_str(),
                              (unsigned char*)&crypted[0],
                              (int32_t)s.size(),
                              iv);
        }
        
        XCTAssertFalse(s == crypted, @"Encrypted string does not equal the original string");
        
        string plainText;
        plainText.resize(crypted.size());
        
        {
            unsigned char iv[16] = {0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15};
            AESencrypt cryptor((const unsigned char*)key.data());
            cryptor.ofb_crypt((unsigned char*)crypted.data(),
                              (unsigned char*)&plainText[0],
                              (int32_t)crypted.size(),
                              iv);
        }
        
        XCTAssert(s == plainText, @"Decrypted plaintext string equals the original string");
        
    }];
}

@end
