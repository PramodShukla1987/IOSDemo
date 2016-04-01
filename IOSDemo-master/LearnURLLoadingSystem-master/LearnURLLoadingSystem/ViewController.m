//
//  ViewController.m
//  LearnURLLoadingSystem
//
//  Created by Amay on 10/18/15.
//  Copyright © 2015 Beddup. All rights reserved.
//

// This demo is to learn URL Loading system
// It fetch HUDS menus, course from standford university
// It uses NSURLSession to fetch resources
// It uses AFNetworking to fetch resources
// It uses cocoaPod to manage dependency
// It will use cs50 API to fetch resources

#import "ViewController.h"
#import "AFNetworking.h"

NSString *const StandfordAPIKEY =@"dc01e6886deb9ebdf1397c6d3cdc09b6";
NSString *const BMOBAPPID =@"199f250d45da458ebf5dbd9a2da05e45";
NSString *const BMOBRESTAPIKEY =@"313150591ed8ec557302b780defc1fb5";

@interface ViewController ()



@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

/**
 *  use NSURLSession get recipe 171029 log
 *
 */
- (IBAction)logRecipe:(id)sender {

    NSURLSessionConfiguration *configure=[NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *session=[NSURLSession sessionWithConfiguration:configure];

    NSString *URLString=[NSString stringWithFormat:@"http://api.cs50.net/food/3/recipes?key=%@&id=171029&output=json",StandfordAPIKEY];
    NSURL *recipesURL=[NSURL URLWithString:URLString];
    NSURLRequest *request=[NSURLRequest requestWithURL:recipesURL];

    NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                          completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                    NSArray * result=[NSJSONSerialization JSONObjectWithData:data
                                                                                     options:NSJSONReadingAllowFragments
                                                                                       error:NULL];
                                    NSLog(@"%@",result);
                                }];

    [task resume];

}

/**
 *  Use AFNetworking to get recipe Fact
 *
 */
- (IBAction)logRecipeFact:(id)sender {

    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSURLSessionDataTask *task=[sessionManager GET:[NSString stringWithFormat:@"http://api.cs50.net/food/3/facts?key=%@&recipe=117003&output=json",StandfordAPIKEY]
                                        parameters:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                               NSLog(@"%@",responseObject);
                                            }
                                           failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                NSLog(@"error:%@",error.localizedDescription);
                                            }];
    [task resume];

}

/**
 *  Use AFNetworking to get a menu and log
 *  output json
 */

- (IBAction)logMenu:(id)sender {

    AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
    NSURLSessionDataTask *task=[sessionManager GET:[NSString stringWithFormat:@"http://api.cs50.net/food/3/menus?key=%@&sdt=2015-10-15&meal=LUNCH&output=json&callback=parseResponse",StandfordAPIKEY]
                                        parameters:nil
                                           success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                NSLog(@"%@",responseObject);
                                            }
                                           failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                NSLog(@"error:%@",error.localizedDescription);
                                            }];
    [task resume];

}


static BOOL USE_NSURLSession = YES;
- (IBAction)queryDataAndLo:(id)sender {

    if (USE_NSURLSession) {

        NSURLSessionConfiguration *configure=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configure];

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.bmob.cn/1/classes/Moments"]];
        request.HTTPMethod=@"GET";
        [request setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [request setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];

        NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                NSArray * result=[NSJSONSerialization JSONObjectWithData:data
                                                                                                 options:NSJSONReadingAllowFragments
                                                                                                   error:NULL];
                                                NSLog(@"%@",result);
                                            }];

        [task resume];
    }
    else
    {
        AFHTTPRequestSerializer *requestSerialization=[AFHTTPRequestSerializer serializer];
        [requestSerialization setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [requestSerialization setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
        AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
        sessionManager.requestSerializer=requestSerialization;

        NSURLSessionDataTask *task=[sessionManager GET:[NSString stringWithFormat:@"https://api.bmob.cn/1/classes/Moments"]
                                            parameters:nil
                                               success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                    NSLog(@"%@",responseObject);
                                                }
                                               failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                    NSLog(@"error:%@",error.localizedDescription);
                                                }];
        [task resume];

    }

}


- (IBAction)addNewData:(id)sender {
    if (USE_NSURLSession) {

        NSURLSessionConfiguration *configure=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configure];

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.bmob.cn/1/classes/Moments"]];
        request.HTTPMethod=@"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [request setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [request setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];

        NSString* body=@"{\"Description\":\"test of rest api nsurlsession\"}";
        NSLog(@"%@",body);
        request.HTTPBody=[body dataUsingEncoding:NSUTF8StringEncoding];

        NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    NSArray * result=[NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:NULL];
                                                    NSLog(@"%@",result);
                                                }];

        [task resume];
    }
    else
    {

    #warning not working , maybe its the parameters
        AFHTTPRequestSerializer *requestSerialization=[AFHTTPRequestSerializer serializer];
        [requestSerialization setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [requestSerialization setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
        [requestSerialization setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        NSString* body=@"{\"Description\":\"test of rest api nsurlsession\"}";

        AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
        sessionManager.requestSerializer=requestSerialization;


        NSURLSessionDataTask *task=[sessionManager POST:[NSString stringWithFormat:@"https://api.bmob.cn/1/classes/Moments"]
                                             parameters:body
                                                success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                    NSLog(@"%@",responseObject);
                                                }
                                                failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                    NSLog(@"error:%@",error.localizedDescription);
                                                }];
        [task resume];
        
    }

}


- (IBAction)deleteData:(id)sender {
    if (USE_NSURLSession) {

        NSURLSessionConfiguration *configure=[NSURLSessionConfiguration defaultSessionConfiguration];
        NSURLSession *session=[NSURLSession sessionWithConfiguration:configure];

        NSMutableURLRequest *request=[NSMutableURLRequest requestWithURL:[NSURL URLWithString:@"https://api.bmob.cn/1/classes/Moments/5ccfc2564d"]];
        request.HTTPMethod=@"DELETE";
        [request setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [request setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];

        NSURLSessionDataTask *task=[session dataTaskWithRequest:request
                                              completionHandler:^(NSData * _Nullable data, NSURLResponse * _Nullable response, NSError * _Nullable error) {
                                                    NSArray * result=[NSJSONSerialization JSONObjectWithData:data
                                                                                                     options:NSJSONReadingAllowFragments
                                                                                                       error:NULL];
                                                    NSLog(@"%@",result);
                                                }];

        [task resume];
    }
    else
    {
        AFHTTPRequestSerializer *requestSerialization=[AFHTTPRequestSerializer serializer];
        [requestSerialization setValue:BMOBAPPID forHTTPHeaderField:@"X-Bmob-Application-Id"];
        [requestSerialization setValue:BMOBRESTAPIKEY forHTTPHeaderField:@"X-Bmob-REST-API-Key"];
        AFHTTPSessionManager *sessionManager=[AFHTTPSessionManager manager];
        sessionManager.requestSerializer=requestSerialization;

        NSURLSessionDataTask *task=[sessionManager DELETE:@"https://api.bmob.cn/1/classes/Moments/6881ee57b2"
                                               parameters:nil
                                                  success:^(NSURLSessionDataTask * _Nonnull task, id  _Nonnull responseObject) {
                                                        NSLog(@"%@",responseObject);
                                                    }
                                                  failure:^(NSURLSessionDataTask * _Nonnull task, NSError * _Nonnull error) {
                                                        NSLog(@"error:%@",error.localizedDescription);
                                                    }];
        [task resume];
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
