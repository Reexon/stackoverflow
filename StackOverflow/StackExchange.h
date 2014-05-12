//
//  StackExchange.h
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface StackExchange : NSObject

/*
 *  Array di oggetti Question
 */
@property (nonatomic,strong) NSMutableArray *questionList;

- (void) loadAllQuestions;

- (void) loadAllAnswers;

- (void) loadUnansweredQuestion;

- (void) showAllQuestions;

- (void) loadQuestionBySearchString: (NSString *)search;

- (void) addQuestionToFavorite: (NSString *)questionID;

- (void) removeQuestionFromFavorite: (NSString *)questionID;

- (void) upVoteAnswer: (int)answerID;

- (void) downVoteAnswer: (int)answerID;
@end
