//
//  Tech.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/9/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Tech.h"
#import "TechDetail.h"

@interface Tech ()
@property (strong, nonatomic) IBOutlet UITableView *table;

@end

@implementation Tech{
    
    NSMutableArray *listOfItems;
    NSMutableArray *listOfDetails;
    NSMutableArray *listOfImages;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
    [self getTech];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

-(void)getTech{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sql = "SELECT * FROM Technical";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listOfDetails =[[NSMutableArray alloc] init];
            listOfImages = [[NSMutableArray alloc] init];
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 3) length:sqlite3_column_bytes(searchStatement, 3)];
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItems addObject:name];
                [listOfDetails addObject:details];
                [listOfImages addObject:imageDataFromDb];
            }
        }
        sqlite3_finalize(searchStatement);
    }
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    
    if ([segue.identifier isEqualToString:@"detail"]){
        NSIndexPath *indexPath = [self.table indexPathForSelectedRow];
        TechDetail *destViewController = segue.destinationViewController;
        destViewController.Techname = [listOfItems objectAtIndex:indexPath.row];
        destViewController.txtdata = [listOfDetails objectAtIndex:indexPath.row];
        destViewController.imagecontents = [listOfImages objectAtIndex:indexPath.row];


    }
    
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

@end
