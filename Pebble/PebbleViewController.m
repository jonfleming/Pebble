//
//  PebbleViewController.m
//  Pebble
//
//  Created by techion on 8/17/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "PebbleViewController.h"
#import "PebbleAppDelegate.h"

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
    
    PebbleAppDelegate *appDelegate = [[UIApplication sharedApplication] delegate];
    appDelegate.viewController = self;
}

#pragma mark - JavaScript Interface
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

#pragma mark - Document Handling
- (NSString *)PJGetContent
{
    NSString *text = [webView stringByEvaluatingJavaScriptFromString:@"pjGetContent();"];
    NSLog(@"%s: %@", __FUNCTION__, text);
    return text;
}

- (void)PJSetContent: (NSString *)text
{
    NSString *script = [NSString stringWithFormat:@"pjSetContent('%@');", text];
    [webView stringByEvaluatingJavaScriptFromString:script];
    NSLog(@"%s: %@", __FUNCTION__, script);
}

- (NSString *)getDocumentsDirectory 
{  
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);  
    return [paths objectAtIndex:0];  
}  

- (void)Save
{
    NSLog(@"%s", __FUNCTION__);
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:@"temp.txt"];
    NSString *text = [self PJGetContent];
    [text writeToFile:filePath atomically:YES encoding:NSUTF8StringEncoding error: nil];
    
    NSLog(@"Text: %@", text);
}

- (void)Load
{
    NSLog(@"%s", __FUNCTION__);
    NSString *filePath = [[self getDocumentsDirectory] stringByAppendingPathComponent:@"temp.txt"];    
    NSString *text = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    if (text) 
    {
        [self PJSetContent:text];
        NSLog(@"Text: %@", text);
    }
}

#pragma mark - Debugging
- (BOOL)webView:(UIWebView*)webView shouldStartLoadWithRequest: (NSURLRequest*)req  navigationType:(UIWebViewNavigationType)navigationType 
{
    NSLog(@"%s", __FUNCTION__);
    NSURL *url = [req URL];
    NSLog(@"  host: %@", [url host]);
    NSLog(@"  path: %@", [url path]);
    NSLog(@"  lastPathComponent: %@", [url lastPathComponent]);
    NSLog(@"  pathExtension: %@", [url pathExtension]);
    NSLog(@"  absolute: %@", [url absoluteString]);

    if ([[url host] isEqualToString:@"debugger"])
    {
        NSLog(@": %@", [url lastPathComponent]);
        return false;
    }
    if ([[url host] isEqualToString:@"ready"])
    {
        [self Load];
        return false;
    }
    return true;
}

- (void)viewDidUnload
{   
    NSLog(@"%s", __FUNCTION__);
    [super viewDidUnload];
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
