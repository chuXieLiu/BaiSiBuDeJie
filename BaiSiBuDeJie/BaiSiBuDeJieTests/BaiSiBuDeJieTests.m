//
//  BaiSiBuDeJieTests.m
//  BaiSiBuDeJieTests
//
//  Created by c_xie on 16/3/7.
//  Copyright © 2016年 CX. All rights reserved.
//

#import <XCTest/XCTest.h>

#import "BSHelper.h"
#import "NSDate+BSExtension.h"

@interface BaiSiBuDeJieTests : XCTestCase

@end

@implementation BaiSiBuDeJieTests

- (void)setUp {
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown {
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample {
    // This is an example of a functional test case.
    // Use XCTAssert and related functions to verify your tests produce the correct results.
    NSDate *date = [[BSHelper dateFormatter] dateFromString:@"2016-03-11 17:28:21"];
    
    XCTAssertTrue([date isToday],"-------------------");
}

- (void)testPerformanceExample {
    // This is an example of a performance test case.
    [self measureBlock:^{
        // Put the code you want to measure the time of here.
    }];
}

@end
