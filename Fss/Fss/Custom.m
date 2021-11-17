//
//  Custom.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/19/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Custom.h"
#import "CustomCell.h"

@interface Custom ()


@property(strong, nonatomic) NSMutableSet *selectedCells;

@end

@implementation Custom{
    
    NSMutableArray *listOfItems;
    NSMutableArray *listOfSet;
    NSMutableArray *listOfRep;
    NSString *ccc;
    
    NSString *Set,*Rep,*chefName ;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
    [self getCustom];
    
    self.navigationItem.title = _head;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingSelectedInDetail:) name:@"someThingSelectedInDetail" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingSelectedInDetail2:) name:@"someThingSelectedInDetail2" object:nil];
   // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(someThingSelectedInDetail3:) name:@"someThingSelectedInDetail3" object:nil];
    
}
- (void)someThingSelectedInDetail:(NSNotification*)notificationObject
{
    // data From AddExe store here 
    chefName = notificationObject.object;
    NSLog(@"Name = %@ ",chefName);
    
    NSString *query = [NSString stringWithFormat:@"Insert INTO Custom ('Name') values ('%@')",chefName];
    NSLog(@"Query = %@ ",query);
    const char *sqlStatement = [query UTF8String];
    sqlite3_stmt *compiledStatement;
    if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
        // Loop through the results and add them to the feeds array
        while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
            // Read the data from the result row
            NSLog(@"result is here");
        }
        // Release the compiled statement from memory
        sqlite3_finalize(compiledStatement);
    }
    

}
- (void)someThingSelectedInDetail2:(NSNotification*)notificationObject
{
    // data From AddExe store here
    Set = notificationObject.object;
    NSLog(@"Set = %@ ",Set);

}
- (void)someThingSelectedInDetail3:(NSNotification*)notificationObject
{
    // data From AddExe store here
    Rep = notificationObject.object;
    NSLog(@"Rep = %@ ",Rep);
    
  /*  NSString *query = [NSString stringWithFormat:@"Insert INTO Custom ('Name','Set','Rep') values ('%@','%@','%@')",chefName,Set,Rep];
     NSLog(@"Query = %@ ",query);
     const char *sqlStatement = [query UTF8String];
     sqlite3_stmt *compiledStatement;
     if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
     // Loop through the results and add them to the feeds array
     while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
     // Read the data from the result row
     NSLog(@"result is here");
     }
     // Release the compiled statement from memory
     sqlite3_finalize(compiledStatement);
     }*/
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

-(NSMutableSet *)selectedCells{
    if(_selectedCells){
        return _selectedCells;
    }
    _selectedCells = [[NSMutableSet alloc]init];
    return _selectedCells;
}

-(void)initDatabase{
    BOOL success;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    NSError *error;
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *writableDBPath = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    success = [fileManager fileExistsAtPath:writableDBPath];
    if (success)
    {
        return;
    }
    NSString *defaultDBPath = [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent:@"FSS2.sqlite"];
    success = [fileManager copyItemAtPath:defaultDBPath toPath:writableDBPath error:&error];
    if (!success)
    {
        NSAssert1(0, @"Failed to create writable database file with message '%@'.", [error localizedDescription]);
    }
}

-(void)getCustom{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sql = "SELECT * FROM Custom";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
         //   listOfSet = [[NSMutableArray alloc] init];
         //   listOfRep = [[NSMutableArray alloc] init];

            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
          //      NSString *Sett = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
          //      NSString *Repp = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 3)];
                

               // NSLog(@"Name:%@ , Set:%@ , Rep:%@",name,Sett,Repp);
                
                [listOfItems addObject:name];
               // [listOfSet addObject:Sett];
              //  [listOfRep addObject:Repp];
 
            }
        }
        sqlite3_finalize(searchStatement);
    }
}



#pragma mark - Table view data source

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
 
    
    CustomCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];

    [cell.name setText:[listOfItems objectAtIndex:indexPath.row]];
    ccc = cell.name.text;
    //[cell.set setText:[listOfSet objectAtIndex:indexPath.row]];
   // [cell.rep setText:[listOfRep objectAtIndex:indexPath.row]];

    
    return cell;
}

- (void)tableView:(UITableView *)table commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        
       NSString *query = [NSString stringWithFormat:@"DELETE FROM Custom WHERE Name = '%@' ",ccc];
        NSLog(@"%@",ccc);
        const char *sqlStatement = [query UTF8String];
        sqlite3_stmt *compiledStatement;
        if(sqlite3_prepare_v2(database, sqlStatement, -1, &compiledStatement, NULL) == SQLITE_OK) {
            // Loop through the results and add them to the feeds array
            while(sqlite3_step(compiledStatement) == SQLITE_ROW) {
                // Read the data from the result row
                NSLog(@"result is here");
            }
            // Release the compiled statement from memory
            sqlite3_finalize(compiledStatement);
            [listOfItems removeObjectAtIndex:indexPath.row];
            [table deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
            
            [table reloadData];
        }
    }
    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryNone) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    } else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryNone];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}

@end
