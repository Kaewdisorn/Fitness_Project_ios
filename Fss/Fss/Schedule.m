//
//  Schedule.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/20/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Schedule.h"
#import "Rec.h"
#import "Custom.h"

@interface Schedule ()

@end

@implementation Schedule{
    
    NSArray *menuItems;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    menuItems = @[@"basic",@"normal",@"expert",@"custom"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"basic"]){
        NSString *str = @"ระดับพื้นฐาน";
        Rec *destViewController = segue.destinationViewController;
        destViewController.head = str;
        
    }
    else if ([segue.identifier isEqualToString:@"normal"]){
        NSString *str = @"ระดับปานกลาง";
        Rec *destViewController = segue.destinationViewController;
        destViewController.head = str;
        
    } else if ([segue.identifier isEqualToString:@"custom"]){
        NSString *str = @"ตารางกำหนดเอง";
        Custom *destViewController = segue.destinationViewController;
        destViewController.head = str;
        
    } else if ([segue.identifier isEqualToString:@"hard"]){
        NSString *str = @"ระดับสูง";
        Custom *destViewController = segue.destinationViewController;
        destViewController.head = str;
        
    }
    
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return menuItems.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    NSString *CellIdentifier = [menuItems objectAtIndex:indexPath.row];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier forIndexPath:indexPath];
    
    return cell;
}

@end
