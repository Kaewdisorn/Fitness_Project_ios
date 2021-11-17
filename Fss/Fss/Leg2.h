//
//  Leg2.h
//  Fss
//
//  Created by Wongsaphat Praisri on 8/5/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <sqlite3.h>

@interface Leg2 : UITableViewController<UITableViewDataSource,UITableViewDelegate>{
    
    sqlite3 *database;
}

-(void) initDatabase;
-(void) getAbs;


@end
