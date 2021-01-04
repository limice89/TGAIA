//
//  IECWebViewController.m
//  IEnjoyCar
//
//  Created by admin on 2019/11/26.
//  Copyright © 2019 iEnjoyCar. All rights reserved.
//

#import "IECWebViewController.h"
#import <WebKit/WKWebView.h>
#import <WebKit/WebKit.h>
typedef enum{
    loadWebURLString = 0,
    loadWebHTMLString,
    POSTWebURLString,
}wkWebLoadType;
#define BackButtonWidth  40 //返回按钮默认展示极小宽度是 60
static void *WkwebBrowserContext = &WkwebBrowserContext;
@interface IECWebViewController ()<WKNavigationDelegate,WKUIDelegate,WKScriptMessageHandler,UINavigationControllerDelegate,UINavigationBarDelegate>

@property (nonatomic, strong) WKWebView *wkWebView;
//设置加载进度条
@property (nonatomic,strong) UIProgressView *progressView;
//仅当第一次的时候加载本地JS
@property(nonatomic,assign) BOOL needLoadJSPOST;
//网页加载的类型
@property(nonatomic,assign) wkWebLoadType loadType;
//保存的网址链接
@property (nonatomic, copy) NSString *URLString;
//保存POST请求体
@property (nonatomic, copy) NSString *postData;
//保存请求链接
@property (nonatomic)NSMutableArray* snapShotsArray;
//返回按钮
@property (nonatomic, strong) UIButton *customeBackBtn;
//关闭按钮
@property (nonatomic, strong) UIButton *closeBtn;
//标题
@property (nonatomic, strong) UILabel *titleLbl;
//导航
@property (nonatomic, strong) UIView *navView;
@end

@implementation IECWebViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    ESWeak(self, weakSelf);
        //加载web页面
    //    [self webViewloadURLType];
        //添加到主控制器上
        [self.view addSubview:self.wkWebView];
        //添加进度条
        [self.view addSubview:self.progressView];
        // 下拉刷新
        self.wkWebView.scrollView.mj_header= [MJRefreshHeader headerWithRefreshingBlock:^{
            [weakSelf webViewloadURLType];
            // 结束刷新
            [weakSelf.wkWebView.scrollView.mj_header endRefreshing];
        }];
        // 马上进入刷新状态
        [self.wkWebView.scrollView.mj_header beginRefreshing];
    // Do any additional setup after loading the view.
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    if (!self.isHidenNaviBar) {
        [self configNavView];
    }else{
    }
}
-(void)setBottomHeight:(CGFloat)bottomHeight{
    _bottomHeight = bottomHeight;
    
    CGFloat top = self.isHidenNaviBar?kStatusBarHeight:kTopHeight;
    self.wkWebView.frame = CGRectMake(0, top, KScreenWidth, KScreenHeight-top-bottomHeight);
}
//-(void)setIsNavHidden:(BOOL)isNavHidden{
//    _isNavHidden = isNavHidden;
//    if (!isNavHidden) {
//        [self defaultShowDynamicNav:@""];
//        [self.dynamicNavView handleDefaultNormalNavigationBar];
//    }else{
//
//    }
//}
//-(void)setBottomHeight:(CGFloat)bottomHeight{
//    _bottomHeight = bottomHeight;
//    [self.webView mas_updateConstraints:^(MASConstraintMaker *make) {
//        make.bottom.equalTo(self.view.mas_bottom).offset(bottomHeight);
//    }];
//}

- (void)roadLoadClicked{
    [self.wkWebView reload];
}

-(void)customBackItemClicked{
    [self.wkWebView goBack];
//    if (self.wkWebView.goBack) {
//        [self.wkWebView goBack];
//    }else{
//        [self.navigationController popViewControllerAnimated:YES];
//    }
}
-(void)closeItemClicked{
    [self.navigationController popViewControllerAnimated:YES];
}

#pragma mark ================ 加载方式 ================

- (void)webViewloadURLType{
    switch (self.loadType) {
        case loadWebURLString:{
            //创建一个NSURLRequest 的对象
            NSURLRequest * Request_zsj = [NSURLRequest requestWithURL:[NSURL URLWithString:self.URLString] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:10];
            //加载网页
            [self.wkWebView loadRequest:Request_zsj];
            break;
        }
        case loadWebHTMLString:{
            [self loadHostPathURL:self.URLString];
            break;
        }
        case POSTWebURLString:{
            // JS发送POST的Flag，为真的时候会调用JS的POST方法
            self.needLoadJSPOST = YES;
            //POST使用预先加载本地JS方法的html实现，请确认WKJSPOST存在
            [self loadHostPathURL:@"WKJSPOST"];
            break;
        }
    }
}

- (void)loadHostPathURL:(NSString *)url{
    //获取JS所在的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:url ofType:@"html"];
    //获得html内容
    NSString *html = [[NSString alloc] initWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    //加载js
    [self.wkWebView loadHTMLString:html baseURL:[[NSBundle mainBundle] bundleURL]];
}

// 调用JS发送POST请求
- (void)postRequestWithJS {
    // 拼装成调用JavaScript的字符串
    NSString *jscript = [NSString stringWithFormat:@"post('%@',{%@});", self.URLString, self.postData];
    // 调用JS代码
    [self.wkWebView evaluateJavaScript:jscript completionHandler:^(id object, NSError * _Nullable error) {
    }];
}


- (void)loadWebURLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebURLString;
}

- (void)loadWebHTMLSring:(NSString *)string{
    self.URLString = string;
    self.loadType = loadWebHTMLString;
}

- (void)POSTWebURLSring:(NSString *)string postData:(NSString *)postData{
    self.URLString = string;
    self.postData = postData;
    self.loadType = POSTWebURLString;
}

//#pragma mark   ============== URL pay 开始支付 ==============
//
//- (void)payWithUrlOrder:(NSString*)urlOrder
//{
//    if (urlOrder.length > 0) {
//        __weak XFWkwebView* wself = self;
//        [[AlipaySDK defaultService] payUrlOrder:urlOrder fromScheme:@"giftcardios" callback:^(NSDictionary* result) {
//            // 处理支付结果
//            NSLog(@"===============%@", result);
//            // isProcessUrlPay 代表 支付宝已经处理该URL
//            if ([result[@"isProcessUrlPay"] boolValue]) {
//                // returnUrl 代表 第三方App需要跳转的成功页URL
//                NSString* urlStr = result[@"returnUrl"];
//                [wself loadWithUrlStr:urlStr];
//            }
//        }];
//    }
//}
//
//- (void)WXPayWithParam:(NSDictionary *)WXparam{
//
//}
////url支付成功回调地址
//- (void)loadWithUrlStr:(NSString*)urlStr
//{
//    if (urlStr.length > 0) {
//        dispatch_async(dispatch_get_main_queue(), ^{
//            NSURLRequest *webRequest = [NSURLRequest requestWithURL:[NSURL URLWithString:urlStr] cachePolicy:NSURLRequestReturnCacheDataElseLoad
//                                                    timeoutInterval:15];
//            [self.wkWebView loadRequest:webRequest];
//        });
//    }
//}

#pragma mark ================ 自定义返回/关闭按钮 ================

-(void)updateNavigationItems{
    if (self.wkWebView.canGoBack) {
        self.customeBackBtn.hidden = NO;
//        self.closeBtn.frame = CGRectMake(20+BackButtonWidth, statusBar_height, BackButtonWidth, 40);
//        self.customeBackBtn.frame = CGRectMake(10, statusBar_height, BackButtonWidth, 40);
    }else{
        self.customeBackBtn.hidden = YES;
//        self.closeBtn.frame = CGRectMake(10, statusBar_height, BackButtonWidth, 40);
    }
}
//请求链接处理
-(void)pushCurrentSnapshotViewWithRequest:(NSURLRequest*)request{
    //    NSLog(@"push with request %@",request);
    NSURLRequest* lastRequest = (NSURLRequest*)[(NSDictionary *)[self.snapShotsArray lastObject] objectForKey:@"request"];
    
    //如果url是很奇怪的就不push
    if ([request.URL.absoluteString isEqualToString:@"about:blank"]) {
        //        NSLog(@"about blank!! return");
        return;
    }
    //如果url一样就不进行push
    if ([lastRequest.URL.absoluteString isEqualToString:request.URL.absoluteString]) {
        return;
    }
    if ([request.URL.absoluteString.lowercaseString containsString:@"api/paypalnotify/returnurlfail"]||[request.URL.absoluteString.lowercaseString containsString:@"api/paypalnotify/cancelurl"]) {
        //取消或者失败
        if (self.paysuccess) {
            self.paysuccess(@"");
            return;
        }
    }else if ([request.URL.absoluteString.lowercaseString containsString:@"api/paypalnotify/returnurlsucc"]){
        NSArray *arr = [request.URL.absoluteString componentsSeparatedByString:@"/"];
        NSString *order_id = (NSString *)arr.lastObject;
        if (self.paysuccess) {
            self.paysuccess(order_id);
            return;
        }
    }
    UIView* currentSnapShotView = [self.wkWebView snapshotViewAfterScreenUpdates:YES];
    [self.snapShotsArray addObject:
     @{@"request":request,@"snapShotView":currentSnapShotView}];
}

#pragma mark ================ WKNavigationDelegate ================

//这个是网页加载完成，导航的变化
-(void)webView:(WKWebView *)webView didFinishNavigation:(WKNavigation *)navigation{
    /*
     主意：这个方法是当网页的内容全部显示（网页内的所有图片必须都正常显示）的时候调用（不是出现的时候就调用），，否则不显示，或则部分显示时这个方法就不调用。
     */
    // 判断是否需要加载（仅在第一次加载）
    if (self.needLoadJSPOST) {
        // 调用使用JS发送POST请求的方法
        [self postRequestWithJS];
        // 将Flag置为NO（后面就不需要加载了）
        self.needLoadJSPOST = NO;
    }
    // 获取加载网页的标题
    if (!self.isHidenNaviBar) {
        self.titleLbl.text = self.wkWebView.title;
//        [self defaultShowDynamicNav:self.wkWebView.title];
//        [self.dynamicNavView handleDefaultNormalNavigationBar];
//        self.dynamicNavView.bigTitleView.hidden = YES;
    }else{
        
    }
    
//    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:NO];
    [self updateNavigationItems];
}

//开始加载
-(void)webView:(WKWebView *)webView didStartProvisionalNavigation:(WKNavigation *)navigation{
    //开始加载的时候，让加载进度条显示
    self.progressView.hidden = NO;
}

//内容返回时调用
-(void)webView:(WKWebView *)webView didCommitNavigation:(WKNavigation *)navigation{}

//服务器请求跳转的时候调用
-(void)webView:(WKWebView *)webView didReceiveServerRedirectForProvisionalNavigation:(WKNavigation *)navigation{}

//服务器开始请求的时候调用
- (void)webView:(WKWebView *)webView decidePolicyForNavigationAction:(WKNavigationAction *)navigationAction decisionHandler:(void (^)(WKNavigationActionPolicy))decisionHandler {
    
    
    switch (navigationAction.navigationType) {
        case WKNavigationTypeLinkActivated: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeFormSubmitted: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        case WKNavigationTypeBackForward: {
            break;
        }
        case WKNavigationTypeReload: {
            break;
        }
        case WKNavigationTypeFormResubmitted: {
            break;
        }
        case WKNavigationTypeOther: {
            [self pushCurrentSnapshotViewWithRequest:navigationAction.request];
            break;
        }
        default: {
            break;
        }
    }
    [self updateNavigationItems];
    decisionHandler(WKNavigationActionPolicyAllow);
}

// 内容加载失败时候调用
-(void)webView:(WKWebView *)webView didFailProvisionalNavigation:(WKNavigation *)navigation withError:(NSError *)error{
    NSLog(@"页面加载超时");
}

//跳转失败的时候调用
-(void)webView:(WKWebView *)webView didFailNavigation:(WKNavigation *)navigation withError:(NSError *)error{}

//进度条
-(void)webViewWebContentProcessDidTerminate:(WKWebView *)webView{}

#pragma mark ================ WKUIDelegate ================

// 获取js 里面的提示
-(void)webView:(WKWebView *)webView runJavaScriptAlertPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(void))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:IECLocalized(@"提示") message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:IECLocalized(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler();
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
}

// js 信息的交流
-(void)webView:(WKWebView *)webView runJavaScriptConfirmPanelWithMessage:(NSString *)message initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(BOOL))completionHandler{
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:IECLocalized(@"提示") message:message preferredStyle:UIAlertControllerStyleAlert];
    [alert addAction:[UIAlertAction actionWithTitle:IECLocalized(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(YES);
    }]];
    [alert addAction:[UIAlertAction actionWithTitle:IECLocalized(@"取消") style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        completionHandler(NO);
    }]];
    [self presentViewController:alert animated:YES completion:NULL];
}

// 交互。可输入的文本。
-(void)webView:(WKWebView *)webView runJavaScriptTextInputPanelWithPrompt:(NSString *)prompt defaultText:(NSString *)defaultText initiatedByFrame:(WKFrameInfo *)frame completionHandler:(void (^)(NSString * _Nullable))completionHandler{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"textinput" message:IECLocalized(@"JS调用输入框") preferredStyle:UIAlertControllerStyleAlert];
    [alert addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        textField.textColor = [UIColor redColor];
    }];
    [alert addAction:[UIAlertAction actionWithTitle:IECLocalized(@"确定") style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        completionHandler([[alert.textFields lastObject] text]);
    }]];
    
    [self presentViewController:alert animated:YES completion:NULL];
    
}

//KVO监听进度条
- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context {
    
    if ([keyPath isEqualToString:NSStringFromSelector(@selector(estimatedProgress))] && object == self.wkWebView) {
        [self.progressView setAlpha:1.0f];
        BOOL animated = self.wkWebView.estimatedProgress > self.progressView.progress;
        [self.progressView setProgress:self.wkWebView.estimatedProgress animated:animated];
        
        // Once complete, fade out UIProgressView
        if(self.wkWebView.estimatedProgress >= 1.0f) {
            [UIView animateWithDuration:0.3f delay:0.3f options:UIViewAnimationOptionCurveEaseOut animations:^{
                [self.progressView setAlpha:0.0f];
            } completion:^(BOOL finished) {
                [self.progressView setProgress:0.0f animated:NO];
            }];
        }
    }
    else {
        [super observeValueForKeyPath:keyPath ofObject:object change:change context:context];
    }
}

#pragma mark ================ WKScriptMessageHandler ================

//拦截执行网页中的JS方法
- (void)userContentController:(WKUserContentController *)userContentController didReceiveScriptMessage:(WKScriptMessage *)message{
    
    //服务器固定格式写法 window.webkit.messageHandlers.名字.postMessage(内容);
    //客户端写法 message.name isEqualToString:@"名字"]
    if ([message.name isEqualToString:@"WXPay"]) {
        NSLog(@"%@", message.body);
        //调用微信支付方法
        //        [self WXPayWithParam:message.body];
    }
}
#pragma mark -- 配置navView
- (void)configNavView{
    [self.view addSubview:self.navView];
    [self.navView addSubview:self.titleLbl];
    [self.navView addSubview:self.closeBtn];
    [self.navView addSubview:self.customeBackBtn];
    @weakify(self)
//    RAC(self.customeBackBtn, hidden) = [RACObserve(self.wkWebView, canGoBack) map:^id(NSNumber *canGoBackNum) {
//        @strongify(self)
//        if (canGoBackNum.boolValue) {
//            self.customeBackBtn.hidden = NO;
//        } else {
//            self.customeBackBtn.hidden = YES;
//        }
//        return @(!canGoBackNum.boolValue);
//    }];
//    self.customeBackBtn.hidden = YES;
}
#pragma mark ================ 懒加载 ================

- (WKWebView *)wkWebView{
    if (!_wkWebView) {
        //设置网页的配置文件
        WKWebViewConfiguration * Configuration = [[WKWebViewConfiguration alloc]init];
        //允许视频播放
        Configuration.allowsAirPlayForMediaPlayback = YES;
        // 允许在线播放
        Configuration.allowsInlineMediaPlayback = YES;
        // 允许可以与网页交互，选择视图
        Configuration.selectionGranularity = YES;
        // web内容处理池
        Configuration.processPool = [[WKProcessPool alloc] init];
        //自定义配置,一般用于 js调用oc方法(OC拦截URL中的数据做自定义操作)
        WKUserContentController * UserContentController = [[WKUserContentController alloc]init];
        // 添加消息处理，注意：self指代的对象需要遵守WKScriptMessageHandler协议，结束时需要移除
        [UserContentController addScriptMessageHandler:self name:@"WXPay"];
        // 是否支持记忆读取
        Configuration.suppressesIncrementalRendering = YES;
        // 允许用户更改网页的设置
        Configuration.userContentController = UserContentController;
        CGFloat top = self.isHidenNaviBar?kStatusBarHeight:kTopHeight;
        _wkWebView = [[WKWebView alloc] initWithFrame:CGRectMake(0, top, KScreenWidth, KScreenHeight-top) configuration:Configuration];
        _wkWebView.backgroundColor = [UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0];
        // 设置代理
        _wkWebView.navigationDelegate = self;
        _wkWebView.UIDelegate = self;
        //kvo 添加进度监控
        [_wkWebView addObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress)) options:0 context:WkwebBrowserContext];
        //开启手势触摸
        _wkWebView.allowsBackForwardNavigationGestures = YES;
        // 设置 可以前进 和 后退
        //适应你设定的尺寸
        [_wkWebView sizeToFit];
    }
    return _wkWebView;
}

-(UIButton *)customeBackBtn{
    if (!_customeBackBtn) {
        _customeBackBtn = [UIButton createBtnWithFrame:CGRectMake(10, kStatusBarHeight, BackButtonWidth, 40) img:@"back_icon" selectImg:@"back_icon" bgColor:nil];
        [_customeBackBtn addTarget:self action:@selector(customBackItemClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _customeBackBtn;
}
-(UIButton *)closeBtn{
    if (!_closeBtn) {
        _closeBtn = [UIButton createBtnWithFrame:CGRectMake(KScreenWidth-BackButtonWidth- 10, kStatusBarHeight, BackButtonWidth, 40) img:@"ic_x" selectImg:@"ic_x" bgColor:nil];
        [_closeBtn addTarget:self action:@selector(closeItemClicked) forControlEvents:UIControlEventTouchUpInside];
    }
    return _closeBtn;
}
-(UILabel *)titleLbl{
    if (!_titleLbl) {
        _titleLbl = [UILabel createLabelWithFrame:CGRectZero title:@"" fontSize:16 textColor:kColor333];
        _titleLbl.frame = CGRectMake(BackButtonWidth+20, kStatusBarHeight, KScreenWidth-BackButtonWidth*3, 40);
        _titleLbl.textAlignment = NSTextAlignmentCenter;
        _titleLbl.lineBreakMode = NSLineBreakByTruncatingTail;
    }
    return _titleLbl;
}
-(UIView *)navView{
    if (!_navView) {
        _navView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, KScreenWidth, kNavBarHeight+kStatusBarHeight)];
    }
    return _navView;
}
- (UIProgressView *)progressView{
    if (!_progressView) {
        _progressView = [[UIProgressView alloc]initWithProgressViewStyle:UIProgressViewStyleDefault];
        if (self.isHidenNaviBar == YES) {
            _progressView.frame = CGRectMake(0, kStatusBarHeight, self.view.bounds.size.width, 3);
        }else{
            _progressView.frame = CGRectMake(0, kTopHeight, self.view.bounds.size.width, 3);
        }
        // 设置进度条的色彩
        [_progressView setTrackTintColor:[UIColor colorWithRed:240.0/255 green:240.0/255 blue:240.0/255 alpha:1.0]];
        _progressView.progressTintColor = [UIColor redColor];
    }
    return _progressView;
}



-(NSMutableArray*)snapShotsArray{
    if (!_snapShotsArray) {
        _snapShotsArray = [NSMutableArray array];
    }
    return _snapShotsArray;
}

-(void)viewWillDisappear:(BOOL)animated{
    [super viewWillDisappear:animated];
    [self.wkWebView.configuration.userContentController removeScriptMessageHandlerForName:@"WXPay"];
    [self.wkWebView setNavigationDelegate:nil];
    [self.wkWebView setUIDelegate:nil];
}

//注意，观察的移除
-(void)dealloc{
    [self.wkWebView removeObserver:self forKeyPath:NSStringFromSelector(@selector(estimatedProgress))];
}
-(void)reloadVCData{
    [self.wkWebView.scrollView.mj_header beginRefreshing];
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
