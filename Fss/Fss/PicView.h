//
//  PicView.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface PicView : UIViewController

@property (weak, nonatomic) IBOutlet UIImageView *imgview;

@property (strong,nonatomic) NSData *imagecontents;
@property (strong,nonatomic) NSData *imagecontents2;
@property (strong,nonatomic) NSString *exename;
@property (strong,nonatomic) NSString *t1contents;
@property (strong,nonatomic) NSString *t2contents;
@property (strong,nonatomic) NSString *t3contents;

@end
