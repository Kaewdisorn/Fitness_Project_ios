//
//  popview.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/20/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "popview.h"

@interface popview ()

@end

@implementation popview

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UIImage *aImage,*bImage;
    aImage = [UIImage imageWithData:_imagecontents];
    bImage = [UIImage imageWithData:_imagecontents2];
    
    _imgview.animationImages = [NSArray arrayWithObjects:aImage,bImage, nil];
    _imgview.animationDuration = 1.0;
    [_imgview startAnimating];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (IBAction)diss:(id)sender {
    
    [self dismissViewControllerAnimated:YES completion:Nil];

}

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    [self dismissViewControllerAnimated:YES completion:Nil];

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
