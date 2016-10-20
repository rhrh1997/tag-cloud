//
//  NHDMainViewController.m
//  TestTagCloud
//
//  Created by Drew Dennistoun on 9/6/13.
//  Copyright (c) 2013 Drew Dennistoun. All rights reserved.
//

#import "NHDMainViewController.h"
#import "SBJson.h"

@interface NHDMainViewController ()

@end

@implementation NHDMainViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    //CGRect screenFrame = [[UIScreen mainScreen] applicationFrame];
    //UIWebView *wv = [[UIWebView alloc]  initWithFrame:screenFrame];
    //UIWebView *_webView = [[UIWebView alloc]  initWithFrame:screenFrame];
    
    [_webView setScalesPageToFit:YES];
    NSString *urlAddress = @"http://www.google.com";
    NSURL *url = [NSURL URLWithString:urlAddress];
    NSURLRequest *requestObj = [NSURLRequest requestWithURL:url];
    [_webView loadRequest:requestObj];

    
    
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark -webView
-(void)loadView
{
    [super loadView];
    
    
}

-(UIWebView *)webView
{
    return (UIWebView *)[self view];
}


#pragma mark - Flipside View Controller

- (void)flipsideViewControllerDidFinish:(NHDFlipsideViewController *)controller
{
    controller.someDataToShowa = @"hello string";
    controller.textthingy.text= [_webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"];
    if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPhone) {
        [self dismissViewControllerAnimated:YES completion:nil];
    } else {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
    }
}

- (void)popoverControllerDidDismissPopover:(UIPopoverController *)popoverController
{
    self.flipsidePopoverController = nil;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"showAlternate"]) {
        [[segue destinationViewController] setDelegate:self];
        
        if ([[UIDevice currentDevice] userInterfaceIdiom] == UIUserInterfaceIdiomPad) {
            UIPopoverController *popoverController = [(UIStoryboardPopoverSegue *)segue popoverController];
            self.flipsidePopoverController = popoverController;
            popoverController.delegate = self;
        }
    }
}

- (IBAction)togglePopover:(id)sender
{
    NHDFlipsideViewController *controller;
    controller.someDataToShowa = @"hello string";
    controller.textthingy.text=@"display";
    if (self.flipsidePopoverController) {
        [self.flipsidePopoverController dismissPopoverAnimated:YES];
        self.flipsidePopoverController = nil;
    } else {
        [self performSegueWithIdentifier:@"showAlternate" sender:sender];
    }
}

//- (void)loadAddress:(id)sender event:(UIEvent *)event
//{
//    NSString* urlString = _urlenter.text;
//    //NSLog(@"String: %@", urlString);
//    NSURL* url = [NSURL URLWithString:urlString];
//    NSURLRequest* request = [NSURLRequest requestWithURL:url];
//    [self.webView loadRequest:request];
//}
-(NSString*)computeDataToPassToFlipside
{
    NSString *html = [_webView stringByEvaluatingJavaScriptFromString:@"document.documentElement.innerHTML"];
    //NSLog(html);
    return html;
}

- (IBAction)loadAddress:(id)sender forEvent:(UIEvent *)event {
    //NSString* address = self.urlenter.text;
    //NSLog(@"%@",address);
    //NSURL* ul = [NSURL URLWithString:address];

    NSLog(@"Success?");
    
    NSString *myURLString = self.urlenter.text;
    NSURL *myURL;
    if ([myURLString hasPrefix:@"http://"])
    {
        myURL = [NSURL URLWithString:myURLString];
    }
    else
    {
        NSString *rer = [NSString stringWithFormat:@"http://%@", myURLString];
        myURL = [NSURL URLWithString:rer];
        rer = self.urlenter.text;
        NSLog(@"updated textbox");
    }
    
    NSURLRequest* request = [NSURLRequest requestWithURL:myURL];
    [_webView loadRequest:request];
    
}

- (IBAction)buttonTapped:(id)sender {
      NSLog(@"Button Tapped!");
    //_secret.text = (@"SENDER!") ;
}

- (IBAction)showInfo:(id)sender {
    NSLog(@"showInfo?");
    NHDFlipsideViewController *controller = [[NHDFlipsideViewController alloc] initWithNibName:@"FlipsideView" bundle:nil];
    controller.delegate = self;
    //NSString *test = (@"test");
    //controller.someDataToShowa = test;
    //controller.someDataToShowa = [self computeDataToPassToFlipside];
    //NSLog([_webView stringByEvaluatingJavaScriptFromString: @"document.body.innerHTML"]);
    //controller.textthingy.text= test;
}

//////*******START TAGCLOUD**********//////
-(void)loadTags {
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = YES;
    
    //request
    //MindzAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    //NSString *theUrl = [[NSString alloc] initWithFormat:@"%@/WikiService.asmx/%@?path=%@&apiKey=%@&userKey=%@&plazaId=%i&form=json",
                        delegate.hostUrl,
                        @"GetWikiTagOverview",
                        delegate.wikiUrl,
                        delegate.apiKey,
                        delegate.profileKey,
                        delegate.plazaId
                        ];
    NSURL *tagURL = [[NSURL alloc] initWithString:theUrl];
    NSString *content = [[NSString alloc] initWithContentsOfURL:tagURL];
    //[theUrl release];
    //[tagURL release];
    
    [UIApplication sharedApplication].networkActivityIndicatorVisible = NO;
    
    if([content length] == 0) {
        UIAlertView *myAlert = [[UIAlertView alloc]
                                initWithTitle:
                                NSLocalizedString
                                (@"ConnectionError",
                                 @"Alert the user that The connection failed")
                                message: NSLocalizedString
                                (@"ConnectionError",
                                 @"Alert the user that The connection failed")
                                delegate:self
                                cancelButtonTitle:@"OK"
                                otherButtonTitles:nil];
        //[myAlert show];
        //[myAlert release];
        //loadingSpinner.hidden = TRUE;
        //loadingLabel.hidden = TRUE;
        
    }
    else {
        SBJsonParser *parser = [[SBJsonParser alloc] init];
        NSDictionary *json = [parser objectWithString:content];
        //[parser release];
        //[content release];
        
        //random tagcloud
        //***NSArray *theArray = [[json objectForKey:@"Results"] shuffled];
        //**self.contentArray = [NSArray arrayWithArray:theArray];
        
        //first scroll contraint
        //scrollYConstraint = 550;
        //scrollLastUsed = 0;
        [self showTags];
    }
    //[pool release];
}

-(void)showTags {
    //NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];
    
    int tag = 1;
    //max width to go down with the button (portrait iphone screen)
    int xConstraint = 300;
    int yConstraint = 0;
    
    for(NSDictionary *theRow in self.contentArray) {
        NSString *theTitle = [theRow objectForKey:@"Name"];
        if (tag > scrollLastUsed) {
            float x = 10.0f;
            float y = scrollYConstraint - 540;
            
            //between 15 and 50
            float fontSize = (arc4random() % 50) + 15;
            
            
            for (UIButton *btn in tagsArray) {
                CGSize theSize = [theTitle sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(9999.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
                
                //not too wide?
                while (theSize.width > xConstraint) {
                    fontSize -= 1;
                    theSize = [theTitle sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(9999.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
                }
                
                CGRect compareRect = CGRectMake(x, y, theSize.width + 10, theSize.height);
                while ([self rectIntersects:compareRect]) {
                    if((theSize.width + x +5) < xConstraint) x += 15;
                    else {
                        x = 10;
                        y += 12;
                    }
                    compareRect = CGRectMake(x, y, theSize.width, theSize.height);
                }
            }
            
            [self.tagScrollView addSubview:[self addLabelWithTitle:theTitle andFontSize:fontSize WithX:x AndY:y AndTag:tag]];
            
            //get the button height and add it to the constraint
            int btnHeight = (int)[self.tagScrollView viewWithTag:tag].frame.size.height;
            if ((y + btnHeight) > yConstraint) yConstraint = (y + btnHeight);
        }
        //stop if we reached the wanted constraint
        if(yConstraint > scrollYConstraint) break;
        
        //otherwise, next tag
        tag++;
    }
    //resize scrollview
    self.tagScrollView.contentSize = CGSizeMake(320, yConstraint+10);
    
    //remember the last used tag
    scrollLastUsed = tag;
    
    //hide loaders
    loadingSpinner.hidden = TRUE;
    loadingLabel.hidden = TRUE;
    
    UIActivityIndicatorView *theSpinner = (UIActivityIndicatorView *)[self.tagScrollView viewWithTag:99999];
    if(theSpinner) [theSpinner removeFromSuperview];
    
    //show scrollview
    tagScrollView.hidden = FALSE;
    loadingNewTags  = FALSE;
    
    [pool release];
}

-(UIButton *)addLabelWithTitle:(NSString *)theTitle andFontSize:(float)fontSize WithX:(float)x AndY:(float)y AndTag:(NSInteger)tag {
    MindzAppDelegate *delegate = [[UIApplication sharedApplication] delegate];
    
    
    UIButton *theBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    
    //get width for the label
    CGSize theSize = [theTitle sizeWithFont:[UIFont boldSystemFontOfSize:fontSize] constrainedToSize:CGSizeMake(9999.0f, 9999.0f) lineBreakMode:UILineBreakModeWordWrap];
    theBtn.frame = CGRectMake(x, y, theSize.width, theSize.height);
    
    //save the button in an array to check whether it overlaps with other buttons
    [self.tagsArray addObject:theBtn];
    
    [theBtn setTitle:theTitle forState:UIControlStateNormal];
    
    UIColor *titleColor = [UIColor blackColor];
    
    [theBtn setTitleColor:titleColor forState:UIControlStateNormal];
    theBtn.titleLabel.font = [UIFont boldSystemFontOfSize:fontSize];
    theBtn.tag = tag;
    
    
    [theBtn setContentHorizontalAlignment:UIControlContentHorizontalAlignmentCenter];
    CGRect frame = theBtn.frame;
    frame.size.width += 10; //l + r padding
    theBtn.frame = frame;
    
    // add action
    [theBtn addTarget:self action:@selector(tagPressed:) forControlEvents:UIControlEventTouchUpInside];
    
    return theBtn;
}

-(BOOL)rectIntersects:(CGRect)theRect {
    int t = 0;
    for (UIButton *btn in tagsArray) {
        t++;
        if (t >= (scrollLastUsed - 10)) {
            CGRect testRect = CGRectIntersection(btn.frame, theRect);
            if (!CGRectIsNull(testRect)) return TRUE;
        }
    }
    return FALSE;
}


#pragma mark -
#pragma mark ScrollViewDelegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    if(scrollView.contentOffset.y > (scrollYConstraint - 400) && self.scrollLastUsed < [self.contentArray count] && !loadingNewTags) {
        loadingNewTags  = TRUE;
        //add a spinner
        UIActivityIndicatorView *extraSpinner = [[UIActivityIndicatorView alloc] initWithActivityIndicatorStyle:UIActivityIndicatorViewStyleWhite];
        extraSpinner.tag = 99999;
        extraSpinner.frame = CGRectMake(150, (int)scrollYConstraint + 20, 20, 20);
        [extraSpinner startAnimating];
        
        self.tagScrollView.contentSize = CGSizeMake(320, (int)scrollYConstraint + 50);
        [self.tagScrollView addSubview:extraSpinner];
        
        
        //new contraint
        scrollYConstraint = scrollYConstraint + 550;
        
        //load new tags
        [NSThread detachNewThreadSelector:@selector(showTags) toTarget:self withObject:nil];
    }
}

@end
