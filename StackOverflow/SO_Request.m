//
//  SO_Request.m
//  StackOverflow
//
//  Created by Loris D'antonio on 01/05/14.
//  Copyright (c) 2014 Loris D'antonio. All rights reserved.
//

#import "SO_Request.h"
#import "Question.h"
#import "Constants.h"

@implementation SO_Request

@synthesize endpoint;

/**
    @abstract il suo scopo principale è quello di generarmi il link dell'API corretto da richiamare (endpoint)
 */
- (id)initWithType:(int)type parameters:(NSDictionary *)dict{
    if(self = [self init]){
        
        endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
        switch (type) {
            case ALL_QUESTION:
                [endpoint appendFormat:@"%@?",QUESTIONS];
            break;
                
            case UNANSWERED_QUESTIONS:
                [endpoint appendFormat:@"%@/no-answers?",QUESTIONS];
            break;
                
            case SEARCH_QUESTIONS:
                [endpoint appendFormat:@"%@?",SEARCH];
                break;
            default:
                break;
        }
        
        /*
         * scansiono il dizionario passato come parametro, per aggiungere i parametri GET all'endpoint
         */
        for(NSString *key in [dict allKeys]){
            
            if([key isEqualToString: @"site"])
                [endpoint appendFormat:@"%@=%@",key,[dict objectForKey:key]];
            else
                [endpoint appendFormat:@"%@=%@&",key,[dict objectForKey:key]];
        }
        
        NSLog(@"%@",endpoint);
    }
    
    return self;
    
}

/**
 @abstract Costruttore che uso quando voglio avere le risposte di una specifica domanda, o di un gruppo di domande di cui conosco l'ID
 
 @param type
        indica il tipo di richiesta che si sta facendo, per ogni tipo di richiesta esisterà un define nel file Constants.h
 
 @param ids
        un array che contiene gli id delle domande di cui si vogliono prelevare le risposte
 
 @param dict
        dizionario che conterra i parametri aggiungivi (filtri)
 
 @see ANSWER_TO_QUESTION https://api.stackexchange.com/docs/answers-by-ids
 */
-(id)initWithParameters:(int)type questionID:(NSArray *)ids parameters:(NSDictionary *)dict{
    if(self =[self init]){
        
        switch(type){
            case ANSWERS_TO_QUESTION:
                endpoint = [NSMutableString stringWithFormat:@"%@/%@/%@/",API_STACKEXCHANGE,API_VERSION,QUESTIONS];
                for(int i =0; i< ids.count ; i++){
                    if(i == ids.count-1)
                        [endpoint appendFormat:@"%@/",[ids objectAtIndex:i]];
                    else
                        [endpoint appendFormat:@"%@;",[ids objectAtIndex:i]];
                }
                [endpoint appendFormat:@"%@?",ANSWERS];
                
                break;
        }
        
        //aggiungo i parametri delle variabili GET
        for(NSString *key in [dict allKeys]){
            [endpoint appendFormat:@"%@=%@",key,[dict objectForKey:key]];
        }
    }
    
    return self;
}


- (NSArray *)startRequest{
    return [self sendRequest:[NSURL URLWithString:endpoint]];
}

/**
    @abstract metodo che viene richiamato ogni volta che viene inviata una richiesta
 */
- (NSArray *)sendRequest:(NSURL *)url{
    // Creo una richiesta dall'url
    NSURLRequest *request = [NSURLRequest requestWithURL:url
                                             cachePolicy:NSURLRequestReloadIgnoringLocalAndRemoteCacheData
                                         timeoutInterval:30.0];
    
    // Prelevo la risposta del server
    NSURLResponse *response;
    NSData *data = [NSURLConnection sendSynchronousRequest:request returningResponse:&response error:nil];
    
    // Creo un dizionario dalla risposta JSON del server
    NSDictionary *jsonDictionary = [NSJSONSerialization JSONObjectWithData:data options:0 error:nil];
    
    // Creo un array dei oggetti "items"
    NSArray *array = [jsonDictionary objectForKey:@"items"];
    
    return array;
}

/**
 @abstract Dato l'id della domanda, la AGGIUNGE tra i preferiti
 
 @param questionID NSString
 l'id della domanda da inserire tra i preferiti
 
 @see https://api.stackexchange.com/docs/favorite-question
 
 */
-(void)addQuestionToFavorite:(NSString *)questionID{
    endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
    [endpoint appendFormat:@"questions/%@/favorite",questionID];
    
    //l'access_token va prelevato in modo dinamico, non inserito così
    NSString *myRequestString = [NSString stringWithFormat:@"&access_token=iShOSvtObis(N8sl7uPcLQ))&key=%@&site=stackoverflow",APP_KEY];
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: endpoint]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:myRequestData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSLog(@"%@",[NSString stringWithUTF8String:[returnData bytes]]);
    
}
/**
 @abstract Dato l'id della domanda, la RIMUOVE tra i preferiti
 
 @param questionID NSString
 l'id della domanda da rimuovere dai preferiti
 
 @see https://api.stackexchange.com/docs/undo-favorite-question
 */
-(void)removeQuestionFromFavorite:(NSString *)questionID{
    endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
    [endpoint appendFormat:@"questions/%@/favorite/undo",questionID];
    
    //l'access_token va prelevato in modo dinamico, non inserito così
    NSString *myRequestString = [NSString stringWithFormat:@"&access_token=iShOSvtObis(N8sl7uPcLQ))&key=%@&site=stackoverflow",APP_KEY];
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: endpoint]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:myRequestData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSLog(@"%@",[NSString stringWithUTF8String:[returnData bytes]]);
    
}
/**
 @abstract invia voto positivo per la risposta
 
 @param answerID
 l'id della risposta da votare
 
 @see https://api.stackexchange.com/docs/upvote-answer
 */
-(void)upVoteAnswer:(int)answerID{
    endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
    [endpoint appendFormat:@"answers/%d/upvote",answerID];
    
    //l'access_token va prelevato in modo dinamico, non inserito così
    NSString *myRequestString = [NSString stringWithFormat:@"&access_token=iShOSvtObis(N8sl7uPcLQ))&key=%@&site=stackoverflow",APP_KEY];
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: endpoint]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:myRequestData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSLog(@"%@",[NSString stringWithUTF8String:[returnData bytes]]);
}
/**
 @abstract invia voto negativo per la risposta
 
 @param answerID
 l'id della risposta da votare
 
 @see https://api.stackexchange.com/docs/undo-upvote-answer
 */
-(void)downVoteAnswer:(int)answerID{
    endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
    [endpoint appendFormat:@"answers/%d/upvote/undo",answerID];
    
    //l'access_token va prelevato in modo dinamico, non inserito così
    NSString *myRequestString = [NSString stringWithFormat:@"&access_token=iShOSvtObis(N8sl7uPcLQ))&key=%@&site=stackoverflow",APP_KEY];
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: endpoint]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:myRequestData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSLog(@"%@",[NSString stringWithUTF8String:[returnData bytes]]);
}

/**
 @abstract serve per de-authorizzare l'applicazione
 
 @param access_token
        token dell'user da cui si vuole rimuovere l'autorizzazione dell'applicazione (logout)
 
 @see https://api.stackexchange.com/docs/application-de-authenticate
 */
-(void)deauthenticate:(NSString *)access_token{
    endpoint = [NSMutableString stringWithFormat:@"%@/%@/",API_STACKEXCHANGE,API_VERSION];
    [endpoint appendFormat:@"apps/%@/de-authenticate",access_token];
    
    
    //l'access_token va prelevato in modo dinamico, non inserito così
    NSString *myRequestString = [NSString stringWithFormat:@"&access_token=iShOSvtObis(N8sl7uPcLQ))&key=%@",APP_KEY];
    NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
    
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: endpoint]];
    [request setHTTPMethod: @"POST"];
    [request setHTTPBody:myRequestData];
    [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
    
    NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
    NSLog(@"%@",[NSString stringWithUTF8String:[returnData bytes]]);
}
@end

