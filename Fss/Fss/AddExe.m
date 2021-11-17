//
//  AddExe.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/19/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "AddExe.h"
#import "popview.h"

@interface AddExe ()

@property(strong, nonatomic) NSMutableSet *selectedCells;

@end

@implementation AddExe{
    
    NSMutableArray *listOfItems;
    NSMutableArray *listpic;
    NSMutableArray *pic1,*pic2;
    NSString *nameexe;
    NSString *set ,*rep;
    
    NSData *arpic1,*arpic2;

}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
    [self getExe];

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
-(void)getExe{
    
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sql = "SELECT * FROM Exercise";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sql, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listpic = [[NSMutableArray alloc] init];
            pic1 = [[NSMutableArray alloc] init];
            pic2 = [[NSMutableArray alloc] init];
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 8) length:sqlite3_column_bytes(searchStatement, 8)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                NSData *imageDataFromDb3 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 7) length:sqlite3_column_bytes(searchStatement, 7)];

                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItems addObject:name];
                [listpic addObject:imageDataFromDb];
                [pic1 addObject:imageDataFromDb2];
                [pic2 addObject:imageDataFromDb3];

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
    NSData *image ;
    image = [listpic objectAtIndex:indexPath.row];
    
    UIImage *aImage;
    aImage = [UIImage imageWithData:image];
    

    cell.textLabel.text = [listOfItems objectAtIndex:indexPath.row];
    cell.imageView.image = aImage;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];

    
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryDetailButton) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
        UIAlertView *messageAlert = [[UIAlertView alloc]
                                     initWithTitle:@"เพิ่มท่าฝึก" message:[listOfItems objectAtIndex:indexPath.row] delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:@"ยกเลิก",nil];
        
  

        messageAlert.tag=101;
        [messageAlert show];
        nameexe = selectedCell.textLabel.text;

    } else {
        
        [selectedCell setAccessoryType:UITableViewCellAccessoryDetailButton];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    if (alertView.tag == 101) {
        
        if (buttonIndex == 0) {
            
          /*  UIAlertView *text = [[UIAlertView alloc] initWithTitle:@"เพิ่มจำนวนเซ็ต" message:nil delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:@"ยกเลิก", nil];
            text.alertViewStyle = UIAlertViewStylePlainTextInput;
            text.tag = 200;
            [[text textFieldAtIndex:0]setKeyboardType:UIKeyboardTypeNumberPad];
            [text show];*/
            [[NSNotificationCenter defaultCenter ]postNotificationName:@"someThingSelectedInDetail" object: nameexe];
            UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"สำเร็จ" message:@"เพิ่มท่าฝึกเรียบร้อย" delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:nil];
            [done show];


        }
        
        else if(buttonIndex == 1){
            
            NSLog(@"Cancle");
            
            
        }
        
    } /*else if (alertView.tag == 200){
        
        if (buttonIndex == 0) {
            
            
           UIAlertView *text = [[UIAlertView alloc] initWithTitle:@"เพิ่มจำนวนครั้ง" message:nil delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:@"ยกเลิก", nil];
            text.alertViewStyle = UIAlertViewStylePlainTextInput;
            text.tag = 300;
            
            set =[alertView textFieldAtIndex:0].text;
            [[text textFieldAtIndex:0]setKeyboardType:UIKeyboardTypeNumberPad];
            [text show];
            

        } else if (buttonIndex == 1){
            
            NSLog(@"Cancle");
        }
        
   
    } else if (alertView.tag == 300) {
        
       
        rep =[alertView textFieldAtIndex:0].text;
        
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"someThingSelectedInDetail" object: nameexe];
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"someThingSelectedInDetail2" object: set];
        [[NSNotificationCenter defaultCenter ]postNotificationName:@"someThingSelectedInDetail3" object: rep];
        
        UIAlertView *done = [[UIAlertView alloc] initWithTitle:@"สำเร็จ" message:@"เพิ่มท่าฝึกเรียบร้อย" delegate:self cancelButtonTitle:@"ตกลง" otherButtonTitles:nil];
        [done show];
        
    }*/
    
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
     NSLog(@"Click");
    arpic1 = [pic1 objectAtIndex:indexPath.row];
    arpic2 = [pic2 objectAtIndex:indexPath.row];
    [self performSegueWithIdentifier:@"popview" sender:self];


    
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UIViewController *newVC = segue.destinationViewController;
    popview *destViewController = segue.destinationViewController;
   // destViewController.NameExe = NameHvPass;
    destViewController.imagecontents = arpic1;
    destViewController.imagecontents2=arpic2;
    
    
    [AddExe setPresentationStyleForSelfController:self presentingController:newVC];
    
    
}

+ (void)setPresentationStyleForSelfController:(UIViewController *)selfController presentingController:(UIViewController *)presentingController
{
    if ([NSProcessInfo instancesRespondToSelector:@selector(isOperatingSystemAtLeastVersion:)])
    {
        //iOS 8.0 and above
        presentingController.providesPresentationContextTransitionStyle = YES;
        presentingController.definesPresentationContext = YES;
        
        [presentingController setModalPresentationStyle:UIModalPresentationOverCurrentContext];
    }
    else
    {
        [selfController setModalPresentationStyle:UIModalPresentationCurrentContext];
        [selfController.navigationController setModalPresentationStyle:UIModalPresentationCurrentContext];
    }
}



@end
