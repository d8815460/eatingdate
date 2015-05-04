//
//  UISwipe4ScrollGestureRecognizer.h
//
//  Created by Jose Luis Campaña Perez on 04/08/11.
//  jose@iz3solutions.com
//  Copyright 2011 iZ3. All rights reserved.
//

#import "UISwipe4ScrollGestureRecognizer.h"

#define SuppressPerformSelectorLeakWarning(Stuff) \
do { \
_Pragma("clang diagnostic push") \
_Pragma("clang diagnostic ignored \"-Warc-performSelector-leaks\"") \
Stuff; \
_Pragma("clang diagnostic pop") \
} while (0)

@implementation UISwipe4ScrollGestureRecognizer
@synthesize direction = _direccion;
@synthesize swipeVelocityInView = _touchSpeed;


-(void)dealloc
{
//    [m_delegate release];
//    [super dealloc];
}




- (id<UIGestureRecognizerDelegate>)delegate
{
    return m_delegate;
}

- (void) setDelegate:(id<UIGestureRecognizerDelegate>)delegate
{
//    [m_delegate release];
    m_delegate = delegate;
//    [m_delegate retain];
}

- (id)target
{
    return m_target;
}

- (void)setTarget:(id)target
{
//    [m_target release];
    m_target = target;
//    [m_target retain];
}

- (SEL)callback
{
    return m_callback;
}

- (void)setCallback:(SEL)callback
{
    m_callback = callback;
}

- (id)initWithTarget:(id)target action:(SEL)action
{
    
    self = [super initWithTarget:self action:@selector(callback:)];
    if (self)
    {
        m_delegate = super.delegate;
        [super setDelegate:self];
        [self setTarget:target];
        [self setCallback:action];
        _direccionDelegate = NO_DIR;
        _panning = NO;        
        _touchSpeed = SWIPE_THRESHOLD;
    }
    return self;
}


- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    if( !m_delegate )
        return YES;
    
    if ([m_delegate respondsToSelector:@selector(gestureRecognizer: shouldRecognizeSimultaneouslyWithGestureRecognizer:)]) 
        return [m_delegate gestureRecognizer:gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:otherGestureRecognizer];
    else return YES;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    if( !m_delegate )
        return YES;
    
    if ([m_delegate respondsToSelector:@selector(gestureRecognizerShouldBegin:)])
        return [m_delegate gestureRecognizerShouldBegin:gestureRecognizer];
    else return YES;
}


- (void)callback:(UISwipe4ScrollGestureRecognizer*)recognizer
{
    if(recognizer.state == UIGestureRecognizerStateBegan)
    {
        _panning = NO;
    }
    CGPoint v =[recognizer velocityInView:recognizer.view];
    if (recognizer.direction == UISwipeGestureRecognizerDirectionLeft || recognizer.direction == UISwipeGestureRecognizerDirectionRight) {
        
        if( (abs(v.x) >= _touchSpeed) && !_panning)
        {
            _panning = YES;
            
            [recognizer cancelsTouchesInView];
            
            if(v.x>0) _direccion = UISwipeGestureRecognizerDirectionRight;
            else _direccion = UISwipeGestureRecognizerDirectionLeft;
            
            if (_direccionDelegate == _direccion)
            {
                if( m_target ){
                    SuppressPerformSelectorLeakWarning(
                                                       [m_target performSelector:m_callback withObject:recognizer]
                                                       );
                    
                }
            }
        }
        
    } else {
        if( (abs(v.y) >= _touchSpeed) && !_panning)
        {
            _panning = YES;
            
            [recognizer cancelsTouchesInView];
            
            if(v.y>0) _direccion = UISwipeGestureRecognizerDirectionDown;
            else _direccion = UISwipeGestureRecognizerDirectionUp;
            
            if (_direccionDelegate == _direccion)
            {
                if( m_target ){
                    SuppressPerformSelectorLeakWarning(
                                                       [m_target performSelector:m_callback withObject:recognizer]
                                                       );
                }
            }
        }
        
    }
    
    
}

-(void)setDirection:(UISwipeGestureRecognizerDirection)direction
{
    _direccionDelegate = direction;
}

@end
