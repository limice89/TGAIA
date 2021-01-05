//
//  TGVersionViewController.m
//  TGAIAWiFi
//
//  Created by admin on 2021/1/4.
//

#import "TGVersionViewController.h"

@interface TGVersionViewController ()
@property (weak, nonatomic) IBOutlet UIView *backView;

@end

@implementation TGVersionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)configUI{
    self.title = @"版本信息";
    [self defaultShowDynamicNav];
    ViewRadius(self.backView, 10);
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
