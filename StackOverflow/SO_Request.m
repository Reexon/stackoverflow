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

@synthesize endpoint,page,page_size,fromDate,toDate,order,sort,site;

/*
 * il suo scopo principale è quello di generarmi il link dell'endpoint da richiamare
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

/*
 * genero e invio la richiesta
 * restituisco un array di dizionari
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

@end

