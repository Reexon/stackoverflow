//
//  StackExchange.m
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "StackExchange.h"
#import "SO_Request.h"
#import "Question.h"
#import "Answer.h"
#import "Constants.h"

@implementation StackExchange

@synthesize questionList;

/*
 * Carica domande dal sito Stackoverflow
 */
-(void)loadAllQuestions{
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           30,@"pagesize",
                           @"stackoverflow",@"site",
                           nil];
    SO_Request *request = [[SO_Request alloc]initWithType:ALL_QUESTION parameters:param];
    
    NSArray *arrayDict = [request startRequest];
    questionList = [NSMutableArray new];
    
    for(NSDictionary *dict in arrayDict){
        Question *quest = [[Question alloc]initWithJSONDictionary:dict];
        [questionList addObject:quest];
    }
    
}

/*
 *  Carico le risposte di tutte le domande caricate
 */
-(void)loadAllAnswers{
    
    for(Question *quest in questionList){
        [quest loadAnswer];
    }

}

/*
 *  Visualizzo tutte le domande (Per Debug)
 */
-(void)showAllQuestions{
    
    for(Question *quest in questionList){
        [quest showQuestion];
        
        NSArray *test = [quest answerList];
        for(Answer *lol in test){
            [lol showAnswer];
        }
    }
    
}

/*
 *  Carico una lista di domande che non hanno ancora ricevuto risposta
 */
-(void)loadUnansweredQuestion{
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           [NSNumber numberWithInt:20],@"pagesize",
                           @"stackoverflow",@"site",
                           nil];
    
    SO_Request *request = [[SO_Request alloc]initWithType:UNANSWERED_QUESTIONS parameters:param];
    
    NSArray *arrayDict = [request startRequest];
    questionList = [NSMutableArray new];
    
    for(NSDictionary *dict in arrayDict){
        Question *quest = [[Question alloc]initWithJSONDictionary:dict];
        [questionList addObject:quest];
    }
}

/**
    Data una stringa, cerca le domande che contengono la stringa nel titolo
 
    @param NSString search
            Stringa da ricercare
*/
-(void)loadQuestionBySearchString:(NSString *)search{
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           [NSNumber numberWithInt:20],@"pagesize",
                           search,@"intitle",
                           @"stackoverflow",@"site",
                           nil];
    SO_Request *request = [[SO_Request alloc]initWithType:SEARCH_QUESTIONS parameters:param ];
    
    NSArray *arrayDict = [request startRequest];
    questionList = [NSMutableArray new];
    
    for(NSDictionary *dict in arrayDict){
        Question *quest = [[Question alloc]initWithJSONDictionary:dict];
        [questionList addObject:quest];
    }
}

@end
