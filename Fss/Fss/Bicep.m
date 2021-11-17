//
//  Bicep.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Bicep.h"
#import "PicView.h"

@interface Bicep ()

@end

@implementation Bicep

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _muscle;

    

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_exename count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier =@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [_exename objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"picview"]){
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        PicView *destViewController = segue.destinationViewController;
        destViewController.exename = [_exename objectAtIndex:indexPath.row];
        destViewController.t1contents = [_tool objectAtIndex:indexPath.row];
        destViewController.t2contents = [_play objectAtIndex:indexPath.row];
        destViewController.t3contents = [_trip objectAtIndex:indexPath.row];
        destViewController.imagecontents = [_arpic1 objectAtIndex:indexPath.row];
        destViewController.imagecontents2 = [_arpic2 objectAtIndex:indexPath.row];
        
    }
    
}


@end
