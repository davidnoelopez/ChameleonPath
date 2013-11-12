//
//  FinJuego.m
//  pruebaChameleonPath
//
//  Created by Dave on 11/11/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "FinJuego.h"
#import "HelloWorldLayer.h"

@implementation FinJuego

+(CCScene *) sceneWithEnd: (int) end{
    CCScene *scene = [CCScene node];
    
    FinJuego *layer = [[FinJuego alloc] initWithEnd:end];
    
    [scene addChild: layer];
    
    return scene;
}

-(id)initWithEnd:(int)end
{
    if( (self=[super init]) ) {
        self.isTouchEnabled = YES;
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"Background.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
        
        CCSprite *textEnd;
        if (end == 0) {
            textEnd = [CCSprite spriteWithFile:@"Win.png"];
        }
        else if (end == 1) {
            textEnd = [CCSprite spriteWithFile:@"GameOver.png"];
        }
        
        textEnd.position =  ccp(winSize.width/2, winSize.height/2);
        
        // add the label as a child to this Layer
        [self addChild:textEnd z:2];
        
        CCLabelTTF *atras = [CCLabelTTF labelWithString:@"Tap to continue." fontName:@"verdana" fontSize:15];
        CCMenuItemLabel *atras1 = [CCMenuItemLabel itemWithLabel:atras target:self selector:@selector(back)];
        
        CCMenu *menu2 = [CCMenu menuWithItems:atras1, nil];
        menu2.position = ccp((winSize.width/2),(winSize.height/6));
        
        [self addChild:menu2];
    }
    return self;
}

-(void)registerWithTouchDispatcher
{
    [[[CCDirector sharedDirector] touchDispatcher] addTargetedDelegate:self
                                                              priority:0
                                                       swallowsTouches:YES];
}

-(BOOL) ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
	return YES;
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    CCScene *Reiniciar = [HelloWorldLayer scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:Reiniciar ]];
}

@end
