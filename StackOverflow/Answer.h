//
//  Answer.h
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Answer : NSObject

@property (readonly) int answer_id;
@property (readonly) NSTimeInterval creation_date;
@property (readonly) BOOL is_accepted;
@property (readonly) NSTimeInterval last_activity_date;
@property (readonly) NSString *body;

-(id)initWithJSONDictionary:(NSDictionary *)JSONDictionary;
-(void)showAnswer;
@end
