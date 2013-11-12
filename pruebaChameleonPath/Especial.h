//
//  Especial.h
//  pruebaChameleonPath
//
//  Created by Dave on 11/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Especial : CCNode {
    
}

@property(nonatomic,readwrite,retain) NSString *especialSprite;
@property(nonatomic, readwrite) int tipo;
@property(nonatomic, readwrite) int x;
@property(nonatomic, readwrite) int y;

@end
