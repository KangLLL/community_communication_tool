//
//  NSURLRequest+RequestBuilder.m
//  myAppShopper
//
//  Created by LiK on 12-4-24.
//  Copyright (c) 2012年 Adways Co.,Ltd. All rights reserved.
//

#import "NSURLRequest+RequestBuilder.h"
#import "ImageInformation.h"

#define PARAMETER_CONNECTOR     @"&"
#define REQUEST_POST            @"POST"
#define HEADER_CONTENT_LENGTH   @"Content-Length"
#define HEADER_TYPE             @"Content-Type"

#define BOUNDARY                @"------------0x0x0x0x0x0x0x0x"
#define PREFIX                  @"--"
#define LINE_END                @"\r\n"
//#define CONTENT_TYPE            @"multipart/form-data"

#define IMAGE_CONTENT           @"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\nContent-Type: image/pjpeg\r\n\r\n"
#define STRING_CONTENT          @"Content-Disposition: form-data; name=\"%@\"\r\n\r\n"
#define MULTIPART               @"multipart/form-data; boundary=------------0x0x0x0x0x0x0x0x"

/*
[self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"\r\n\r\n",[val objectForKey:@"key"]]];
[self appendPostString:[val objectForKey:@"value"]];
i++;
if (i != [[self postData] count] || [[self fileData] count] > 0) { //Only add the boundary if this is not the last item in the post body
    [self appendPostString:endItemBoundary];
}
}

// Adds files to upload
i=0;
for (NSDictionary *val in [self fileData]) {
    
    [self appendPostString:[NSString stringWithFormat:@"Content-Disposition: form-data; name=\"%@\"; filename=\"%@\"\r\n", [val objectForKey:@"key"], [val objectForKey:@"fileName"]]];
    [self appendPostString:[NSString stringWithFormat:@"Content-Type: %@\r\n\r\n", [val objectForKey:@"contentType"]]];


sb.append("Content-Disposition: form-data; name=\"")
.append(key).append("\"").append(LINE_END)
.append(LINE_END);

sb.append("Content-Disposition:form-data; name=\"" + fileKey
          + "\"; filename=\"" + file.getName() + "\"" + LINE_END);
sb.append("Content-Type:image/pjpeg" + LINE_END); // 这里配置的Content-type很重要的
// ，用于服务器端辨别文件的类型的

//#define HEADER_USER_AGENT       @"User-Agent"
*/

@implementation NSURLRequest (RequestBuilder)
+ (NSURLRequest *)requestAsWebViewWithUrl:(NSURL *)url
{
    NSMutableURLRequest *request = [NSMutableURLRequest requestWithURL:url];
    //[request setValue:[[UIDevice currentDevice] getDecorateUserAgent] forHTTPHeaderField:HEADER_USER_AGENT];
    return request;
}
 
+ (NSURLRequest *)requestAsWebViewWithMethod:(MethodType)type url:(NSString *)url parameters:(NSDictionary *)parameters
{
    NSMutableURLRequest *request = (NSMutableURLRequest *)[NSURLRequest requestWithMethod:type url:url parameters:parameters];
    //[request setValue:[[UIDevice currentDevice] getDecorateUserAgent] forHTTPHeaderField:HEADER_USER_AGENT];
    return request;
}

+ (NSData *)getPortData:(NSString *)key withValue:(id)content
{
    NSMutableData *result = [NSMutableData data];
    if([content isKindOfClass:[NSArray class]]){
        for (id c in content) {
            [result appendData:[NSURLRequest getPortData:key withValue:c]];
        }
    }
    else{
        [result appendData:[[NSString stringWithFormat:@"%@%@%@",PREFIX, BOUNDARY, LINE_END]dataUsingEncoding:NSUTF8StringEncoding]];
        if([content isKindOfClass:[ImageInformation class]]){
            ImageInformation *imageInfo = (ImageInformation *)content;
            NSString *formstring = [NSString stringWithFormat:IMAGE_CONTENT, key, imageInfo.fileName];
            [result appendData: [formstring dataUsingEncoding:NSUTF8StringEncoding]];
            [result appendData:imageInfo.imageData];
        }
        else{
            NSString *formstring = [NSString stringWithFormat:STRING_CONTENT, key];
            [result appendData: [formstring dataUsingEncoding:NSUTF8StringEncoding]];
            [result appendData:[content dataUsingEncoding:NSUTF8StringEncoding]];
        }
        [result appendData:[LINE_END dataUsingEncoding:NSUTF8StringEncoding]];
    }
    return result;
}

+ (NSURLRequest *)requestWithMethod:(MethodType)type url:(NSString *)url parameters:(NSDictionary *)parameters
{
    if(parameters == nil){
        return [NSURLRequest requestWithURL:[NSURL URLWithString:url]];
    }
    else{
        if(type == MethodGet){
            NSMutableString *parametersString = [NSMutableString string];
            for (NSString *key in parameters) {
                if([parametersString length] > 0)
                    [parametersString appendString:PARAMETER_CONNECTOR];
                NSString *equationString = [NSString stringWithFormat:@"%@=%@",key,[parameters valueForKey:key]];
                [parametersString appendString:equationString];
            }
            NSString *urlString = [NSString stringWithFormat:@"%@?%@",url,parametersString];
            NSLog(@"%@",urlString);
            return [NSURLRequest requestWithURL:[NSURL URLWithString:urlString]];
        }
        else{
            NSMutableURLRequest *resultRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
            
            NSMutableData *result = [NSMutableData data];
            NSArray *keys = [parameters allKeys];
            
            for(int i = 0; i < [keys count]; i++){
                NSString *key = [keys objectAtIndex:i];
                id value = [parameters valueForKey:key];
                [result appendData:[NSURLRequest getPortData:key withValue:value]];
            }
            
           
            NSLog(@"%@",[[NSString alloc] initWithData:result encoding:NSUTF8StringEncoding]);
            [resultRequest setHTTPMethod:REQUEST_POST];
            [resultRequest setHTTPBody:result];
            [resultRequest setValue:[NSString stringWithFormat:@"%d",(int)[result length]] forHTTPHeaderField:HEADER_CONTENT_LENGTH];
            [resultRequest setValue:MULTIPART forHTTPHeaderField:HEADER_TYPE];
            
            return resultRequest;
        }
    }
}
@end
