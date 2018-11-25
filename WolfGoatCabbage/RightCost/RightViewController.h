//
//  RightViewController.h
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import "WolfGoatCabbage-Swift.h"

NS_ASSUME_NONNULL_BEGIN

@interface RightViewController : UIViewController
//@property(nonatomic,weak) ViewModel* viewModel;
@property(nonatomic,strong) NSArray* entityArr;

-(void) moveToTheLeft;
//-(void) setViewModel:
@end

NS_ASSUME_NONNULL_END


