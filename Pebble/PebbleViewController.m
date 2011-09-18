//
//  PebbleViewController.m
//  Pebble
//
//  Created by techion on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PebbleViewController.h"

@implementation PebbleViewController

@synthesize webView;

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Release any cached data, images, etc that aren't in use.
}

#pragma mark - View lifecycle

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
/*
    CGRect webFrame = [[UIScreen mainScreen] applicationFrame];  
    webView = [[UIWebView alloc] initWithFrame:webFrame];  
    webView.backgroundColor = [UIColor whiteColor];  
    [self.view addSubview:webView];
 */
    
    /*
    NSString *html = @"<html><head><title>Hello World</title></head><body><p>Hello <b>World!</b>!</p></body></html>";  
    [webView loadHTMLString:html baseURL:[NSURL URLWithString:@"http://www.jonfleming.com"]];
     */
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"editor" ofType:@"htm"];  
    NSData *htmlData = [NSData dataWithContentsOfFile:filePath];  
    NSString *resourcePath = [[NSBundle mainBundle] resourcePath];
    NSURL *baseURL = [[NSURL alloc] initFileURLWithPath:resourcePath isDirectory:YES];
    
    if (htmlData) {  
        [webView loadData:htmlData MIMEType:@"text/html" textEncodingName:@"UTF-8" baseURL:baseURL];  
    }  
    webView.delegate = self;
}

- (IBAction)PJBold:(id)sender
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjBold();"];
}

- (IBAction)PJItalic:(id)sender
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjItalic();"];
}

- (IBAction)PJUnderline:(id)sender
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjUnderline();"];    
}

- (IBAction)PJUnorderedList:(id)sender
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjUnorderedList()"];
}

- (IBAction)PJOrderedList:(id)sender
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjOrderedList()"];    
}

- (IBAction)PJTest:(id)sender 
{
    [webView stringByEvaluatingJavaScriptFromString:@"pjItalic();"];
}

- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest: (NSURLRequest*)req  navigationType:(UIWebViewNavigationType)navigationType 
{
    if ([[[req URL] host] isEqualToString:@"debugger"])
    {
        NSLog(@"webView: %@", [[req URL] resourceSpecifier]);
        return false;
    }
    return true;
}

- (void)viewDidUnload
{   [super viewDidUnload];
    webView.delegate = nil;
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
	[super viewWillDisappear:animated];
}

- (void)viewDidDisappear:(BOOL)animated
{
	[super viewDidDisappear:animated];
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return YES;
}

@end
