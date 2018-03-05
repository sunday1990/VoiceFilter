//
//  ViewController.m
//  VoiceFilter
//
//  Created by ccSunday on 2018/2/23.
//  Copyright © 2018年 ccSunday. All rights reserved.
//

#import "ViewController.h"
#import <MultipeerConnectivity/MultipeerConnectivity.h>
/*
MCNearbyServiceBrowserDelegate：附近有用户，附近用户消失了
MCBrowserViewControllerDelegate：用户列表，点击了确定/取消按钮、显示指定的一个用户或者全部显示
 */
@interface ViewController ()<MCSessionDelegate,MCNearbyServiceBrowserDelegate,MCBrowserViewControllerDelegate>

/**
 表示一个用户
 */
@property (nonatomic, strong) MCPeerID *peerID;
/**
启用和管理Multipeer连接会话中的所有人之间的沟通。 通过Sesion，给别人发送数据。类似于Scoket
 */
@property (nonatomic, strong) MCSession *session;
/**
可以接受并处理用户请求连接的响应，没有回调，会弹出默认的提示框，并处理链接
 */
@property (nonatomic, strong) MCAdvertiserAssistant *advertiser;

/**
用于搜索附近的用户，并可以对搜索到的用户发出邀请加入某个会话中
 */
@property (nonatomic, strong) MCNearbyServiceBrowser *brower;
/**
 附近用户列表，也就是用于展示MCNearbyServiceBrowser的搜索结果
 */
@property (nonatomic, strong) MCBrowserViewController *browserViewController;
/**
 存储链接
 */
@property (nonatomic, strong) NSMutableArray *sessionArray;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    _sessionArray = [NSMutableArray array];
    [self setupMC];
}

- (void)setupMC{
    //获取设备名称
    NSString * name = [UIDevice currentDevice].name;
    //用户
    _peerID = [[MCPeerID alloc]initWithDisplayName:name];
    //为用户建立连接
    _session = [[MCSession alloc]initWithPeer:_peerID];
    //设置代理
    _session.delegate = self;
    //设置广播服务(发送方)
    _advertiser = [[MCAdvertiserAssistant alloc]initWithServiceType:@"type" discoveryInfo:nil session:_session];
    //开始广播
    [_advertiser start];
    //设置发现服务(接收方)
    _brower = [[MCNearbyServiceBrowser alloc]initWithPeer:_peerID serviceType:@"type"];
    //设置代理
    _brower.delegate = self;
    [_brower startBrowsingForPeers];

}

#pragma mark MC相关代理方法
#pragma mark MCNearbyServiceBrowserDelegate
//发现附近用户
- (void)browser:(MCNearbyServiceBrowser *)browser foundPeer:(MCPeerID *)peerID withDiscoveryInfo:(NSDictionary<NSString *,NSString *> *)info{
    if (_browserViewController == nil) {
        _browserViewController = [[MCBrowserViewController alloc]initWithServiceType:@"type" session:_session];
        _browserViewController.delegate = self;
        /**
         *  跳转发现界面
         */
        [self presentViewController:_browserViewController animated:YES completion:nil];
    }    
}

//附近用户消失了
- (void)browser:(MCNearbyServiceBrowser *)browser lostPeer:(MCPeerID *)peerID{
    
}

#pragma mark MCBrowserViewControllerDelegate
//用户点击了确定
- (void)browserViewControllerDidFinish:(MCBrowserViewController *)browserViewController{
    
}

//用户点击了取消
- (void)browserViewControllerWasCancelled:(MCBrowserViewController *)browserViewController{
    
}

#pragma mark MCSessionDelegate
//连接状态发生改变，某个会话，某个用户连接状态发生变化
- (void)session:(MCSession *)session peer:(MCPeerID *)peerID didChangeState:(MCSessionState)state{
    
}

// 接收到二进制数据，注意此处不是流。文字、图片都可以通过二进制的形式发送，但怎么区分不同的内容呢
- (void)session:(MCSession *)session didReceiveData:(NSData *)data fromPeer:(MCPeerID *)peerID{
    
}

// 接收字节流.
- (void)    session:(MCSession *)session
   didReceiveStream:(NSInputStream *)stream
           withName:(NSString *)streamName
           fromPeer:(MCPeerID *)peerID{
    
}

// 开始接受资源
- (void)                    session:(MCSession *)session
  didStartReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                       withProgress:(NSProgress *)progress{
    
}

//资源接收结束
- (void)                    session:(MCSession *)session
 didFinishReceivingResourceWithName:(NSString *)resourceName
                           fromPeer:(MCPeerID *)peerID
                              atURL:(nullable NSURL *)localURL
                          withError:(nullable NSError *)error{
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
