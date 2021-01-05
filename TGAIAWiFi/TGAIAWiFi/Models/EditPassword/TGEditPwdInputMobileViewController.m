//
//  TGEditPwdInputMobileViewController.m
//  TGAIAWiFi
//
//  Created by admin on 2021/1/4.
//

#import "TGEditPwdInputMobileViewController.h"
#import "TGEditPasswordViewController.h"

@interface TGEditPwdInputMobileViewController ()
@property (weak, nonatomic) IBOutlet UITextField *mobileField;//手机号输入框
@property (weak, nonatomic) IBOutlet UIButton *nextBtn;//下一步按钮

@end

@implementation TGEditPwdInputMobileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"通过手机号修改";
    [self defaultShowDynamicNav];////导航大标题展示
    // Do any additional setup after loading the view from its nib.
}
-(void)configUI{
    ViewRadius(self.nextBtn, 20);
}
#pragma mark - 下一步按钮点击事件

- (IBAction)nextButtonTapped:(id)sender {
    NSString *mobile = self.mobileField.text;
    if ([NSSTRING_CHECK_ISNULL(mobile) isEqualToString:@""]) {
        [kKeyWindow makeToast:@"请输入手机号"];
        return;
    }
    TGEditPasswordViewController *editPwd = [[TGEditPasswordViewController alloc] init];
    editPwd.mobile = mobile;
    [self.navigationController pushViewController:editPwd animated:YES];
    
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
