//
//  TechDetail.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/18/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "TechDetail.h"

@interface TechDetail ()

@end

@implementation TechDetail

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _Techname;
    self.txt.text = _txtdata;
    
    UIImage *aImage;
    aImage = [UIImage imageWithData:_imagecontents];
    
    _img.image = aImage;
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

@end
