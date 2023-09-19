//
//  DYVideoStatus.h
//  DYIDou
//
//  Created by ByteDance on 2023/9/19.
//

#ifndef DYPlayerConfig_h
#define DYPlayerConfig_h

typedef NS_ENUM(NSInteger, DYPlayerStatus) {
    DYPlayerStatusPlaying,
    DYPlayerStatusPausing,
    DYPlayerStatusFinished
};

// block
#ifndef DY_BLOCK_INVOKE
#define DY_BLOCK_INVOKE(block, ...)   (block ? block(__VA_ARGS__) : 0)
#endif

#endif /* DYVideoStatus_h */
