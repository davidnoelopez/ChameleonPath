//
//  Nivel.m
//  pruebaChameleonPath
//
//  Created by Dave on 11/3/13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//
//

#import "Nivel.h"
#import "HelloWorldLayer.h"
#import "Pared.h"

@implementation Nivel

+(CCScene *) scene{
	CCScene *scene = [CCScene node];
	
	Nivel *layer = [Nivel node];
	
	[scene addChild: layer];
	
	return scene;
}

+(CCScene *) sceneWithMatrix:(int [][16])matrix{
    CCScene *scene = [CCScene node];
	
    Nivel *layer = [[Nivel alloc] initWithMatrix:matrix];
    
    //[[self alloc] initWithMatrix:matrix];
    
    [scene addChild: layer];
    
    return scene;
    
}

-(id) initWithMatrix:(int [][16])matrix
{
	if((self=[super init])) {
        self.isTouchEnabled = YES;
        
        CGSize winSize = [CCDirector sharedDirector].winSize;
        
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
        
        _tiles = [[NSMutableArray alloc] init];
        
        //crea paredes que se van a usar en el nivel
        Pared *p1 = [[Pared alloc] init];
        [p1 setParedSprite:[[NSString alloc] initWithString:@"tile.jpg"]];
        
        [p1 setTipo:1];
        [_tiles addObject:p1];
        
        
        for (int x = 0; x < 24; x++) {
            for (int y = 0; y < 16; y++) {
                int selectedTile = 0;
                Pared *auxPared = [_tiles objectAtIndex:selectedTile];
                
                CCSprite *tile = [[CCSprite alloc] initWithFile:[auxPared paredSprite]];
                //tile.tag = [auxPared tag];
                if (matrix[x][y] == 1) {
                    tile.position = ccp(x*20+tile.contentSize.width/2,y*20+tile.contentSize.height/2);
                    //tile.position = ccp(0,0);
                    [self addChild:tile z:1];
                }
                else
                    matrix[x][y] = 0;
            }
        }
        
	}
	return self;
}

-(id) init
{
    if((self=[super init])) {
        CGSize winSize = [CCDirector sharedDirector].winSize;
        CCSprite *background = [CCSprite spriteWithFile:@"BlurryBackground.png"];
        background.position = ccp(winSize.width/2, winSize.height/2);
        [self addChild:background z:-2];
		
        CCSprite *opciones = [CCSprite spriteWithFile:@"OptionsButton.png"];
        opciones.position =  ccp(winSize.width/2 , 270 );
        [self addChild: opciones];
	}
	return self;

}


@end