//
//  IBWebViewController.m
//  O2
//
//  Created by qilongTan on 15/10/31.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "XLWebViewController.h"
#import "XLJSHandler.h"
//#import "HeaderModel.h"
#import "AESCipher.h"
#import <YYKit.h>
#import "HoriMapViewController.h"
#import "YMActivityExhibitModel.h"

@interface XLWebViewController () <WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler>
@property (nonatomic,strong) XLJSHandler * jsHandler;
@property (nonatomic,assign) double lastProgress;//上次进度条位置
@property (nonatomic, strong) UIBarButtonItem *rightButtonItem;
@end

@implementation XLWebViewController

-(instancetype)initWithUrl:(NSString *)url {
    self = [super init];
    if (self) {
        self.url = url;
        _progressViewColor = [UIColor colorWithHexString:@"0485d1"];
    }
    return self;
}

-(void)setUrl:(NSString *)url
{
    if (_url != url) {
        _url = url;
        NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
        //加密header部分
//        NSString *headerContentStr = [[HeaderModel new] modelToJSONString];
//        NSString *headerAESStr = aesEncrypt(headerContentStr);
//        [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
        [self.webView loadRequest:request];
    }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self initWKWebView];
    //适配iOS11
    if (@available(iOS 11.0, *)){
        self.webView.scrollView.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }
    else{
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
}

#pragma mark 初始化webview
-(void)initWKWebView
{
    WKWebViewConfiguration * configuration = [[WKWebViewConfiguration alloc]init];
    //! 为userContentController添加ScriptMessageHandler，并指明name
    WKUserContentController *userContentController = [[WKUserContentController alloc] init];
     [userContentController addScriptMessageHandler:self name:@"movieJump"];
    [userContentController addScriptMessageHandler:self name:@"goback"];
    [userContentController addScriptMessageHandler:self name:@"appDisplayButton"];
    [userContentController addScriptMessageHandler:self name:@"appHideButton"];
    [userContentController addScriptMessageHandler:self name:@"updateVersion"];
    configuration.userContentController = userContentController;
    configuration.preferences.javaScriptEnabled = YES;//打开js交互
    _webConfiguration = configuration;
    _jsHandler = [[XLJSHandler alloc]initWithViewController:self configuration:configuration];
    CGFloat height = self.isTabbar?38:0;
    CGRect f = self.view.bounds;
    if (self.navigationController && self.isHidenNaviBar == NO) {
        f = CGRectMake(0, 0, self.view.bounds.size.width, kScreenHeight - kTopHeight-height-kSafeArea_Bottom);
    }
    
    self.webView = [[WKWebView alloc]initWithFrame:f configuration:configuration];
    _webView.navigationDelegate = self;
    _webView.backgroundColor = [UIColor clearColor];
    _webView.allowsBackForwardNavigationGestures =YES;//打开网页间的 滑动返回
    _webView.scrollView.decelerationRate = UIScrollViewDecelerationRateNormal;
    //监控进度
    [_webView addObserver:self forKeyPath:@"estimatedProgress" options:NSKeyValueObservingOptionNew context:nil];
    [self.view addSubview:_webView];
    //进度条
    _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
    _progressView.tintColor = _progressViewColor;
    _progressView.trackTintColor = [UIColor clearColor];
    _progressView.frame = CGRectMake(0, 0, self.view.bounds.size.width, 3.0);
    [_webView addSubview:_progressView];
    
    
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_url]];
    //加密header部分
//    NSString *headerContentStr = [[HeaderModel new] modelToJSONString];
//    NSString *headerAESStr = aesEncrypt(headerContentStr);
//    [request setValue:headerAESStr forHTTPHeaderField:@"header-encrypt-code"];
    [_webView loadRequest:request];
}



-(void)backButtonClicked
{
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }
    else {
        [super backBtnClicked];
    }
}
//-(void)setIsShowBack:(BOOL)isShowBack{
//    _isShowBack = isShowBack;
//    NSInteger VCCount = self.navigationController.viewControllers.count;
//    //下面判断的意义是 当VC所在的导航控制器中的VC个数大于1 或者 是present出来的VC时，才展示返回按钮，其他情况不展示
//    if (isShowBack && ( VCCount > 1 || self.navigationController.presentingViewController != nil)) {
//        [self addNavigationItemWithImageNames:@[@"back_icon"] isLeft:YES target:self action:@selector(backBtnClicked) tags:nil];
//
//    } else {
//        self.navigationItem.hidesBackButton = YES;
//        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
//        self.navigationItem.leftBarButtonItem = NULLBar;
//    }
//}
#pragma mark --进度条
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    
    [self updateProgress:_webView.estimatedProgress];
}

#pragma mark -  更新进度条
-(void)updateProgress:(double)progress{
    self.progressView.alpha = 1;
    if(progress > _lastProgress){
        [self.progressView setProgress:self.webView.estimatedProgress animated:YES];
    }else{
        [self.progressView setProgress:self.webView.estimatedProgress];
    }
    _lastProgress = progress;
    
    if (progress >= 1) {
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            self.progressView.alpha = 0;
            [self.progressView setProgress:0];
            _lastProgress = 0;
        });
    }
}

#pragma mark --navigation delegate
//加载完毕
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation {
    if ([NSSTRING_CHECK_ISNULL(self.title) isEqualToString:@""]) {
        self.title = webView.title;
    }
    [self updateProgress:webView.estimatedProgress];
    
    [self updateNavigationItems];
}

-(void)updateNavigationItems{
    if (self.isShowBack) {
        self.navigationItem.hidesBackButton = YES;
        UIBarButtonItem * NULLBar=[[UIBarButtonItem alloc]initWithCustomView:[UIView new]];
        self.navigationItem.leftBarButtonItem = NULLBar;
//        self.navigationItem.leftBarButtonItem = nil;
    }
}

-(void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    if(webView != self.webView) {
        decisionHandler(WKNavigationActionPolicyAllow);
        return;
    }
    //更新返回按钮
    [self updateNavigationItems];
    
    NSURL * url = navigationAction.request.URL;
//    NSString *urlrequest = navigationAction.request.URL.absoluteString;
    NSString *urlStr = [url absoluteString];
    if ([urlStr containsString:@"user_inspect_list.html"]||[urlStr containsString:@"user_work_list.html"]||[urlStr containsString:@"keypersonnel.html"]) {
        [self rightButtonItemShow:YES];
    }else{
        [self rightButtonItemShow:NO];
    }
    //打开wkwebview禁用了电话和跳转appstore 通过这个方法打开
    UIApplication *app = [UIApplication sharedApplication];
    if ([url.scheme isEqualToString:@"tel"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    if ([url.absoluteString containsString:@"itunes.apple.com"])
    {
        if ([app canOpenURL:url])
        {
            [app openURL:url];
            decisionHandler(WKNavigationActionPolicyCancel);
            return;
        }
    }
    decisionHandler(WKNavigationActionPolicyAllow);
}
///处理alert事件
- (void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler();
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
}

- (void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    //    DLOG(@"msg = %@ frmae = %@",message,frame);
//    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"温馨提示" message:message?:@"" preferredStyle:UIAlertControllerStyleAlert];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(NO);
//    }])];
//    [alertController addAction:([UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
//        completionHandler(YES);
//    }])];
//    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message;{
    if ([message.name isEqualToString:@"payByAlipay"]) {
        //支付宝
        NSString *orderId = (NSString *)message.body;
//        [self requestAliPayOrderId:orderId];
    }
}

#pragma mark -------------调用支付宝接口---------------
- (void)requestAliPayOrderId:(NSString *)orderId{
}
- (void)reuqestAliPayOrderInfo:(NSString *)orderInfo{
    [[PayManager shareInstance] payByAlipayWithOrder:orderInfo andCompleteBlock:^(NSDictionary * _Nonnull resultDic) {
        [self callJS];
    }];
}
- (void)callJS{
     [self.webView evaluateJavaScript:@"get_succeed()" completionHandler:^(id response, NSError *error) {}];
}
#pragma mark --------------调用地图------------------------
-(void)goToLocation{
    ESWeak(self, weakSelf);
    HoriMapViewController *mapController = [[HoriMapViewController alloc]init];
    mapController.lonlatBlock = ^(NSString *msg) {
        [weakSelf callJSCoordinate:msg];
    };
    [self.navigationController pushViewController:mapController animated:YES];
}
- (void)callJSCoordinate:(NSString *)coordinate{
    NSString * jsStr = [NSString stringWithFormat:@"appGetlonAndLat('%@')",coordinate];
     [self.webView evaluateJavaScript:jsStr completionHandler:^(id response, NSError *error) {}];
}
-(void)filterInfo:(UIButton *)button{
    [self.webView evaluateJavaScript:@"appGetScreen()" completionHandler:^(id response, NSError *error) {}];
}
-(void)checkUpdate{
        //更新
}
-(void)rightButtonItemShow:(BOOL)show{
    if (show) {
        self.navigationItem.rightBarButtonItem = self.rightButtonItem;
    }else{
        self.navigationItem.rightBarButtonItem = nil;
    }
}
-(void)backBtnClicked{
    [self.webView stopLoading];
    if ([self.webView canGoBack]) {
        [self.webView goBack];
    }else{
        [super backBtnClicked];
    }
}
-(UIBarButtonItem *)rightButtonItem{
    if (!_rightButtonItem) {
          UIButton * btn = [UIButton buttonWithType:UIButtonTypeCustom];
          btn.frame = CGRectMake(0, 0, 30, 30);
          [btn setTitle:@"筛选" forState:UIControlStateNormal];
          [btn addTarget:self action:@selector(filterInfo:) forControlEvents:UIControlEventTouchUpInside];
          btn.titleLabel.font = SYSTEMFONT(16);
          [btn setTitleColor:KWhiteColor forState:UIControlStateNormal];
          [btn sizeToFit];
          [btn setContentEdgeInsets:UIEdgeInsetsMake(0, 15, 0, -10)];
          _rightButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    }
    return _rightButtonItem;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)dealloc {
    [_jsHandler cancelHandler];
    self.webView.navigationDelegate = nil;
    [_webView removeObserver:self forKeyPath:@"estimatedProgress"];
}

@end
