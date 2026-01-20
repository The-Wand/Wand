//
//  XcodeHelperProtocol.h
//  XcodeHelper
//
//  Created by Yoshitaka Seki on 2017/12/03.
//  Copyright © 2017年 takasek. All rights reserved.
//

#import <Foundation/Foundation.h>

// The protocol that this service will vend as its API. This header file will also need to be visible to the process hosting the service.
@protocol XcodeHelperProtocol

// Replace the API of this protocol with an API appropriate to the service you are vending.
- (void)jumpToTestsWithReply:(void (^)(NSString *))reply;
    
@end
