//
//  Bicep.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Bicep : UITableViewController

@property (strong,nonatomic) NSString *muscle;
@property (strong,nonatomic) NSArray *exename;
@property (strong,nonatomic) NSArray *arpic1;
@property (strong,nonatomic) NSArray *arpic2;
@property (strong,nonatomic) NSArray *tool;
@property (strong,nonatomic) NSArray *play;
@property (strong,nonatomic) NSArray *trip;

@property (strong, nonatomic) IBOutlet UITableView *table;
@end
