//
//  ViewController.m
//  UMSDKDemo
//
//  Created by He on 2018/3/22.
//  Copyright © 2018年 He. All rights reserved.
//

#import "ViewController.h"
#import <UMShare/UMShare.h>
#import <UShareUI/UShareUI.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UITextField *content;
@property (weak, nonatomic) IBOutlet UITextField *sharetitle;


@end

@implementation ViewController
- (IBAction)qqlogin:(id)sender {
    [self login:UMSocialPlatformType_QQ];
}
- (IBAction)wechatlogin:(id)sender {
    [self login:UMSocialPlatformType_WechatSession];
    
}
- (IBAction)weibologin:(id)sender {
    [self login:UMSocialPlatformType_Sina];
}
- (void)login:(UMSocialPlatformType)type {
  
    [[UMSocialManager defaultManager] getUserInfoWithPlatform:type currentViewController:self completion:^(id result, NSError *error) {
        UMSocialUserInfoResponse* resp = result;
        NSLog(@"%@+%@+%@+%@+%@+%@+%@+%@+",resp.uid,resp.accessToken,resp.expiration,resp.name,resp.iconurl,resp.unionGender,resp.refreshToken,resp.originalResponse);
    }];
    
}
- (IBAction)share:(id)sender {
    UMSocialMessageObject* message = [UMSocialMessageObject messageObject];
    UMShareImageObject* imageO = [UMShareImageObject shareObjectWithTitle:@"f" descr:@"g" thumImage:[UIImage imageNamed:@"2.png"]];
    imageO.shareImage = [UIImage imageNamed:@"1.png"];
    message.text = @"啦啦啦";
   // message.shareObject = imageO;
    UMShareWebpageObject* webO = [UMShareWebpageObject shareObjectWithTitle:@"d" descr:@"e" thumImage:[UIImage imageNamed:@"2.png"]];
    webO.webpageUrl = @"http://www.baidu.com";
    message.shareObject = webO;
    [UMSocialUIManager showShareMenuViewInWindowWithPlatformSelectionBlock:^(UMSocialPlatformType platformType, NSDictionary *userInfo) {
        [[UMSocialManager defaultManager] shareToPlatform:platformType messageObject:message currentViewController:self completion:^(id result, NSError *error) {
            
        }];
    }];
    
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self.content resignFirstResponder];
    [self.sharetitle resignFirstResponder];
}

@end
