//
//  Leg2.m
//  Fss
//
//  Created by Wongsaphat Praisri on 8/5/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Leg2.h"
#import "PicView.h"


@interface Leg2 ()
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation Leg2{
    
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
    [self getAbs];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
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

-(void)getAbs{
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

/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
