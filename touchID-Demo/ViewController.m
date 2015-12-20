//
//  ViewController.m
//  touchID-Demo
//
//  Created by 姚琪 on 15/12/19.
//  Copyright © 2015年 yaoqi. All rights reserved.
//

#import "ViewController.h"
#import <LocalAuthentication/LocalAuthentication.h>
@interface ViewController ()
@property (strong,nonatomic) LAContext * context;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)touchID:(id)sender
{
    self.context = [LAContext new];
    
    NSError *error;
    _context.localizedFallbackTitle = @"";
    
    if ([_context canEvaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics error:&error])
    {
        NSLog(@"Touch ID is available.");
        [_context evaluatePolicy:LAPolicyDeviceOwnerAuthenticationWithBiometrics
                localizedReason:NSLocalizedString(@"Use Touch ID to log in.", nil)
                          reply:^(BOOL success, NSError *error) {
                              if (success)
                              {
                                  NSLog(@"Authenticated using Touch ID.");
                              }
                              else
                              {
                                  if (error.code == kLAErrorUserFallback) {
                                      NSLog(@"User tapped Enter Password");
                                  } else if (error.code == kLAErrorUserCancel) {
                                      NSLog(@"User tapped Cancel");
                                  } else {
                                      NSLog(@"Authenticated failed.");
                                  }
                              }}];
    }
         
         else {
             
             NSLog(@"Touch ID is not available: %@", error);
             
         }
}

@end
