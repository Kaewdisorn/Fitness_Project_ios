//
//  Rec.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/18/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Rec.h"
#import "popview.h"


@interface Rec ()

@property (strong, nonatomic) IBOutlet UITableView *table;
@property(strong, nonatomic) NSMutableSet *selectedCells;

@end

@implementation Rec{
    
    NSString *NameHvPass;
    NSData *arpic1,*arpic2;
    
    NSMutableArray *listOfItems;
    NSMutableArray *listOfDetails;
    NSMutableArray *listOfpic1;
    NSMutableArray *listOfpic2;


    NSMutableArray *listOfItemsTue;
    NSMutableArray *listOfDetailsTue;
    NSMutableArray *listOfpic12;
    NSMutableArray *listOfpic22;
    
    NSMutableArray *listOfItemsWed;
    NSMutableArray *listOfDetailsWed;
    NSMutableArray *listOfpic13;
    NSMutableArray *listOfpic23;
    
    NSMutableArray *listOfItemsThu;
    NSMutableArray *listOfDetailsThu;
    NSMutableArray *listOfpic14;
    NSMutableArray *listOfpic24;
    
    NSMutableArray *listOfItemsFri;
    NSMutableArray *listOfDetailsFri;
    NSMutableArray *listOfpic15;
    NSMutableArray *listOfpic25;
    
    NSMutableArray *listOfItemsSat;
    NSMutableArray *listOfDetailsSat;
    NSMutableArray *listOfpic16;
    NSMutableArray *listOfpic26;
    
    NSMutableArray *listOfItemsSun;
    NSMutableArray *listOfDetailsSun;
    NSMutableArray *listOfpic17;
    NSMutableArray *listOfpic27;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initDatabase];
    
    self.navigationItem.title = _head;




    
    if ([self.navigationItem.title  isEqual:  @"ระดับพื้นฐาน"]) {
        [self getRecBasic];
        
    } else if ([self.navigationItem.title isEqual: @"ระดับปานกลาง"]) {
        [self getRecNormal];
        
    } else if ([self.navigationItem.title isEqual: @"ระดับสูง"]) {
        [self getRecHard];
        
    }
    
    

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

//********************* BASIC ***********************************************************************
-(void)getRecBasic{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sqlMon = "SELECT * FROM Schdule WHERE day = 'mon'AND Level = 'basic'";
        const char *sqlTue = "SELECT * FROM Schdule WHERE day = 'tue'AND Level = 'basic'";
        const char *sqlWed = "SELECT * FROM Schdule WHERE day = 'wed'AND Level = 'basic'";
        const char *sqlThu = "SELECT * FROM Schdule WHERE day = 'thu'AND Level = 'basic'";
        const char *sqlFri = "SELECT * FROM Schdule WHERE day = 'fri'AND Level = 'basic'";
        const char *sqlSat = "SELECT * FROM Schdule WHERE day = 'sat'AND Level = 'basic'";
        const char *sqlSun = "SELECT * FROM Schdule WHERE day = 'sun'AND Level = 'basic'";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sqlMon, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listOfDetails =[[NSMutableArray alloc] init];
            listOfpic1 =[[NSMutableArray alloc] init];
            listOfpic2 =[[NSMutableArray alloc] init];



            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];

                
               // NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItems addObject:name];
                [listOfDetails addObject:details];
                [listOfpic1 addObject:imageDataFromDb];
                [listOfpic2 addObject:imageDataFromDb2];
                


            }
        }
        if (sqlite3_prepare_v2(database, sqlTue, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsTue = [[NSMutableArray alloc] init];
            listOfDetailsTue =[[NSMutableArray alloc] init];
            listOfpic12 =[[NSMutableArray alloc] init];
            listOfpic22 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsTue addObject:name];
                [listOfDetailsTue addObject:details];
                [listOfpic12 addObject:imageDataFromDb];
                [listOfpic22 addObject:imageDataFromDb2];
                
                
            }
        }
        if (sqlite3_prepare_v2(database, sqlWed, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsWed = [[NSMutableArray alloc] init];
            listOfDetailsWed =[[NSMutableArray alloc] init];
            listOfpic13 =[[NSMutableArray alloc] init];
            listOfpic23 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsWed addObject:name];
                [listOfDetailsWed addObject:details];
                [listOfpic13 addObject:imageDataFromDb];
                [listOfpic23 addObject:imageDataFromDb2];
                
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlThu, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsThu = [[NSMutableArray alloc] init];
            listOfDetailsThu =[[NSMutableArray alloc] init];
            listOfpic14 =[[NSMutableArray alloc] init];
            listOfpic24 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsThu addObject:name];
                [listOfDetailsThu addObject:details];
                [listOfpic14 addObject:imageDataFromDb];
                [listOfpic24 addObject:imageDataFromDb2];
    
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlFri, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsFri = [[NSMutableArray alloc] init];
            listOfDetailsFri =[[NSMutableArray alloc] init];
            listOfpic15 =[[NSMutableArray alloc] init];
            listOfpic25 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsFri addObject:name];
                [listOfDetailsFri addObject:details];
                [listOfpic15 addObject:imageDataFromDb];
                [listOfpic25 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSat, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSat = [[NSMutableArray alloc] init];
            listOfDetailsSat =[[NSMutableArray alloc] init];
            listOfpic16 =[[NSMutableArray alloc] init];
            listOfpic26 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSat addObject:name];
                [listOfDetailsSat addObject:details];
                [listOfpic16 addObject:imageDataFromDb];
                [listOfpic26 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSun, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSun = [[NSMutableArray alloc] init];
            listOfDetailsSun =[[NSMutableArray alloc] init];
            listOfpic17 =[[NSMutableArray alloc] init];
            listOfpic27 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSun addObject:name];
                [listOfDetailsSun addObject:details];
                [listOfpic17 addObject:imageDataFromDb];
                [listOfpic27 addObject:imageDataFromDb2];
                
            }
        }

        
        sqlite3_finalize(searchStatement);
    }
}

//********************************************  END Basic *********************************************


//********************* Normal ***********************************************************************
-(void)getRecNormal{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sqlMon = "SELECT * FROM Schdule WHERE day = 'mon'AND Level = 'normal'";
        const char *sqlTue = "SELECT * FROM Schdule WHERE day = 'tue'AND Level = 'normal'";
        const char *sqlWed = "SELECT * FROM Schdule WHERE day = 'wed'AND Level = 'normal'";
        const char *sqlThu = "SELECT * FROM Schdule WHERE day = 'thu'AND Level = 'normal'";
        const char *sqlFri = "SELECT * FROM Schdule WHERE day = 'fri'AND Level = 'normal'";
        const char *sqlSat = "SELECT * FROM Schdule WHERE day = 'sat'AND Level = 'normal'";
        const char *sqlSun = "SELECT * FROM Schdule WHERE day = 'sun'AND Level = 'normal'";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sqlMon, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listOfDetails =[[NSMutableArray alloc] init];
            listOfpic1 =[[NSMutableArray alloc] init];
            listOfpic2 =[[NSMutableArray alloc] init];
            
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                // NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItems addObject:name];
                [listOfDetails addObject:details];
                [listOfpic1 addObject:imageDataFromDb];
                [listOfpic2 addObject:imageDataFromDb2];
                
                
                
            }
        }
        if (sqlite3_prepare_v2(database, sqlTue, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsTue = [[NSMutableArray alloc] init];
            listOfDetailsTue =[[NSMutableArray alloc] init];
            listOfpic12 =[[NSMutableArray alloc] init];
            listOfpic22 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsTue addObject:name];
                [listOfDetailsTue addObject:details];
                [listOfpic12 addObject:imageDataFromDb];
                [listOfpic22 addObject:imageDataFromDb2];
                
                
            }
        }
        if (sqlite3_prepare_v2(database, sqlWed, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsWed = [[NSMutableArray alloc] init];
            listOfDetailsWed =[[NSMutableArray alloc] init];
            listOfpic13 =[[NSMutableArray alloc] init];
            listOfpic23 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsWed addObject:name];
                [listOfDetailsWed addObject:details];
                [listOfpic13 addObject:imageDataFromDb];
                [listOfpic23 addObject:imageDataFromDb2];
                
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlThu, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsThu = [[NSMutableArray alloc] init];
            listOfDetailsThu =[[NSMutableArray alloc] init];
            listOfpic14 =[[NSMutableArray alloc] init];
            listOfpic24 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsThu addObject:name];
                [listOfDetailsThu addObject:details];
                [listOfpic14 addObject:imageDataFromDb];
                [listOfpic24 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlFri, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsFri = [[NSMutableArray alloc] init];
            listOfDetailsFri =[[NSMutableArray alloc] init];
            listOfpic15 =[[NSMutableArray alloc] init];
            listOfpic25 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsFri addObject:name];
                [listOfDetailsFri addObject:details];
                [listOfpic15 addObject:imageDataFromDb];
                [listOfpic25 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSat, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSat = [[NSMutableArray alloc] init];
            listOfDetailsSat =[[NSMutableArray alloc] init];
            listOfpic16 =[[NSMutableArray alloc] init];
            listOfpic26 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSat addObject:name];
                [listOfDetailsSat addObject:details];
                [listOfpic16 addObject:imageDataFromDb];
                [listOfpic26 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSun, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSun = [[NSMutableArray alloc] init];
            listOfDetailsSun =[[NSMutableArray alloc] init];
            listOfpic17 =[[NSMutableArray alloc] init];
            listOfpic27 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSun addObject:name];
                [listOfDetailsSun addObject:details];
                [listOfpic17 addObject:imageDataFromDb];
                [listOfpic27 addObject:imageDataFromDb2];
                
            }
        }
        
        
        sqlite3_finalize(searchStatement);
    }
}
//********************************************  END Normal *********************************************


//********************* Hard ***********************************************************************

-(void)getRecHard{
    NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *documentsDirectory = [paths objectAtIndex:0];
    NSString *path = [documentsDirectory stringByAppendingPathComponent:@"FSS2.sqlite"];
    
    if (sqlite3_open([path UTF8String], &database) == SQLITE_OK)
    {
        
        const char *sqlMon = "SELECT * FROM Schdule WHERE day = 'mon'AND Level = 'high'";
        const char *sqlTue = "SELECT * FROM Schdule WHERE day = 'tue'AND Level = 'high'";
        const char *sqlWed = "SELECT * FROM Schdule WHERE day = 'wed'AND Level = 'high'";
        const char *sqlThu = "SELECT * FROM Schdule WHERE day = 'thu'AND Level = 'high'";
        const char *sqlFri = "SELECT * FROM Schdule WHERE day = 'fri'AND Level = 'high'";
        const char *sqlSat = "SELECT * FROM Schdule WHERE day = 'sat'AND Level = 'high'";
        const char *sqlSun = "SELECT * FROM Schdule WHERE day = 'sun'AND Level = 'high'";
        
        sqlite3_stmt *searchStatement;
        
        
        if (sqlite3_prepare_v2(database, sqlMon, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItems = [[NSMutableArray alloc] init];
            listOfDetails =[[NSMutableArray alloc] init];
            listOfpic1 =[[NSMutableArray alloc] init];
            listOfpic2 =[[NSMutableArray alloc] init];
            
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                // NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItems addObject:name];
                [listOfDetails addObject:details];
                [listOfpic1 addObject:imageDataFromDb];
                [listOfpic2 addObject:imageDataFromDb2];
                
                
                
            }
        }
        if (sqlite3_prepare_v2(database, sqlTue, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsTue = [[NSMutableArray alloc] init];
            listOfDetailsTue =[[NSMutableArray alloc] init];
            listOfpic12 =[[NSMutableArray alloc] init];
            listOfpic22 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsTue addObject:name];
                [listOfDetailsTue addObject:details];
                [listOfpic12 addObject:imageDataFromDb];
                [listOfpic22 addObject:imageDataFromDb2];
                
                
            }
        }
        if (sqlite3_prepare_v2(database, sqlWed, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsWed = [[NSMutableArray alloc] init];
            listOfDetailsWed =[[NSMutableArray alloc] init];
            listOfpic13 =[[NSMutableArray alloc] init];
            listOfpic23 =[[NSMutableArray alloc] init];
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsWed addObject:name];
                [listOfDetailsWed addObject:details];
                [listOfpic13 addObject:imageDataFromDb];
                [listOfpic23 addObject:imageDataFromDb2];
                
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlThu, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsThu = [[NSMutableArray alloc] init];
            listOfDetailsThu =[[NSMutableArray alloc] init];
            listOfpic14 =[[NSMutableArray alloc] init];
            listOfpic24 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsThu addObject:name];
                [listOfDetailsThu addObject:details];
                [listOfpic14 addObject:imageDataFromDb];
                [listOfpic24 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlFri, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsFri = [[NSMutableArray alloc] init];
            listOfDetailsFri =[[NSMutableArray alloc] init];
            listOfpic15 =[[NSMutableArray alloc] init];
            listOfpic25 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsFri addObject:name];
                [listOfDetailsFri addObject:details];
                [listOfpic15 addObject:imageDataFromDb];
                [listOfpic25 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSat, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSat = [[NSMutableArray alloc] init];
            listOfDetailsSat =[[NSMutableArray alloc] init];
            listOfpic16 =[[NSMutableArray alloc] init];
            listOfpic26 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSat addObject:name];
                [listOfDetailsSat addObject:details];
                [listOfpic16 addObject:imageDataFromDb];
                [listOfpic26 addObject:imageDataFromDb2];
                
            }
        }
        
        if (sqlite3_prepare_v2(database, sqlSun, -1, &searchStatement, NULL) == SQLITE_OK)
        {
            
            listOfItemsSun = [[NSMutableArray alloc] init];
            listOfDetailsSun =[[NSMutableArray alloc] init];
            listOfpic17 =[[NSMutableArray alloc] init];
            listOfpic27 =[[NSMutableArray alloc] init];
            
            
            
            while (sqlite3_step(searchStatement) == SQLITE_ROW)
            {
                
                NSString *name = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 1)];
                NSString *details = [NSString stringWithUTF8String:(char *)sqlite3_column_text(searchStatement, 2)];
                NSData *imageDataFromDb = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 5) length:sqlite3_column_bytes(searchStatement, 5)];
                NSData *imageDataFromDb2 = [[NSData alloc]initWithBytes:sqlite3_column_blob(searchStatement, 6) length:sqlite3_column_bytes(searchStatement, 6)];
                
                
                //NSLog(@"Name: %@ ,Details: %@ ,@image: %@ ", name,details,imageDataFromDb);
                [listOfItemsSun addObject:name];
                [listOfDetailsSun addObject:details];
                [listOfpic17 addObject:imageDataFromDb];
                [listOfpic27 addObject:imageDataFromDb2];
                
            }
        }
        
        
        sqlite3_finalize(searchStatement);
    }
}



//********************************************  END Hard *********************************************



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 7 ;
}
- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    
    if(section == 0)
        return @"วันจันทร์";
    else if (section == 1)
    {
        return @"วันอังคาร";
    }else if (section == 2)
    {
        return @"วันพุธ";
    }else if (section == 3)
    {
        return @"วันพฤหัสบดี";
    }else if (section == 4)
    {
        return @"วันศุกร์";
    }else if (section == 5)
    {
        return @"วันเสาร์";
    }else if (section == 6)
    {
        return @"วันอาทิตย์";
    }
    return 0;
}
- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section
{
    // Background color
    view.tintColor = [UIColor yellowColor];
    
    // Text Color
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setTextColor:[UIColor blackColor]];
    
    // Another way to set the background color
    // Note: does not preserve gradient effect of original header
    // header.contentView.backgroundColor = [UIColor blackColor];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if (section == 0) {
        return [listOfItems count];
        
    } else if (section == 1) {
        
        return [listOfItemsTue count];
        
    } else if (section == 2) {
        
        return [listOfItemsWed count];
        
    }  else if (section == 3) {
        
        return [listOfItemsThu count];
        
    } else if (section == 4) {
        
        return [listOfItemsFri count];
        
    } else if (section == 5) {
        
        return [listOfItemsSat count];
        
    } else if (section == 6) {
        
        return [listOfItemsSun count];
    }
    return 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    
    static NSString *simpleTableIdentifier =@"Cell";
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    if(cell == nil){
        cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    if (indexPath.section == 0) {
        cell.textLabel.text = [listOfItems objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetails objectAtIndex:indexPath.row];

    }
    else if(indexPath.section == 1){
        cell.textLabel.text = [listOfItemsTue objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsTue objectAtIndex:indexPath.row];

    } else if(indexPath.section == 2){
        cell.textLabel.text = [listOfItemsWed objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsWed objectAtIndex:indexPath.row];
        
    }  else if(indexPath.section == 3){
        cell.textLabel.text = [listOfItemsThu objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsThu objectAtIndex:indexPath.row];
        
    }  else if(indexPath.section == 4){
        cell.textLabel.text = [listOfItemsFri objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsFri objectAtIndex:indexPath.row];
        
    }  else if(indexPath.section == 5){
        cell.textLabel.text = [listOfItemsSat objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsSat objectAtIndex:indexPath.row];
        
    } else if(indexPath.section == 6){
        cell.textLabel.text = [listOfItemsSun objectAtIndex:indexPath.row];
        cell.detailTextLabel.text = [listOfDetailsSun objectAtIndex:indexPath.row];
        
    }

    return cell;
}

-(void)tableView:(UITableView *)tableView accessoryButtonTappedForRowWithIndexPath:(NSIndexPath *)indexPath{
    
    //UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
  
   // NSLog(@"Click");
    if (indexPath.section == 0) {
        arpic1 = [listOfpic1 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic2 objectAtIndex:indexPath.row];
        
    } else if (indexPath.section == 1){
        arpic1 = [listOfpic12 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic22 objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 2){
        arpic1 = [listOfpic13 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic23 objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 3){
        arpic1 = [listOfpic14 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic24 objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 4){
        arpic1 = [listOfpic15 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic25 objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 5){
        arpic1 = [listOfpic16 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic26 objectAtIndex:indexPath.row];
        
    }else if (indexPath.section == 6){
        arpic1 = [listOfpic17 objectAtIndex:indexPath.row];
        arpic2 = [listOfpic27 objectAtIndex:indexPath.row];
    }
  
    [self performSegueWithIdentifier:@"popview" sender:self];

    
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *selectedCell = [tableView cellForRowAtIndexPath:indexPath];
    
    
    if ([selectedCell accessoryType] == UITableViewCellAccessoryDetailButton) {
        [selectedCell setAccessoryType:UITableViewCellAccessoryCheckmark];
        
    } else {
        [selectedCell setAccessoryType:UITableViewCellAccessoryDetailButton];
    }
    
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    
}
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UIViewController *newVC = segue.destinationViewController;
    popview *destViewController = segue.destinationViewController;
   // destViewController.NameExe = NameHvPass;
    destViewController.imagecontents = arpic1;
    destViewController.imagecontents2=arpic2;
    
    
    [Rec setPresentationStyleForSelfController:self presentingController:newVC];
    
    
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
