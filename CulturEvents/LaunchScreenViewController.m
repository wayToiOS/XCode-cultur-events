//
//  LaunchScreenViewController.m
//  CulturEvents
//
//  Created by Vladimir Bolotov on 22.10.16.
//  Copyright © 2016 Vladimir Bolotov. All rights reserved.
//

#import "LaunchScreenViewController.h"

@interface LaunchScreenViewController ()

@end

@implementation LaunchScreenViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    
    [NSTimer scheduledTimerWithTimeInterval:3.0
                                     target:self
                                   selector:@selector(showVC)
                                   userInfo:nil
                                    repeats:NO];
}
- (IBAction)onTap:(UITapGestureRecognizer *)sender {
    [self showVC];
}

- (void)showVC {
   UIViewController *vc = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"secondViewController"];
    [self showViewController:vc sender:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
