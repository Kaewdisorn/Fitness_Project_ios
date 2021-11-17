//
//  popup.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "popup.h"

@interface popup ()

@end

@implementation popup

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.tool.text = _t1contents;
    self.play.text = _t2contents;
    self.tech.text = _t3contents;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)dissFunc:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];
}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:Nil];
    
}


@end
