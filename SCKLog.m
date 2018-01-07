//
/*
      ___           ___           ___                         ___           ___
     /  /\         /  /\         /__/|                       /  /\         /  /\
    /  /:/_       /  /:/        |  |:|                      /  /::\       /  /:/_
   /  /:/ /\     /  /:/         |  |:|      ___     ___    /  /:/\:\     /  /:/ /\
  /  /:/ /::\   /  /:/  ___   __|  |:|     /__/\   /  /\  /  /:/  \:\   /  /:/_/::\
 /__/:/ /:/\:\ /__/:/  /  /\ /__/\_|:|____ \  \:\ /  /:/ /__/:/ \__\:\ /__/:/__\/\:\
 \  \:\/:/~/:/ \  \:\ /  /:/ \  \:\/:::::/  \  \:\  /:/  \  \:\ /  /:/ \  \:\ /~~/:/
  \  \::/ /:/   \  \:\  /:/   \  \::/~~~~    \  \:\/:/    \  \:\  /:/   \  \:\  /:/
   \__\/ /:/     \  \:\/:/     \  \:\         \  \::/      \  \:\/:/     \  \:\/:/
     /__/:/       \  \::/       \  \:\         \__\/        \  \::/       \  \::/
     \__\/         \__\/         \__\/                       \__\/         \__\/
*/

#import "SCKLog.h"

#import <Foundation/Foundation.h>

@implementation SCKLogger

// ENDPOINT/ DISCOVERY
+ (NSString *)userDefinedEndpoint {
    return @"http://172.26.8.243:3003";
}

- (NSURL * _Nonnull)endpoint:(NSString * _Nullable)path {
    NSURLComponents *components = [[NSURLComponents alloc] initWithString:[SCKLogger userDefinedEndpoint]];
    if (path) { components.path = path; }
    return [components URL];
}

- (NSURL * _Nullable)localServerEndpoint { return [self endpoint:nil]; }
- (NSURL * _Nullable)postStartSessionURL { return [self endpoint:@"/start"]; }
- (NSURL * _Nullable)postLogURL          { return [self endpoint:@"/log"]; }

// LOGGER
+ (SCKLogger *)shared {
    static SCKLogger *logger;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        logger = [[SCKLogger alloc] init];
        logger.session = [NSString stringWithFormat:@"%@",[NSDate date]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[logger postStartSessionURL]];
        NSError *error;
        NSData *payload = [NSJSONSerialization dataWithJSONObject:@{@"session":logger.session} options:NSJSONWritingPrettyPrinted error:&error];
        if (error) { return; }
        request.HTTPBody = payload;
        request.HTTPMethod = @"POST";
        [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
        [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
    });
    return logger;
}

- (void)writeLog:(NSString *)log {
    if (![self localServerEndpoint]) { return; }

    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL:[self postLogURL]];
    NSError *error;
    NSData *payload = [NSJSONSerialization dataWithJSONObject:@{@"payload":log} options:NSJSONWritingPrettyPrinted error:&error];
    if (error) {
        payload = [NSJSONSerialization dataWithJSONObject:@{@"payload":[NSString stringWithFormat:@"%@",error.localizedDescription]} options:NSJSONWritingPrettyPrinted error:&error];
    }
    request.HTTPBody = payload;
    request.HTTPMethod = @"POST";
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    [[[NSURLSession sharedSession] dataTaskWithRequest:request] resume];
}

@end

void SCKLog(NSString *format, ...) {
    if (![[SCKLogger shared] localServerEndpoint]) { return; }

    // reference from https://code.tutsplus.com/tutorials/quick-tip-customize-nslog-for-easier-debugging--mobile-19066
    va_list ap;
    va_start (ap, format);

    NSString *log = [[NSString alloc] initWithFormat:format arguments:ap];
    [[SCKLogger shared] writeLog:log];

    va_end (ap);
}
