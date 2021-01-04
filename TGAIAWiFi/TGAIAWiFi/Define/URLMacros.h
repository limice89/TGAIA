 //
//  URLMacros.h
//  MiAiApp
//
//  Created by 徐阳 on 2017/5/18.
//  Copyright © 2017年 徐阳. All rights reserved.
//



#ifndef URLMacros_h
#define URLMacros_h


//内部版本号 每次发版递增
#define KVersionCode 1
/*
 
 将项目中所有的接口写在这里,方便统一管理,降低耦合
 
 这里通过宏定义来切换你当前的服务器类型,
 将你要切换的服务器类型宏后面置为真(即>0即可),其余为假(置为0)
 如下:现在的状态为测试服务器
 这样做切换方便,不用来回每个网络请求修改请求域名,降低出错事件
 */

#define DevelopSever    1
#define TestSever       0
#define ProductSever    0

#if DevelopSever

/**开发服务器*/
#define URL_main @"https://yingyuan.feigetech.com:8086/"
#define URL_webmain @"https://yingyuan.feigetech.com/film/"
#define URL_download @"https://www.pgyer.com/jinzhitong"

#elif TestSever

/**测试服务器*/
//#define URL_main @"http://192.168.20.31:20000/shark-miai-service"

#elif ProductSever

/**生产服务器*/
/**正式服务器*/
#define URL_main @"http://111.164.113.203:7000/"
#define URL_webmain @"http://111.164.113.203:7001/app-h5/"
#define URL_download @"https://www.pgyer.com/jinzhi"
#endif



#pragma mark - ——————— 详细接口地址 ————————

//测试接口
//NSString *const URL_Test = @"api/recharge/price/list";
#define URL_Test @"api/cast/home/start"


#pragma mark - ——————— 用户相关 ————————
//登录
//参数：
//手机号：principal {类型：String}
//密码/验证码：credentials {类型：String}
//app类型：appType{类型：int}{值等于0}
//登录类型：loginType{类型：int}{0 手机号、密码 1 短信验证码}

#define URL_user_login @"login"
//三方登录
//openId：principal {类型：String}
//app类型：appType{类型：int}{1 淘宝 2 微信 3 QQ 4 微博 5 ios登陆}
#define URL_third_login @"appLogin"
//发送登录验证码
#define URL_sendLoginCode @"sms/sendLoginCode"
//发送修改密码验证码
#define URL_sendUpdatePwdCode @"sms/sendUpdatePwdCode"
//校验验证码
#define URL_checkRegisterSms @"user/checkRegisterSms"
//修改密码校验验证码
#define URL_checkUpdatePwdSms @"user/checkUpdatePwdSms"
//注册或绑定三方信息
#define URL_registerOrBindUser @"user/registerOrBindUser"
//发送绑定验证码
#define URL_sendBindSms @"user/sendBindSms"
//发送注册验证码
#define URL_sendRegisterSms @"user/sendRegisterSms"
//修改密码-忘记密码
#define URL_user_updatePwd @"user/updatePwd"
//绑定三方信息
#define URL_p_user_userBind @"p/user/userBind"


//个人中心信息
#define URL_usercenterInfo @"p/user/centerInfo"
//设置密码-用户第一次设置密码
#define URL_usernewsPwd @"p/user/newsPwd"
//设置用户信息
#define URL_setUserInfo @"p/user/setUserInfo"
//修改密码
#define URL_updatePwd @"p/user/updatePwd"
//查看用户信息
#define URL_userInfo @"p/user/userInfo"
//用户行为
#define URL_p_user_userBehavior @"p/user/userBehavior"
//查看用户三方信息
#define URL_p_user_userAppInfo @"p/user/userAppInfo" //GET
//解除三方绑定
#define URL_p_user_delAppLogin @"p/user/delAppLogin/" //POST 拼接appId  0 手机号 1 淘宝 2 微信 3 QQ 4 微博 5 ios

#pragma mark - ——————— 文件上传接口 ————————
//文件上传
#define URL_p_file_upload @"p/file/upload"
#pragma mark - ——————— 关联电影信息接口 ————————
//关联电影信息分页
#define URL_relationMovieCatePage @"relationMovieCatePage" //GET      relation关联ID{楼层ID}  current 当前页{默认1} size 每页大小，默认10
//关联电影信息列表
#define URL_relationMovieList @"relationMovieList" //GET  relation关联ID{对应关联类型} type 关联类型{1 楼层 2 小导航 3 影展 4 活动}

#pragma mark - ——————— 分类接口-标签信息接口 ————————
//分类信息列表-电影所需类型
#define URL_category_categoryAll @"category/categoryAll" //GET
//分类信息列表-单个类型
#define URL_category_categoryInfo @"category/categoryInfo" //GET //parentId 上级分类ID{默认为0} type 类目类型{1 电影类型 2 地区 3 年代 4 画面效果 5 语言}
#pragma mark - ——————— 小导航信息接口 ————————
//根据显示所在位置获取小导航信息
#define URL_navigationList @"navigationList" //GET //naviType 显示所在位置{1 首页 2 云影库}
#pragma mark - ——————— 影展管理接口 ————————
//分页查询-影展管理
#define URL_photoExhibition_page @"photoExhibition/page" //GET //current 当前页，默认1 size每页大小，默认10
//获取影展信息
#define URL_photoExhibition_photoExhibitionId @"photoExhibition/{photoExhibitionId}" //GET //photoExhibitionId
#pragma mark - ——————— 意见接口 ————————
//提交意见反馈
#define URL_p_opinion @"opinion"
#pragma mark - ——————— 我的订单接口 ————————
//根据订单号取消订单
#define URL_p_myOrder_cancel @"p/myOrder/cancel/"   //PUT  拼接订单号
//订单列表信息
#define URL_p_myOrder_myOrder @"p/myOrder/myOrder" //GET //current 当前页，默认1 size每页大小，默认10 status: 订单状态 1:待付款 2:已付款 3:已取消
// 订单详情信息
#define URL_p_myOrder_orderDetail @"p/myOrder/orderDetail/" //GET //orderNumber 订单号
//获取该电影可以观看的订单号和放映时间-云影院
#define URL_p_myOrder_cinemaPlayMovieOrderNumber @"p/myOrder/cinemaPlayMovieOrderNumber/" //GET movieId 电影id
//根据电影ID和放映时间获取可观看该电影的订单号
#define URL_p_myOrder_cinemaBeginPlayMovieOrderNumber @"p/myOrder/cinemaBeginPlayMovieOrderNumber/" //GET movieId 电影id //onlineWatchTime 放映时间
//可观看该电影的订单号-云影库
#define URL_p_myOrder_playOrderNumber @"p/myOrder/playOrderNumber/"    //GET movieId 电影id
//观看电影所需token
#define URL_p_myOrder_watchMovieToken @"p/myOrder/watchMovieToken/" //GET //orderNumber 订单号
#pragma mark - ——————— 楼层信息接口 ————————
#define URL_floorList @"floorList" //GET floorArea //楼层展示区域{1 首页 2 云影库}
#pragma mark - ——————— 活动信息接口 ————————
#define URL_activityInfo_activityId_ @"activityInfo/{activityId}" //GET //activityId 活动ID
#define URL_activityList @"activityList" //GET
#pragma mark - ——————— 版本接口 ————————
#define URL_version @"version/ios"  //GET
#pragma mark - ——————— 电影信息接口 ————————
//获取系统当前时间
#define URL_movie_getNow @"movie/getNow"
//电影演员信息列表
#define URL_movie_movieActorList @"movie/movieActorList/" //GET movieId 电影id
//获取未放映电影的排片时间-云影日历
#define URL_movie_movieCinemaDate @"movie/movieCinemaDate" //GET

//云影推荐-云影库
#define URL_movie_movieCinemaRecommend @"movie/movieCinemaRecommend" //GET/current 当前页，默认1 size每页大小，默认10

//首页-电影列表-放映早知道-云影院{本周} 获取本周的电影信息,下周的放映早知道
#define URL_movie_movieCinemaHome @"movie/movieCinemaHome" //GET userId 用户id 可为空
//首页-电影列表-放映早知道-云影院{最新} 获取最新一周的电影信息,最新一周的下周放映早知道
#define URL_movie_movieCinemaHomeNewest @"movie/movieCinemaHomeNewest" //GET userId 用户id 可为空
// 电影列表-云影日历 根据时间获取某一天未放映的电影排片-电影列表-云影日历
#define URL_movie_movieCinemaList @"movie/movieCinemaList" //GET //now 日历时间
//电影日历-云影库 历史的今天-电影信息
#define URL_movie_movieHistoryDay @"movie/movieHistoryDay" //GET
//电影详情信息-云影院 根据电影ID获取电影信息和影院信息
#define URL_movie_movieInfo @"movie/movieInfo/" //GET movieId 电影id
//全部影片-云影库 根据条件获取电影信息
//    categoryIdList 电影类型
//       current 当前页，默认1
//       endPrice 价格区间-结束
//       isFree 是否限时免费-云影库{0 否 1 是}
//       movieName 电影名称
//       orderBy 综合排序{1 最新上线 2 最近热播 3 评分排行}
//       regionId 地区{类型ID}
//       size 每页大小，默认10
//       startPrice 价格区间-开始
//       timeId 年代{类型ID}
#define URL_movie_movieLibrryAll @"movie/movieLibrryAll" //GET
//电影详情信息-云影库 根据电影ID获取电影信息
#define URL_movie_movieLibrryInfo @"movie/movieLibrryInfo/" //GET movieId 电影id
//云影库详情页---猜你喜欢
#define URL_movie_movieRecommend @"movie/movieRecommend/" //GET movieId 电影id
//搜索影片-云影库 根据电影名称搜索电影信息
//    categoryIdList 电影类型
//       current 当前页，默认1
//       endPrice 价格区间-结束
//       isFree 是否限时免费-云影库{0 否 1 是}
//       movieName 电影名称
//       orderBy 综合排序{1 最新上线 2 最近热播 3 评分排行}
//       regionId 地区{类型ID}
//       size 每页大小，默认10
//       startPrice 价格区间-开始
//       timeId 年代{类型ID}
#define URL_movie_movieSearch @"movie/movieSearch" //GET
//热映榜-云影库 获取播放量最多的5个电影信息
#define URL_movie_movieShowing @"movie/movieShowing" //GET
//电影预告片信息列表  根据电影ID获取电影预告片信息 movieId 电影Id
#define URL_movie_movieTrailerList @"movie/movieTrailerList/" //GET movieId
//验证观看电影token 控片系统鉴权使用 token 观看电影token
#define URL_movie_verifyWatchMovieToken @"movie/verifyWatchMovieToken" //POST
//观看电影所需token 未登录用户获取{一律试看6分钟} movie/watchMovieToken/{movieId}
#define URL_movie_watchMovieToken @"movie/watchMovieToken/" // GET movieId
#pragma mark - ——————— 电影想看接口 ————————
//传入电影id,如果电影未想看则添加想看电影，已想看则取消想看
#define URL_p_user_collection_addOrCancel @"p/user/collection/addOrCancel"//POST movieId 电影id
//用户想看电影列表-今日热映
#define URL_p_user_collection_dayShow @"p/user/collection/dayShow" //GET
//根据电影id获取该电影是否已想看
#define URL_p_user_collection_isCollection @"p/user/collection/isCollection" //GET movieId 电影id
//用户想看电影列表-未上线
#define URL_p_user_collection_notOnline @"p/user/collection/notOnline" //GET current 当前页，默认1 size每页大小，默认10
//想看用户列表-分页
#define URL_p_user_collection_page @"p/user/collection/page" //GET movieId 电影id current 当前页，默认1 size每页大小，默认10
//用户想看电影列表-今日播映和待播映
#define URL_p_usercollection_dayAndNotOnline  @"p/user/collection/dayAndNotOnline"  //GET current 当前页，默认1 size每页大小，默认10

#pragma mark - ——————— 电影搜索记录信息接口 ————————
//添加搜索记录 content 搜索内容
#define URL_p_searchLog_add @"p/searchLog/add" //POST
//清空搜索记录
#define URL_p_searchLog_empty @"p/searchLog/empty" //POST
//搜索记录分页
#define URL_p_searchLog_page @"p/searchLog/page" //GET current 当前页，默认1 size每页大小，默认10
#pragma mark - ——————— 省市区接口 ————————
//获取省市区信息
#define URL_p_area_list @"p/area/list" //GET
//根据省市区的pid获取地址信息  pid 省市区的pid(pid为0获取所有省份)
#define URL_p_area_listByPid @"p/area/listByPid"
#pragma mark - ——————— 系统消息接口 ————————
//获取系统消息接口
#define URL_p_message_count @"p/message/count" //GET
//获取我的消息列表
#define URL_p_message_myself @"p/message/myself" //GET urrent 当前页，默认1 size每页大小，默认10
//设置我的消息为已读
#define URL_p_message_myself_read @"p/message/myself/read" //POST   messageIdList
//获取系统消息列表
#define URL_p_message_system @"p/message/system" //GET urrent 当前页，默认1 size每页大小，默认10
//设置系统消息为已读
#define URL_p_message_system_read @"p/message/system/read" //POST messageIdList
#pragma mark - ——————— 观影信息接口 ————————
//观影历史-删除
#define URL_p_user_movieWatch_delWatch @"p/user/movieWatch/delWatch" //DELETE ids id数组
//观影历史-我的页面观影历史
#define URL_p_user_movieWatch_myMovieWatch @"p/user/movieWatch/myMovieWatch" //GET   current 当前页，默认1 size每页大小，默认10
//观影历史 -- 我的更多
#define URL_p_user_movieWatch_myMovieWatchAll @"p/user/movieWatch/myMovieWatchAll" //GET current 当前页，默认1 size每页大小，默认10
//修改观影信息 POST
//"isFinish": 是否观看结束{0 未结束 1 观看结束(观看至最后两分钟)}
//"movieId": 电影ID
//"watchTime":  观看时长{数据格式参照页面展示效果}
#define URL_p_user_movieWatch_upWatch @"p/user/movieWatch/upWatch" //POST
#pragma mark - ——————— 订单信息接口 ————————
//根据订单号查询该订单是否已经支付
#define URL_p_order_isPay @"p/order/isPay/" //GET orderNumber 订单号  {0 未支付 大于0 已支付}
//支付成功后,订单状态未改变时,主动查询微信/支付宝订单是否支付成功
#define URL_p_order_isPaySuccess @"p/order/isPaySuccess/"  //GET orderNumber 订单号
//根据订单号进行支付
#define URL_p_order_pay @"p/order/pay" //POST   orderNumber订单号  payType 支付方式 (1:微信支付 2:支付宝) returnUrl 支付完成回跳地址
//提交订单，返回订单流水号
#define URL_p_order_submit @"p/order/submit" //POST isFree是否为限免订单{0 否 1 是} movieCinemaIdmaId 影院信息ID  movieId 电影ID seat 座位信息 ticketCount 电影票数量 watchType 观影方式{1 线上 2 影院/线下 3 线上+影院/线下}
#pragma mark - ——————— 评论管理接口 ————————
//发表评论
#define URL_p_comment @"p/comment" //POST //content 评论内容 ip 评论人员ip，不需要前端传递 movieId 评论电影的id pic 评论图片replyId 回复的id score评分 toUserId   userId评论人员id，不需要前端传递
//获取电影评论
#define URL_comment_movie @"comment/movie/" //GET  movieId 电影id  current当前页，默认1 size 每页大小，默认10  userId 用户id
//获取某一级评论的二级评论集合 使用时拼接字符串 //GET firstCommentId// current 当前页，默认1//size每页大小，默认10 //userId用户id
#define URL_comment_firstCommentId_secordList @"comment/{firstCommentId}/secordList"
//某用户对某一个云影库电影的打分 //movieId //score //userId
#define URL_p_comment_movie_score @"p/comment/movie/score"
//获取对某一个云影院电影的点评  //movieId
#define URL_p_comment_movie_movieId_my @"p/comment/movie/{movieId}/my"
//获取某用户对某一个云影库电影的打分
#define URL_p_comment_movie_movieId_myScore @"/p/comment/movie/{movieId}/myScore"
//点赞
#define URL_p_pointLike @"p/pointLike/" //POST  commentId 评论id
//取消点赞
#define URL_p_pointUnLike @"p/pointUnLike/" //POST commentId 评论id
#pragma mark - ——————— 轮播影片接口 ————————
//获取轮播影片列表信息
#define URL_indexImgs @"indexImgs" //GET


#pragma mark - ——————— H5接口 ————————
//用户协议：
#define URL_H5_userAgreement @"userAgreement.html"

//隐私政策：
#define URL_H5_privacyPolicy @"privacyPolicy.html"

//活动详情：
#define URL_H5_activity @"activity.html"

//影展详情：
#define URL_H5_movie @"movie.html"

//分享页
#define URL_H5_share @"share.html"  //?id=3&type=1  电影id  type  1云影库2云影院

//系统消息详情页
#define URL_H5_news @"news.html"  //?id=3  消息id  
#endif /* URLMacros_h */
