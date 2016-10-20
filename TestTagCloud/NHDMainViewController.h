//
//  NHDMainViewController.h
//  TestTagCloud
//
//  Created by Drew Dennistoun on 9/6/13.
//  Copyright (c) 2013 Drew Dennistoun. All rights reserved.
//

#import "NHDFlipsideViewController.h"
#import "SBJson.h"

@interface NHDMainViewController : UIViewController <NHDFlipsideViewControllerDelegate, UIPopoverControllerDelegate>



@property (strong, nonatomic) UIPopoverController *flipsidePopoverController;


@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property (weak, nonatomic) IBOutlet UITextField *urlenter;
@property (weak, nonatomic) IBOutlet UITextView *secret;

-(NSString*)computeDataToPassToFlipside;
- (IBAction)loadAddress:(id)sender forEvent:(UIEvent *)event;
- (IBAction)buttonTapped:(UIButton *)sender;
- (IBAction)showInfo:(id)sender;


@end
