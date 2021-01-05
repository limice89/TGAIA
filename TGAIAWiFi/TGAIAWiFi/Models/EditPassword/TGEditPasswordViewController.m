//
//  TGEditPasswordViewController.m
//  TGAIAWiFi
//
//  Created by admin on 2021/1/4.
//

#import "TGEditPasswordViewController.h"

@interface TGEditPasswordViewController ()
@property (weak, nonatomic) IBOutlet UITextField *pwdField1;//密码输入框1
@property (weak, nonatomic) IBOutlet UITextField *pwdField2;//密码输入框2
@property (weak, nonatomic) IBOutlet UIButton *doneBtn;//完成按钮
@end

@implementation TGEditPasswordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"重置密码";
    [self defaultShowDynamicNav];////导航大标题展示
    // Do any additional setup after loading the view from its nib.
}
-(void)configUI{
    ViewRadius(self.doneBtn, 20);
}
#pragma mark - 完成修改密码按钮点击事件

- (IBAction)doneButtonTapped:(id)sender {
    
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
