//
//  ViewController.m
//  StackOverflow
//
//  Created by Loris D'antonio on 01/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"
#import "SO_Request.h"
#import "Question.h"
#import "Author.h"
#import "StackExchange.h"
@interface ViewController ()

@end

@implementation ViewController

@synthesize webView;
- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [webView setDelegate:self];
    NSURLRequest *request = [NSURLRequest requestWithURL:[NSURL URLWithString:@"https://stackexchange.com/oauth/dialog?client_id=2975&scope=write_access,no_expiry,private_info&redirect_uri=https://stackexchange.com/oauth/login_success"]];
   [webView loadRequest:request];
   

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
 * usato per testare alcuni metodi
 */
- (IBAction)sendRequest:(id)sender {
    StackExchange *SE = [StackExchange new];
    
    //[SE loadQuestionBySearchString:@"CSS"];
    //[SE showAllQuestions];
}

- (void)updateAddress:(NSURLRequest*)request
{
    NSURL* url = [request mainDocumentURL];
    NSString* absoluteString = [url absoluteString];
    self.addressField.text = absoluteString;
    
    if([absoluteString rangeOfString:@"access_token"].length > 0){
        NSString *access_token = [absoluteString componentsSeparatedByString:@"access_token="][1];
        
        /*  access_token contiene il nostro token che ci interessa.
         *  creo l'oggetto Account, e memorizzo il token
         *  passo alla schermata successiva.
         */
    }
}

#pragma mark - Optional UIWebViewDelegate delegate methods
- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    [self updateAddress:request];
    return YES;
}

- (void)webViewDidStartLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

- (void)webView:(UIWebView *)webView didFailLoadWithError:(NSError *)error
{
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
}

@end
