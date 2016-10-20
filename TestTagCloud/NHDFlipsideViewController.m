//
//  NHDFlipsideViewController.m
//  TestTagCloud
//
//  Created by Drew Dennistoun on 9/6/13.
//  Copyright (c) 2013 Drew Dennistoun. All rights reserved.
//

#import "NHDFlipsideViewController.h"
#import "NHDMainViewController.h"



@interface NHDFlipsideViewController ()

@end

@implementation NHDFlipsideViewController

- (void)awakeFromNib
{
    self.preferredContentSize = CGSizeMake(320.0, 480.0);
    [super awakeFromNib];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    NHDMainViewController *controller;
    NSLog(@"Should display new text?");
    NSLog(@" Should display: %@",_someDataToShowa);
    NSLog(@"Should display cdtptf %@",controller.computeDataToPassToFlipside);
    //_textthingy.text = controller.computeDataToPassToFlipside;
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Actions

- (IBAction)done:(id)sender
{
    _textthingy.text = (@"hello");
    NSLog(@" Should display: %@",_someDataToShowa);
    [self.delegate flipsideViewControllerDidFinish:self];
    
}

- (void)viewDidUnload {
    [self setTextthingy:nil];
    [super viewDidUnload];
}


@end
