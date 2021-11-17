//
//  PicView.m
//  Fss
//
//  Created by Wongsaphat Praisri on 7/4/15.
//  Copyright (c) 2015 Wongsaphat Praisri. All rights reserved.
//

#import "PicView.h"
#import "popup.h"

@interface PicView ()

@end

@implementation PicView

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.navigationItem.title = _exename;
    
    UIImage *aImage,*bImage;
    aImage = [UIImage imageWithData:_imagecontents];
    bImage = [UIImage imageWithData:_imagecontents2];
    
    _imgview.animationImages = [NSArray arrayWithObjects:aImage,bImage, nil];
    _imgview.animationDuration = 1.0;
    [_imgview startAnimating];
    
   // NSLog(@"Tools : %@",_t1contents);
   // NSLog(@"Play : %@",_t2contents);
   // NSLog(@"Trip : %@",_t3contents);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
    UIViewController *newVC = segue.destinationViewController;
    
    [PicView setPresentationStyleForSelfController:self presentingController:newVC];
     popup *detailViewController = segue.destinationViewController;
    detailViewController.t1contents = _t1contents;
    detailViewController.t2contents = _t2contents;
    detailViewController.t3contents = _t3contents;

    
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

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
