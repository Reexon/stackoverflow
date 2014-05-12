//
//  StackOverflowTests.m
//  StackOverflowTests
//
//  Created by Loris D'antonio on 01/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <XCTest/XCTest.h>
#import "SO_Request.h"
#import "Answer.h"

@interface StackOverflowTests : XCTestCase

@end

@implementation StackOverflowTests

- (void)setUp
{
    [super setUp];
    // Put setup code here. This method is called before the invocation of each test method in the class.
}

- (void)tearDown
{
    // Put teardown code here. This method is called after the invocation of each test method in the class.
    [super tearDown];
}

- (void)testExample
{
   // XCTFail(@"No implementation for \"%s\"", __PRETTY_FUNCTION__);
}

- (void)testNumber
{
    int countNumber = 4;
    int result = [Answer countNumeber:4];
    NSAssert(result == 10, @"Il valore non è corretto 1");
    
    countNumber = 5;
    result = [Answer countNumeber:5];
    NSAssert(result == 10, @"Il valore non è corretto 2");
}

@end
