//
//  ISURLConnection.h
//  Astra
//
//  Created by Soemarko Ridwan on 8/15/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^progressBlock)(float);

@interface ISURLConnection : NSObject <NSURLConnectionDelegate, NSURLConnectionDataDelegate>

@property (nonatomic, copy) void (^progressBlock)(float);
@property (nonatomic, copy) void (^successBlock)(NSData *, NSURLResponse *);
@property (nonatomic, copy) void (^failedBlock)(NSError *);

@property (nonatomic) NSURLConnection *connection;
@property (nonatomic) NSURLResponse *response;
@property (nonatomic, retain) NSMutableData *data;
@property long long expectedResponseLength;
@property long long bytesReceived;

+ (void)startConnectionWithURLRequest:(NSURLRequest *)req successBlock:(void (^)(NSData *, NSURLResponse *))success failedBlock:(void (^)(NSError *))failed progressBlock:(void (^)(float))progress;

- (id)initWithURLRequest:(NSURLRequest *)req;

- (void)start;

@end
