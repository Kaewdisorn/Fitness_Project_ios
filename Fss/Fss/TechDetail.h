//
//  TechDetail.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/18/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TechDetail : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *img;
@property (weak, nonatomic) IBOutlet UITextView *txt;

@property (strong,nonatomic) NSString *Techname;
@property (strong,nonatomic) NSString *txtdata;
@property (strong,nonatomic) NSData *imagecontents;



@end
