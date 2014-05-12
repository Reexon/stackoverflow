//
//  SO_Request.h
//  StackOverflow
//
//  Created by Loris D'antonio on 01/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SO_Request : NSObject

//url a cui verrà fatta la richiesta
@property (nonatomic,weak) NSMutableString *endpoint;

- (id) initWithType:(int)type parameters:(NSDictionary *)dict;
- (id) initWithParameters: (int)type questionID:(NSArray *)ids parameters:(NSDictionary *)dict;

- (NSArray *)startRequest;
- (void) addQuestionToFavorite:(NSString *)questionID;
- (void) removeQuestionFromFavorite:(NSString *)questionID;
- (void) upVoteAnswer:(int)answerID;
- (void) downVoteAnswer:(int)answerID;
-(void) deauthenticate:(NSString *)access_token;
@end
