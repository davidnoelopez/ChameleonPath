//
//  Puntuacion.m
//  pruebaChameleonPath
//
//  Created by Diego de los Reyes on 13/10/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//


#import "Puntuacion.h"
#import "HelloWorldLayer.h"


@implementation Puntuacion


+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	
	Puntuacion *layer = [Puntuacion node];
	
	[scene addChild: layer];
	
	return scene;
}

-(id) init
{
	if( (self=[super init]) ) {
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
		
		
        CCSprite *highscores = [CCSprite spriteWithFile:@"HighscoresButton.png"];
        highscores.position =  ccp(winSize.width/2 , 270 );
        
        // add the label as a child to this Layer
        [self addChild: highscores];
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
        NSString *documentsDirectory = [paths objectAtIndex:0];
        NSString *filePath = [documentsDirectory stringByAppendingPathComponent: @"highscores.plist"];
        CCLabelTTF *puntos;
        if([[NSFileManager defaultManager] fileExistsAtPath:filePath]){
            NSMutableArray *arreglo = [[NSMutableArray alloc] initWithContentsOfFile: filePath];
            for(int i = 0; i < 10; i++){
                NSString *numEnString= [NSString stringWithFormat:@"%i", [arreglo[i] integerValue]];
                NSLog(@"%@", numEnString);
                puntos = [CCLabelTTF labelWithString:numEnString fontName:@"verdana" fontSize:18];
                puntos.position = ccp(winSize.width/2 , 230-(i*17) );
                [self addChild:puntos];
            }
            
        }
        

        CCLabelTTF *atras = [CCLabelTTF labelWithString:@"Back" fontName:@"verdana" fontSize:25];
        CCMenuItemLabel *atras1 = [CCMenuItemLabel itemWithLabel:atras target:self selector:@selector(back)];
        
        CCMenu *menu = [CCMenu menuWithItems:atras1, nil];
        menu.position = ccp(30, winSize.height-20);
        [menu alignItemsVerticallyWithPadding:1];
        
        //Add the menu as a child to this layer
        [self addChild:menu];
        
	}
	return self;
}

- (void)back {
	CCScene *MainMenuScene = [HelloWorldLayer scene];
    
	[[CCDirector sharedDirector] replaceScene:[CCTransitionFade transitionWithDuration:0.5f scene:MainMenuScene]];
}


@end
