//
//  Account.m
//  StackOverflow
//
//  Created by Loris D'antonio on 12/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "Account.h"

@implementation Account

@synthesize access_token;

- (id)initWithAccessToken:(NSString *)access_token{
    if(self == [self init]){
        self.access_token = access_token;
    }
    return self;
}
@end
