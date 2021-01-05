//
//  TGLoginViewController.m
//  TGAIAWiFi
//
//  Created by admin on 2021/1/4.
//

#import "TGLoginViewController.h"
#import "TGEditPwdInputMobileViewController.h"

@interface TGLoginViewController ()

@property (weak, nonatomic) IBOutlet UIButton *editPwdBtn;//修改密码按钮
@property (weak, nonatomic) IBOutlet UITextField *pwdField;//密码输入框
@property (weak, nonatomic) IBOutlet UITextField *mobileField;//手机号输入框
@property (weak, nonatomic) IBOutlet UIButton *loginBtn;//登录按钮
@property (weak, nonatomic) IBOutlet UIButton *serviceBtn;//联系客服按钮
@end

@implementation TGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
}
-(void)configUI{
    self.isHidenNaviBar = YES;
    ViewRadius(self.loginBtn, 22.5);
}
#pragma mark - 各种点击事件

/// 修改密码点击事件
/// @param sender 按钮
- (IBAction)changePasswordButtonTapped:(id)sender {
    TGEditPwdInputMobileViewController *edit = [[TGEditPwdInputMobileViewController alloc] init];
    [self.navigationController pushViewController:edit animated:YES];
}

/// 登录点击事件
/// @param sender 按钮
- (IBAction)loginButtonTapped:(id)sender {
}

/// 联系客服点击事件
/// @param sender 联系客服
- (IBAction)contactServiceButtonTapped:(id)sender {
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
