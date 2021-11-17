//
//  Tricep.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/19/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Tricep : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    
    sqlite3 *database;
}

-(void) initDatabase;
-(void) getTricep;

@end
