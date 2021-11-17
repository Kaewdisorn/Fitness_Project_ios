//
//  Leg.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/20/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Leg.h"
#import "PicView.h"

@interface Leg ()
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation Leg{
    
    NSMutableArray *listOfItems;
    NSMutableArray *listOfTools;
    NSMutableArray *listOfPlay;
    NSMutableArray *listOfTrip;
    NSMutableArray *img1;
    NSMutableArray *img2;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
    [self getLeg];
    

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

-(void)getLeg{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sql = "SELECT * FROM Exercise WHERE muscle = 'leg' ";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listOfTools = [[NSMutableArray alloc] init];
            listOfPlay = [[NSMutableArray alloc] init];
            listOfTrip = [[NSMutableArray alloc] init];
            img1 = [[NSMutableArray alloc] init];
            img2 = [[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *tools = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSString *play = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 3)];
                NSString *trip = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 4)];
                NSData *pic1 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                NSData *pic2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 7) length:sqlite3_column_bytes(searchStatement, 7)];
                
                
                // NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,tools,pic1);
                
                [listOfItems addObject:name];
                [listOfTools addObject:tools];
                [listOfPlay addObject:play];
                [listOfTrip addObject:trip];
                [img1 addObject:pic1];
                [img2 addObject:pic2];
            }
        }
        sqlite3_finalize(searchStatement);
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [listOfItems count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *simpleTableIdentifier =@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [listOfItems objectAtIndex:indexPath.row];
    return cell;
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"picview"]){
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        PicView *destViewController = segue.destinationViewController;
        destViewController.exename = [listOfItems objectAtIndex:indexPath.row];
        destViewController.t1contents = [listOfTools objectAtIndex:indexPath.row];
        destViewController.t2contents = [listOfPlay objectAtIndex:indexPath.row];
        destViewController.t3contents = [listOfTrip objectAtIndex:indexPath.row];
        destViewController.imagecontents = [img1 objectAtIndex:indexPath.row];
        destViewController.imagecontents2 = [img2 objectAtIndex:indexPath.row];
        
    }
    
}


@end
