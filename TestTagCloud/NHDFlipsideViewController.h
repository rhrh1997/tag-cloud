//
//  NHDFlipsideViewController.h
//  TestTagCloud
//
//  Created by Drew Dennistoun on 9/6/13.
//  Copyright (c) 2013 Drew Dennistoun. All rights reserved.
//

#import <UIKit/UIKit.h>



@class NHDFlipsideViewController;

@protocol NHDFlipsideViewControllerDelegate
- (void)flipsideViewControllerDidFinish:(NHDFlipsideViewController *)controller;
@end

@interface NHDFlipsideViewController : UIViewController

@property (weak, nonatomic) id <NHDFlipsideViewControllerDelegate> delegate;
@property (nonatomic, retain) NSString *someDataToShowa;
@property (weak, nonatomic) IBOutlet UITextView *textthingy;
- (IBAction)done:(id)sender;

@end
