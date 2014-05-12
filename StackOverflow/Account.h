//
//  Account.h
//  StackOverflow
//
//  Created by Loris D'antonio on 12/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Account : NSObject

@property (nonatomic,weak) NSString *access_token;

- (id)initWithAccessToken:(NSString *)access_token;

@end
