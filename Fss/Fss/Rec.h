//
//  Rec.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/18/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Rec : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    
    sqlite3 *database;
}

-(void) initDatabase;
-(void) getRecBasic;
-(void) getRecNormal;
-(void) getRecHard;


@property (strong,nonatomic) NSString *head;


@end
