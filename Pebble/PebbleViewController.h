//
//  PebbleViewController.h
//  Pebble
//
//  Created by techion on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PebbleViewController : UIViewController <UIWebViewDelegate> {
    IBOutlet UIWebView *webView;    
}

@property (nonatomic, retain) IBOutlet UIWebView *webView;

- (IBAction)PJBold:(id)sender;
- (IBAction)PJItalic:(id)sender;
- (IBAction)PJUnderline:(id)sender;
- (IBAction)PJUnorderedList:(id)sender;
- (IBAction)PJOrderedList:(id)sender;
- (IBAction)PJTest:(id)sender;

- (NSString *)PJGetContent;
- (void)PJSetContent: (NSString *)text;
- (NSString *)getDocumentsDirectory;
- (void)Save;
- (void)Load;

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest: (NSURLRequest*)req  navigationType:(UIWebViewNavigationType)navigationType;


@end
