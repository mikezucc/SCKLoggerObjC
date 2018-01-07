//
//  ViewController.m
//  SCKLogTestApp
//
//  Created by Michael Zuccarino on 1/6/18.
//  Copyright © 2018 domino. All rights reserved.
//

#import "ViewController.h"

#import "SCKLog.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UISwitch *theSwitch;
@property (strong, nonatomic) IBOutlet UILabel *theLabel;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    SCKLog(@"%s %@",__FUNCTION__,self);
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];

    SCKLog(@"%s %@",__FUNCTION__,self);
}

- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

    SCKLog(@"%s %@",__FUNCTION__,self);
}

- (IBAction)toggledTheSwitch:(id)sender {
    SCKLog(@"%s %@ THE SWITCH IS %@",__FUNCTION__,self, self.theSwitch.isOn ? @"❤️" : @"🖤");
    self.theLabel.text = self.theSwitch.isOn ? @"❤️" : @"🖤";
}

@end
