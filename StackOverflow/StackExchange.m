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

/**
    @abstract Carica domande dal sito Stackoverflow
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

/**
    @abstract Carico le risposte di tutte le domande caricate
 */
-(void)loadAllAnswers{
    
    for(Question *quest in questionList){
        [quest loadAnswer];
    }

}

/**
    @abstract Visualizzo tutte le domande (Per Debug)
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

/**
    @abstract Carico 20 delle ultime domande con + votazioni
 */
-(void)loadUnansweredQuestion{
    
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           [NSNumber numberWithInt:20],@"pagesize",
                           @"stackoverflow",@"site",
                           nil];
    
    SO_Request *request = [[SO_Request alloc]initWithType:UNANSWERED_QUESTIONS parameters:param];
    
    //array di dizionari ritornato dalla richiesta all'API
    NSArray *arrayDict = [request startRequest];
    
    //array finale di oggetti Question
    questionList = [NSMutableArray new];
    
    for(NSDictionary *dict in arrayDict){
        Question *quest = [[Question alloc]initWithJSONDictionary:dict];
        [questionList addObject:quest];
    }
}

/**
    @abstract Data una stringa, cerca le domande che contengono la stringa nel titolo
 
    @param NSString search
            Stringa da ricercare
 
    @see https://api.stackexchange.com/docs/search
*/
-(void)loadQuestionBySearchString:(NSString *)search{
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           [NSNumber numberWithInt:20],@"pagesize",
                           search,@"intitle",
                           @"stackoverflow",@"site",
                           nil];
    SO_Request *request = [[SO_Request alloc]initWithType:SEARCH_QUESTIONS parameters:param ];
    
    //array di dizionari ritornato dalla richiesta all'API
    NSArray *arrayDict = [request startRequest];
    
    //array finale di oggetti Question
    questionList = [NSMutableArray new];
    
    for(NSDictionary *dict in arrayDict){
        Question *quest = [[Question alloc]initWithJSONDictionary:dict];
        [questionList addObject:quest];
    }
}
/**
    @abstract Dato l'id della domanda, la AGGIUNGE tra i preferiti
    
    @param questionID NSString
                l'id della domanda da inserire tra i preferiti
 
    @see https://api.stackexchange.com/docs/favorite-question

 */
-(void)addQuestionToFavorite:(NSString *)questionID{
    SO_Request *request = [SO_Request new];
    [request addQuestionToFavorite:questionID];
}
/**
    @abstract Dato l'id della domanda, la RIMUOVE tra i preferiti
 
    @param questionID NSString
            l'id della domanda da rimuovere dai preferiti
 
    @see https://api.stackexchange.com/docs/undo-favorite-question
 */
-(void)removeQuestionFromFavorite:(NSString *)questionID{
    SO_Request *request = [SO_Request new];
    [request removeQuestionFromFavorite:questionID];
}

/**
    @abstract invia voto positivo per la risposta
 
    @param answerID
            l'id della risposta da votare
 
    @see https://api.stackexchange.com/docs/upvote-answer
 */
-(void)upVoteAnswer:(int)answerID{
    SO_Request *request = [SO_Request new];
    [request upVoteAnswer:answerID];
}

/**
    @abstract invia voto negativo per la risposta
 
    @param answerID
        l'id della risposta da votare
 
    @see https://api.stackexchange.com/docs/undo-upvote-answer
 */
-(void)downVoteAnswer:(int)answerID{
    SO_Request *request = [SO_Request new];
    [request downVoteAnswer:answerID];
}

/**
 @abstract serve per de-authorizzare l'applicazione
 
 @param access_token
 token dell'user da cui si vuole rimuovere l'autorizzazione dell'applicazione (logout)
 
 @see https://api.stackexchange.com/docs/application-de-authenticate
 */
-(void)deauthenticate:(NSString *)access_token{
    SO_Request *request = [SO_Request new];
    [request deauthenticate:access_token];
}
@end
