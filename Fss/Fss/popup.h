//
//  popup.h
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface popup : UIViewController

@property (weak, nonatomic) IBOutlet UIButton *dissBut;
- (IBAction)dissFunc:(id)sender;

@property (weak, nonatomic) IBOutlet UITextView *tool;
@property (weak, nonatomic) IBOutlet UITextView *play;
@property (weak, nonatomic) IBOutlet UITextView *tech;


@property (strong,nonatomic) NSString *t1contents;
@property (strong,nonatomic) NSString *t2contents;
@property (strong,nonatomic) NSString *t3contents;

@end

