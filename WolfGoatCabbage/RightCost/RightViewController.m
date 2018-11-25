//
//  RightViewController.m
//  WolfGoatCabbage
//
//  Created by Екатерина on 11/24/18.
//  Copyright © 2018 Екатерина. All rights reserved.
//

#import "RightViewController.h"
#import "WolfGoatCabbage-Swift.h"
#define cellID @"cellID"



@interface RightViewController()
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


@implementation RightViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerClass:UITableViewCell.class forCellReuseIdentifier:cellID];
    self.tableView.dataSource = self;
    self.tableView.delegate = self;
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    __weak typeof(self) weakSelf = self;
    self.entityArr = [self.viewModel fetchDataFor:EntityStateIsOnTheRight];
    self.entityID = [self.viewModel fetchIdFor:EntityStateIsOnTheRight];
    
    [self.tableView reloadData];
    Boolean res = [self.viewModel playOn:EntityStateIsOnTheRight];
    if(!res){
        [self showAlert:@"You loose" :@"Press ok to start again" :^(UIAlertAction * action) {
            [weakSelf.delegate startNewGame];
        }];
    }
    res = [self.viewModel isWin];
    if(res){
        [self showAlert:@"You win!" :@"Press OK to strat new game":^(UIAlertAction * action) {
            [weakSelf.delegate startNewGame];
        }];
    }
}

-(void)showAlert:(NSString*)title :(NSString*)message :(void (^)(UIAlertAction*))handler{
    UIAlertController * alert = [UIAlertController
                                 alertControllerWithTitle:title
                                 message:message
                                 preferredStyle:UIAlertControllerStyleAlert];
    
    UIAlertAction* yesButton = [UIAlertAction
                                actionWithTitle:@"OK"
                                style:UIAlertActionStyleDefault
                                handler:handler];
    [alert addAction:yesButton];
    [self presentViewController:alert animated:YES completion:nil];
}

- (void)dealloc{
    NSLog(@"RightViewController dealloc");
}
- (IBAction)moveToTheLeft:(id)sender {
    [self.delegate moveToTheLeft];
}

@end
@interface RightViewController(TableViewDataSource)<UITableViewDataSource>

@end
@implementation RightViewController(TableViewDataSource)


- (nonnull UITableViewCell *)tableView:(nonnull UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath {
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    cell.textLabel.text = self.entityArr[indexPath.row];
    return cell;
}

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.entityArr.count;
}

@end


@interface RightViewController(TableViewDelegate)<UITableViewDelegate>

@end

@implementation RightViewController(TableViewDelegate)

- (NSArray<UITableViewRowAction *> *)tableView:(UITableView *)tableView editActionsForRowAtIndexPath:(NSIndexPath *)indexPath{
    __weak typeof(self) weakSelf = self;
    UITableViewCell* cell = [tableView cellForRowAtIndexPath:indexPath];
    
    UITableViewRowAction *onBank = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"on bank" handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSNumber* currentId = [self.entityID objectAtIndex:indexPath.row];
        [weakSelf.viewModel modelChangedAt:[currentId intValue] with:EntityStateIsOnTheRight];
        [cell.contentView setBackgroundColor:UIColor.whiteColor];
        [cell.textLabel setTextColor:UIColor.blackColor];
        
    }];
    onBank.backgroundColor = [UIColor blueColor];
    
    UITableViewRowAction *inBoat = [UITableViewRowAction rowActionWithStyle:UITableViewRowActionStyleNormal title:@"in boat"  handler:^(UITableViewRowAction *action, NSIndexPath *indexPath){
        NSNumber* currentId = self.entityID[indexPath.row];
        [weakSelf.viewModel modelChangedAt:[currentId intValue] with:EntityStateIsInBoat];
        [cell.contentView setBackgroundColor:UIColor.blackColor];
        [cell.textLabel setTextColor:UIColor.whiteColor];
        
    }];
    inBoat.backgroundColor = [UIColor redColor];
    return @[inBoat,onBank];
}

@end
