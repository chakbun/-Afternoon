//
//  AftMusicController.m
//  Afternoon
//
//  Created by Jaben on 15/10/25.
//  Copyright © 2015年 After. All rights reserved.
//

#import "AftMusicController.h"
#import <BmobSDK/Bmob.h>
#import <BmobSDK/BmobProFile.h>
#import <AVFoundation/AVFoundation.h>

@interface AftMusicController ()
@property (nonatomic, strong) AVAudioPlayer *audioPlayer;
@end

@implementation AftMusicController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    __weak __typeof(self) weakSelf = self;
    
    BmobQuery *bquery = [BmobQuery queryWithClassName:@"table_music"];
    [bquery findObjectsInBackgroundWithBlock:^(NSArray *array, NSError *error) {
        for(BmobObject *obj in array) {
            NSLog(@"============ 日期: %@============",obj.createdAt);
            NSLog(@"============ 音乐：%@ ============", [obj objectForKey:@"originMusic"]);
            NSLog(@"============ 歌名:%@ ============",[obj objectForKey:@"title"]);
            NSLog(@"============ 歌手：%@ ============", [obj objectForKey:@"singer"]);
            NSLog(@"============ 专辑：%@ ============", [obj objectForKey:@"musicAlbum"]);
        }
        BmobObject *obj = array[array.count - 1];
        BmobFile *musicFile = [obj objectForKey:@"originMusic"];
//        NSLog(@"============ %@ ============",musicFile);
        
        NSError *musicError = nil;
        NSLog(@"============ url:%@ ============",musicFile.url);

//        NSURL *url = [[NSURL alloc] initWithString:musicFile.url];
//        NSData *audioData = [NSData dataWithContentsOfURL:url];
//        
//        //将数据保存到本地指定位置
//        NSString *docDirPath = [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
//        NSString *filePath = [NSString stringWithFormat:@"%@/%@.mp3", docDirPath , @"temp"];
//        BOOL writeResult = [audioData writeToFile:filePath atomically:YES];
        
        //播放本地音乐
        NSString *localPath = [[NSBundle mainBundle] pathForResource:@"国际歌日本语" ofType:@"mp3"];
        NSURL *fileURL = [NSURL fileURLWithPath:localPath];
        
        weakSelf.audioPlayer = [[AVAudioPlayer alloc] initWithContentsOfURL:fileURL error:&musicError];
//        audioPlayer.volume = 1.0;
        if (!musicError) {
            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                BOOL result2 = [weakSelf.audioPlayer prepareToPlay];
                BOOL result1 = [weakSelf.audioPlayer play];
                NSLog(@"============ 444 ============");
            });

        }
    }];
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
}

@end
