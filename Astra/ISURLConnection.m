//
//  ISURLConnection.m
//  Astra
//
//  Created by Soemarko Ridwan on 8/15/14.
//  Copyright (c) 2014 Integrasi Solutions. All rights reserved.
//

#import "ISURLConnection.h"

@implementation ISURLConnection

+ (void)startConnectionWithURLRequest:(NSURLRequest *)req successBlock:(void (^)(NSData *, NSURLResponse *))success failedBlock:(void (^)(NSError *))failed progressBlock:(void (^)(float))progress {

	ISURLConnection *conn = [[ISURLConnection alloc] initWithURLRequest:req];
	conn.successBlock = success;
	conn.failedBlock = failed;
	conn.progressBlock = progress;

	[conn start];

	//_successBlock = success;
	//_failedBlock = failed;
	//_progressBlock = progress;

	//_connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:YES];
}

- (id)initWithURLRequest:(NSURLRequest *)req {
	self = [super init];
	if (self) {
		_connection = [[NSURLConnection alloc] initWithRequest:req delegate:self startImmediately:NO];
	}
	return self;
}

- (void)start {
	if (_connection) {
		[_connection start];
	}
}

#pragma mark - NSURLConnection delegate

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
	_data = [[NSMutableData alloc] init];
	_bytesReceived = 0;
	_expectedResponseLength = [response expectedContentLength];
	_response = response;
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
	[_data appendData:data];
	_bytesReceived += data.length;

	if (_expectedResponseLength != NSURLResponseUnknownLength && _progressBlock) {
		_progressBlock((float)_bytesReceived / (float)_expectedResponseLength);
	}
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
	if (_failedBlock) {
		_failedBlock(error);
	}
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection {
	_successBlock(_data, _response);
}

@end
