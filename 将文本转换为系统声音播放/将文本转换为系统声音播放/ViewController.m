//
//  ViewController.m
//  将文本转换为系统声音播放
//
//  Created by yaoshuai on 2016/11/15.
//  Copyright © 2016年 yss. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *contentTextField;

/**
 语音合成器，朗读一个字符串，/'sɪnθɪ,saɪzɚ/合成器
 */
@property(nonatomic,strong) AVSpeechSynthesizer *synthesizer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

#pragma mark - 播放文本内容
- (IBAction)playSound:(id)sender {
    NSString *content = self.contentTextField.text;
    if(!content.length){
        content = @"请输入要播放的文本";
    }
    
    // 立刻停止之前没有播放完成的声音(防止快速点击)，要不得一直等到上一句念完，才念下一句
    // 谁播放、谁停止，所以这里用self.synthesizer
    [self.synthesizer stopSpeakingAtBoundary:AVSpeechBoundaryImmediate];
    
    // 实例化语言 - 默认朗读英文
    // /'ʌtərəns/ 说话、朗读
    AVSpeechUtterance *utterance = [AVSpeechUtterance speechUtteranceWithString:content];
    
    // 指定声音为中文
    // /'sɪnθɪsɪs/综合、合成
    AVSpeechSynthesisVoice *voice = [AVSpeechSynthesisVoice voiceWithLanguage:@"zh-CN"];
    utterance.voice = voice;
    
    // 朗读语言
    [self.synthesizer speakUtterance:utterance];
}

#pragma mark - 语音合成器，懒加载
- (AVSpeechSynthesizer *)synthesizer{
    if(_synthesizer == nil){
        _synthesizer = [[AVSpeechSynthesizer alloc] init];
    }
    return _synthesizer;
}

@end
