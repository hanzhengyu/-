//
//  HttpTool.m

//
static NSString * kBaseUrl = BASEURL;
#import "HttpTool.h"
#import "AFNetClient.h"

@implementation HttpTool

+ (void)getWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingPathComponent:path];
    
    [[AFHttpClient sharedClient] GET:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
        failure(error);
        
    }];
}

+ (void)postWithPath:(NSString *)path
             params:(NSDictionary *)params
            success:(HttpSuccessBlock)success
            failure:(HttpFailureBlock)failure {
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingString:path];
    LRLog(@"%@",url);
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        LRLog(@"===%@",responseObject);
      
        // 1成功 0操作失败 2检验不通过信息提示 -1token过期重新登录
        NSString * code = [responseObject[@"code"] stringValue];
        if ([code isEqualToString:@"0"]) {

        }else if ([code isEqualToString:@"1"]){
            // 成功
            success(responseObject[@"body"]);
         
        }else if ([code isEqualToString:@"2"]){
            [HUDTools shoInfoWithStatus:responseObject[@"message"]];
        }else if ([code isEqualToString:@"-1"]){
            [HUDTools shoInfoWithStatus:responseObject[@"message"]];
            failure(responseObject);
        }
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HUDTools shoInfoWithStatus:@"系统错误..."];
    }];
    
}
+ (void)postShowHudWithPath:(NSString *)path
                     params:(NSDictionary *)params
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure{
    [HUDTools showWithStatus:@"正在加载...."];
    //获取完整的url路径
    NSString * url = [kBaseUrl stringByAppendingString:path];
    [[AFHttpClient sharedClient] POST:url parameters:params progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        [HUDTools dismiss];
        LRLog(@"===%@",responseObject[@"message"]);
        // 0成功 1操作失败 2检验不通过信息提示 -1token过期重新登录
        NSString * code = [responseObject[@"code"] stringValue];
        
        if ([code isEqualToString:@"0"]) {
           
        }else if ([code isEqualToString:@"1"]){
            if ([[responseObject allKeys] containsObject:@"message"]&& ![responseObject[@"message"] isEqualToString:@""]) {
                 [HUDTools shoInfoWithStatus:responseObject[@"message"]];
            }
           success(responseObject[@"body"]);
        }else if ([code isEqualToString:@"2"]){
             [HUDTools shoInfoWithStatus:responseObject[@"message"]];
        }else if ([code isEqualToString:@"-1"]){
             [HUDTools shoInfoWithStatus:@"登录超时"];
            UserManngerTool *user = [UserManngerTool share];
            [user loadUserData];
            user.isLogin = NO;
            user.user.token = @"";
            [user saveUserData];
            [USERMANNGER presenLogin];
            failure(nil);
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        [HUDTools shoInfoWithStatus:@"系统错误..."];
    }];
}
+ (void)downloadWithPath:(NSString *)path
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpDownloadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    //下载
    NSURL *URL = [NSURL URLWithString:urlString];
    
    NSURLRequest *request = [NSURLRequest requestWithURL:URL];
    
    NSURLSessionDownloadTask *downloadTask = [[AFHttpClient sharedClient] downloadTaskWithRequest:request progress:^(NSProgress * _Nonnull downloadProgress) {
        
        progress(downloadProgress.fractionCompleted);
        
    } destination:^NSURL *(NSURL *targetPath, NSURLResponse *response) {
        
        //获取沙盒cache路径
        NSURL * documentsDirectoryURL = [[NSFileManager defaultManager] URLForDirectory:NSCachesDirectory inDomain:NSUserDomainMask appropriateForURL:nil create:NO error:nil];
        
        return [documentsDirectoryURL URLByAppendingPathComponent:[response suggestedFilename]];
        
        
    } completionHandler:^(NSURLResponse *response, NSURL *filePath, NSError *error) {
        
        if (error) {
            failure(error);
        } else {
            success(filePath.path);
        }
        
    }];
    
    [downloadTask resume];
    
}

+ (void)uploadImageWithPath:(NSString *)path
                     params:(NSDictionary *)params
                  thumbName:(NSString *)imagekey
                      image:(UIImage *)image
                    success:(HttpSuccessBlock)success
                    failure:(HttpFailureBlock)failure
                   progress:(HttpUploadProgressBlock)progress {
    
    //获取完整的url路径
    NSString * urlString = [kBaseUrl stringByAppendingPathComponent:path];
    
    NSData * data = UIImagePNGRepresentation(image);
    
    [[AFHttpClient sharedClient] POST:urlString parameters:params constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
        
        [formData appendPartWithFileData:data name:imagekey fileName:@"01.png" mimeType:@"image/png"];
      
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
        
        progress(uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        success(responseObject);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
      
        failure(error);
        
    }];
}


+(void)uploadImagePhotos:(UIImage *)photo
                 success:(HttpSuccessBlock)success
                 failure:(HttpFailureBlock)failure
                progress:(HttpUploadProgressBlock)progress
{
    //获取完整的url路径
    NSString * urlString = @"http://upload.moduointerface.com/upload.php";
    UserManngerTool *user = [UserManngerTool share];
    [user loadUserData];
    NSDictionary *parameters = @{ @"username" : user.user.username };
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    manager.responseSerializer.acceptableContentTypes = [NSSet setWithObject:@"text/html"];
    [[AFHttpClient sharedClient] POST:urlString parameters:parameters constructingBodyWithBlock:^(id<AFMultipartFormData>  _Nonnull formData) {
    
        NSDateFormatter *formatter=[[NSDateFormatter alloc]init];
        formatter.dateFormat=@"yyyyMMddHHmmss";
        NSString *str=[formatter stringFromDate:[NSDate date]];
        NSString *fileName=[NSString stringWithFormat:@"%@.png",str];
        UIImage *image = photo;
        NSData *imageData = UIImageJPEGRepresentation(image, 0.28);
        [formData appendPartWithFileData:imageData name:@"file" fileName:fileName mimeType:@"image/png"];
        
        
    } progress:^(NSProgress * _Nonnull uploadProgress) {
     
        progress(uploadProgress.fractionCompleted);
        NSLog(@"=====%f",uploadProgress.fractionCompleted);
        
    } success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        success(responseObject[@"message"]);
        NSLog(@"=responseObject==%@",responseObject[@"message"]);
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
   
        failure(error);
        
    }];
    
}

+(void)uploadImageWithPath:(NSString *)path photos:(NSArray *)photos params:(NSDictionary *)params success:(HttpSuccessBlock)success failure:(HttpFailureBlock)failure progress:(HttpUploadProgressBlock)progress
{

    NSDictionary *dic = @{@"enname":@"dsf",@"idcard":@"341224199202091556",@"ximg":@"dsds",@"yimg":@"dsf",@"zimg":@"sdaf"};
    [HttpTool postShowHudWithPath:path params:dic success:^(id json) {
        NSLog(@"======%@",json[@"message"]);
        NSLog(@"======%@",json);
    } failure:^(NSError *error) {
        
    }];


}

@end
