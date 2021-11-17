//
//  popview.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/20/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popview : UIViewController

@property (strong,nonatomic) NSString *NameExe;
@property (strong,nonatomic) NSData *imagecontents;
@property (strong,nonatomic) NSData *imagecontents2;

@property (weak, nonatomic) IBOutlet UILabel *label;
@property (weak, nonatomic) IBOutlet UIImageView *imgview;


@end
