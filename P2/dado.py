import sys
import sdl2
from OpenGL.GL import *
from OpenGL.GLU import *
import math
from PIL import Image

N = 50

def LoadTextures():
    global texture
    texture = glGenTextures(1)
    glBindTexture(GL_TEXTURE_2D, texture)
    im = Image.open("dado.png")
    w, h = im.size
    if(im.mode == "RGBA"):
        modo = GL_RGBA
        data = im.tobytes("raw", "RGBA", 0, -1)
    else:
        modo = GL_RGB
        data = im.tobytes("raw", "RGB", 0, -1)
    glPixelStorei(GL_UNPACK_ALIGNMENT,1)
    glTexImage2D(GL_TEXTURE_2D, 0, modo, w, h, 0, modo, GL_UNSIGNED_BYTE, data)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_S, GL_REPEAT)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_WRAP_T, GL_REPEAT)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MAG_FILTER, GL_NEAREST)
    glTexParameterf(GL_TEXTURE_2D, GL_TEXTURE_MIN_FILTER, GL_NEAREST)
    glTexEnvf(GL_TEXTURE_ENV, GL_TEXTURE_ENV_MODE, GL_DECAL)


def InitGL(Width, Height):             
    LoadTextures()
    glEnable(GL_TEXTURE_2D)
    glClearColor(0.0, 0.0, 0.0, 0.0) 
    glClearDepth(1.0)
    glDepthFunc(GL_LESS)               
    glEnable(GL_DEPTH_TEST)            
    glShadeModel(GL_SMOOTH)            
    glMatrixMode(GL_PROJECTION)
    gluPerspective(45.0, float(Width)/float(Height), 0.1, 100.0)
    glMatrixMode(GL_MODELVIEW)

a=0
b=0
r=1
def desenha():
    global a
    global b
    glClear(GL_COLOR_BUFFER_BIT | GL_DEPTH_BUFFER_BIT)    
    glLoadIdentity()       
    glTranslatef(0.0,0.0,-10.0)
    glRotatef(a,a,b,0.0)
    for i in (0,N):
      
      glBegin(GL_QUADS)              
      # Front Face 4
      glTexCoord2f(0.0, 0.0); glVertex3f(-1.0, -1.0,  1.0)    
      glTexCoord2f(0.0, 1/2); glVertex3f( 1.0, -1.0,  1.0)   
      glTexCoord2f(1/3, 1/2); glVertex3f( 1.0,  1.0,  1.0)   
      glTexCoord2f(1/3, 0.0); glVertex3f(-1.0,  1.0,  1.0)  

      # Back Face 3
      glTexCoord2f(2/3, 1/2); glVertex3f(-1.0, -1.0, -1.0)    
      glTexCoord2f(2/3, 1.0); glVertex3f(-1.0,  1.0, -1.0)    
      glTexCoord2f(1, 1.0); glVertex3f( 1.0,  1.0, -1.0)    
      glTexCoord2f(1.0, 1/2); glVertex3f( 1.0, -1.0, -1.0)   
      
      # Top Face 1
      glTexCoord2f(0.0, 1/2); glVertex3f(-1.0,  1.0, -1.0)   
      glTexCoord2f(0.0, 1.0); glVertex3f(-1.0,  1.0,  1.0)    
      glTexCoord2f(1/3, 1.0); glVertex3f( 1.0,  1.0,  1.0)    
      glTexCoord2f(1/3, 1/2); glVertex3f( 1.0,  1.0, -1.0)   

      # Bottom Face 6 
      glTexCoord2f(2/3, 0.0); glVertex3f(-1.0, -1.0, -1.0)   
      glTexCoord2f(2/3, 1/2); glVertex3f( 1.0, -1.0, -1.0)   
      glTexCoord2f(1.0, 1/2); glVertex3f( 1.0, -1.0,  1.0)   
      glTexCoord2f(1.0, 0.0); glVertex3f(-1.0, -1.0,  1.0)    
      
      # Right face 2
      glTexCoord2f(1/3, 1/2); glVertex3f( 1.0, -1.0, -1.0)    
      glTexCoord2f(1/3, 1.0); glVertex3f( 1.0,  1.0, -1.0)   
      glTexCoord2f(2/3, 1.0); glVertex3f( 1.0,  1.0,  1.0)    
      glTexCoord2f(2/3, 1/2); glVertex3f( 1.0, -1.0,  1.0)  
      
      # Left Face 5
      glTexCoord2f(1/3, 0.0); glVertex3f(-1.0, -1.0, -1.0)  
      glTexCoord2f(1/3, 1/2); glVertex3f(-1.0, -1.0,  1.0)    
      glTexCoord2f(2/3, 1/2); glVertex3f(-1.0,  1.0,  1.0)   
      glTexCoord2f(2/3, 0.0); glVertex3f(-1.0,  1.0, -1.0)   
      
      glEnd()
      a+=0.01
      b+=0.01



WINDOW_WIDTH = 800
WINDOW_HEIGHT = 600

sdl2.SDL_Init(sdl2.SDL_INIT_EVERYTHING)
sdl2.SDL_GL_SetAttribute(sdl2.SDL_GL_CONTEXT_MAJOR_VERSION, 2)
sdl2.SDL_GL_SetAttribute(sdl2.SDL_GL_CONTEXT_MINOR_VERSION, 1)
sdl2.SDL_GL_SetAttribute(sdl2.SDL_GL_CONTEXT_PROFILE_MASK,sdl2.SDL_GL_CONTEXT_PROFILE_CORE)
sdl2.SDL_GL_SetAttribute(sdl2.SDL_GL_DOUBLEBUFFER, 1)
sdl2.SDL_GL_SetAttribute(sdl2.SDL_GL_DEPTH_SIZE, 24)
sdl2.SDL_GL_SetSwapInterval(1)
window = sdl2.SDL_CreateWindow(b"Dado", sdl2.SDL_WINDOWPOS_CENTERED, sdl2.SDL_WINDOWPOS_CENTERED, WINDOW_WIDTH, WINDOW_HEIGHT, sdl2.SDL_WINDOW_OPENGL | sdl2.SDL_WINDOW_SHOWN)
if not window:
    sys.stderr.write("Error: Could not create window\n")
    exit(1)
glcontext = sdl2.SDL_GL_CreateContext(window)
InitGL(WINDOW_WIDTH,WINDOW_HEIGHT)
running = True
event = sdl2.SDL_Event()
while running:
    while sdl2.SDL_PollEvent(ctypes.byref(event)) != 0:
        if event.type == sdl2.SDL_QUIT:
            running = False
        if event.type == sdl2.events.SDL_KEYDOWN:
            if event.key.keysym.sym == sdl2.SDLK_ESCAPE:
                running = False
    desenha()
    sdl2.SDL_GL_SwapWindow(window)
