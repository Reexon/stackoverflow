//
//  Author.m
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "Author.h"

@implementation Author

@synthesize reputation,display_image,link,profile_name,user_type,user_id;

-(id)initWithJSONDict:(NSDictionary *)JSONDict{
    if(self = [self init]){
        reputation      = [JSONDict objectForKey:@"reputation"];
        display_image   = [JSONDict objectForKey:@"display_image"];
        link            = [JSONDict objectForKey:@"link"];
        profile_name    = [JSONDict objectForKey:@"profile_name"];
        user_type       = [JSONDict objectForKey:@"user_type"];
        user_id         = [JSONDict objectForKey:@"user_id"];
    }
    return self;
}
@end
