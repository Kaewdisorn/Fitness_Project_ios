//
//  Home Pop.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/9/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "Home Pop.h"

@interface Home_Pop ()

- (IBAction)diss:(id)sender;
@end

@implementation Home_Pop

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
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


- (IBAction)diss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];

}
@end
