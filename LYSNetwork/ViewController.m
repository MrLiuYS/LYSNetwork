//
//  ViewController.m
//  LYSNetwork
//
//  Created by 刘永生 on 2017/2/17.
//  Copyright © 2017年 刘永生. All rights reserved.
//

#import "ViewController.h"

#import "LYSServiceClient.h"

#import <SVProgressHUD.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *baseUrlTF;

@property (weak, nonatomic) IBOutlet UITextView *homeDataTX;



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
}


- (IBAction)touchBaseUrl:(id)sender {
    
    
    [LYSServiceClient changeBaseUrl:self.baseUrlTF.text];
    
}



- (IBAction)touchService:(id)sender {
    
    [SVProgressHUD show];
    
    
    [LYSServiceClient servicePath:API_ACCOUNT
                           params:nil
                       httpMethod:LYSServiceHttpMethodGET
                          success:^(NSURLSessionDataTask *task, id responseObject) {
                              
                          } failure:^(NSURLSessionDataTask *task, NSError *error) {
                              
                          }];
    
    
    
    
}



@end
