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

//
@property (nonatomic,weak) NSNumber *page;

//numero risultati da restituire
@property (nonatomic,weak) NSNumber *page_size;

@property NSTimeInterval *fromDate;

@property NSTimeInterval *toDate;

//tipo di ordine (desc,asc)
@property (nonatomic,weak) NSString *order;

//activity,votes,creation
@property (nonatomic,weak) NSString *sort;

@property (nonatomic,weak) NSString *site;

- (id)initWithType:(int)type parameters:(NSDictionary *)dict;
- (id)initWithParameters: (int)type questionID:(NSArray *)ids parameters:(NSDictionary *)dict;

- (NSArray *)startRequest;

@end
