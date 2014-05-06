//
//  Answer.m
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "Answer.h"

@implementation Answer

@synthesize answer_id,creation_date,last_activity_date,body,is_accepted;

-(id)initWithJSONDictionary:(NSDictionary *)JSONDictionary{
    if(self = [self init]){
        answer_id = [[JSONDictionary objectForKey:@"answer_id"]integerValue];
        creation_date = [[JSONDictionary objectForKey:@"creation_date"]doubleValue];
        last_activity_date =[[JSONDictionary objectForKey:@"last_activity_date"]doubleValue];
        is_accepted = [[JSONDictionary objectForKey:@"is_accepted"]boolValue];
        body = [JSONDictionary objectForKey:@"body"];
    }
    return self;
}

-(void)showAnswer{
    NSLog(@"Risposta: %@",body);
}
@end
