//
//  RightViewController.m
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "RightViewController.h"
#import "WolfGoatCabbage-Swift.h"
@protocol Prlvkhf
@property (nonatomic,weak) Class viewModel;
@end
@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    
}
-(void) moveToTheLeft{

    [self.navigationController popViewControllerAnimated:YES];
}
- (void)dealloc
{
    NSLog(@"RightViewController dealloc");
}



@end
