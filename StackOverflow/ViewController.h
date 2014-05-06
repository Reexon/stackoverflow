//
//  ViewController.h
//  StackOverflow
//
//  Created by Loris D'antonio on 01/05/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ViewController : UIViewController<UIWebViewDelegate>
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UILabel *addressField;
- (void)updateAddress:(NSURLRequest*)request;
@end
