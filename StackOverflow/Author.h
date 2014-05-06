//
//  Author.h
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Author : NSObject

@property (readonly) NSNumber *reputation;
@property (readonly) NSNumber *user_id;
@property (readonly) NSString *user_type;
@property (readonly) NSString *profile_name;
@property (readonly) NSString *display_image;
@property (readonly) NSString *link;

-(id) initWithJSONDict:(NSDictionary *)JSONDict;

@end
