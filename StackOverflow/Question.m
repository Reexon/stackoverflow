//
//  Question.m
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "Question.h"
#import "SO_Request.h"
#import "Constants.h"
#import "Answer.h"

@implementation Question

@synthesize answer_count,creation_date,is_answered,last_activity_date,last_edit_date,link,author,tag,score,question_id,title,view_count,answerList;

-(id)initWithJSONDictionary:(NSDictionary *)JSONDictionary{
    //non ho capito bene perchè vada messo questo if
    if(self = [self init]) {
        score               = [JSONDictionary objectForKey:@"score"];
        view_count          = [JSONDictionary objectForKey:@"view_count"];
        question_id         = [JSONDictionary objectForKey:@"question_id"];
        title               = [JSONDictionary objectForKey:@"title"];
        answer_count        = [JSONDictionary objectForKey:@"answer_count"];
        creation_date       = [[JSONDictionary objectForKey:@"creation_date"]doubleValue];
        is_answered         = [[JSONDictionary objectForKey:@"is_answered"]boolValue];
        last_activity_date  = [[JSONDictionary objectForKey:@"last_activity_date"] doubleValue];
        last_edit_date      = [[JSONDictionary objectForKey:@"last_edit_date"]doubleValue];
        link                = [JSONDictionary objectForKey:@"link"];
        author              = [ [Author alloc]initWithJSONDict:[JSONDictionary objectForKey:@"owner"] ];
        tag                 = [ [NSArray alloc]initWithArray:[JSONDictionary objectForKey:@"tags"] ];
    }
    return self;
}

/*
 * Preleva tutte le risposte alla domanda
 */
-(void)loadAnswer{
    NSDictionary *param = [[NSDictionary alloc]initWithObjectsAndKeys:@"asc",@"order",
                           @"votes",@"sort",
                           [NSNumber numberWithInt:20],@"pagesize",
                           @"stackoverflow",@"site",
                           nil];
    
    NSArray *quest_id = [[NSArray alloc]initWithObjects:question_id,nil];
    SO_Request *request = [[SO_Request alloc]initWithParameters:ANSWERS_TO_QUESTION questionID:quest_id parameters:param];
    
    
    //array di dizionari di risposte.
    NSArray *array = [request startRequest];

    //creo l'oggetto risposta e ne aggiungo tanti quante sono le risposte alla domadna
    for(NSDictionary *dict in array){
        Answer *answ = [[Answer alloc]initWithJSONDictionary:dict];
        [answerList addObject:answ];
    }
}

/*
 * Stampa le informazioni della domanda
 */
-(void)showQuestion{
    NSLog(@"Question id:%@",question_id);
    NSLog(@"view Count:%@",view_count);
    NSLog(@"Title:%@",title);
    NSLog(@"Answer Count:%@",answer_count);
    NSLog(@"Creation Date:%f",creation_date);
    NSLog(@"is Answered: %d",is_answered);
    NSLog(@"Last Activity:%f",last_activity_date);
    NSLog(@"Last Edit:%f",last_edit_date);
    NSLog(@"Score:%@",score);
    //NSLog(@"Link:%@",link);
    NSLog(@"Tag:%@",tag);
    NSLog(@"-------------------");
}

@end
