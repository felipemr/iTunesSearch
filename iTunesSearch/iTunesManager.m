                //
//  iTunesManager.m
//  iTunesSearch
//
//  Created by joaquim on 09/03/15.
//  Copyright (c) 2015 joaquim. All rights reserved.
//

#import "iTunesManager.h"
#import "Entidades/Midia.h"

@implementation iTunesManager

static iTunesManager *SINGLETON = nil;

static bool isFirstAccess = YES;

#pragma mark - Public Method

+ (id)sharedInstance
{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        isFirstAccess = NO;
        SINGLETON = [[super allocWithZone:NULL] init];    
    });
    
    return SINGLETON;
}


- (NSMutableArray *)buscarMidias:(NSString *)termo {
    if (!termo) {
        termo = @"";
    }
    
    
    NSString *urlString = [NSString stringWithFormat:@"https://itunes.apple.com/search?term=%@&media=all&limit=200", termo];
    NSURL *url=[[NSURL alloc] initWithString:[urlString stringByAddingPercentEscapesUsingEncoding: NSUTF8StringEncoding]];
    
    NSData *jsonData = [NSData dataWithContentsOfURL: url];
    
    NSError *error;
    NSDictionary *resultado = [NSJSONSerialization JSONObjectWithData:jsonData
                                                              options:NSJSONReadingMutableContainers
                                                                error:&error];
    if (error) {
        NSLog(@"Não foi possível fazer a busca. ERRO: %@", error);
        return nil;
    }
    
    
    NSArray *resultados = [resultado objectForKey:@"results"];
    
    NSMutableArray *midia,*book, *album, *featureMovie,*podcast, *song;
    
    
    
    midia= [[NSMutableArray alloc] init];
    book= [[NSMutableArray alloc] init];
    album= [[NSMutableArray alloc] init];
    featureMovie= [[NSMutableArray alloc] init];
    podcast= [[NSMutableArray alloc] init];
    song= [[NSMutableArray alloc] init];
    
    
    for (NSDictionary *item in resultados) {
        Midia *media=[[Midia alloc]init];
        [media setNome:[item objectForKey:@"trackName"]];
        [media setTrackId:[item objectForKey:@"trackId"]];
        [media setArtista:[item objectForKey:@"artistName"]];
        [media setGenero:[item objectForKey:@"primaryGenreName"]];
        [media setPais:[item objectForKey:@"country"]];
        [media setPreco:[item objectForKey:@"trackPrice"]];
        [media setImgUrl:[item objectForKey:@"artworkUrl100"]];
        
        if ([[item objectForKey:@"kind"]  isEqual: @"song"]) {
            [media setTipo:@"musica"];
            [song addObject:media];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"book"]) {
            [media setTipo:@"book"];
            [book addObject:media];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"feature-movie"]) {
            [media setTipo:@"filme"];
            //[(Filme *)filme setDuracao:[item objectForKey:@"trackTimeMillis"]];
            [featureMovie addObject:media];
        }
        if ([[item objectForKey:@"kind"]  isEqual: @"podcast"]) {
            [media setTipo:@"podcast"];
            [podcast addObject:media];
        }
        
    }
    
    if ([book count]!= 0) {
        [midia addObject:book];
    }
    if ([featureMovie count]!= 0) {
        [midia addObject:featureMovie];
    }
    if ([song count]!= 0) {
        [midia addObject:song];
    }
    if ([podcast count]!= 0) {
        [midia addObject:podcast];
    }
    NSLog(@"passou por aqui");
    return midia;
}




#pragma mark - Life Cycle

+ (id) allocWithZone:(NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)copyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

+ (id)mutableCopyWithZone:(struct _NSZone *)zone
{
    return [self sharedInstance];
}

- (id)copy
{
    return [[iTunesManager alloc] init];
}

- (id)mutableCopy
{
    return [[iTunesManager alloc] init];
}

- (id) init
{
    if(SINGLETON){
        return SINGLETON;
    }
    if (isFirstAccess) {
        [self doesNotRecognizeSelector:_cmd];
    }
    self = [super init];
    return self;
}


@end
