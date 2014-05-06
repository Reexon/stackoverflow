//
//  Question.h
//  StackOverflow
//
//  Created by Loris D'antonio on 04/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Author.h"
@interface Question : NSObject

/*
 * informazioni generali riguardo la domanda
 */

//numero di risposte
@property (readonly) NSNumber *answer_count;

//id della domanda
@property (readonly) NSNumber *question_id;

//contiene la data di creazione della domanda
@property (readonly) NSTimeInterval creation_date;

//true/false se è presente una risposta per la domanda
@property (readonly) BOOL is_answered;

@property (readonly) NSTimeInterval last_activity_date;
@property (readonly) NSTimeInterval last_edit_date;

//link alla domanda
@property (readonly) NSString *link;
@property (readonly) NSNumber *score;

//numero totali di visualizzazione
@property (readonly) NSNumber *view_count;

//titolo
@property (readonly) NSString *title;

//i tag della domanda
@property (readonly) NSArray *tag;

//lista delle risposte (array di oggetti Answer)
@property (readonly) NSMutableArray *answerList;

//oggetto Autore;
@property (readonly) Author *author;

-(id) initWithJSONDictionary: (NSDictionary *)JSONDictionary;

-(void) loadAnswer;

-(void) showQuestion;

@end
