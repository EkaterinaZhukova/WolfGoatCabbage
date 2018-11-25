//
//  RightViewController.h
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol RightViewControllerDelegate <NSObject>

-(void) startNewGame;
-(void) moveToTheLeft;

@end

@class ViewModel;

@interface RightViewController : UIViewController
@property(nonatomic,strong) NSArray* entityArr;
@property(nonatomic,strong) NSArray* entityID;
@property(nonatomic,weak)ViewModel* viewModel;
@property(nonatomic,weak) id<RightViewControllerDelegate> delegate;

@end

NS_ASSUME_NONNULL_END


