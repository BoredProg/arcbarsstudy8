import processing.opengl.*;
import processing.core.*;

import toxi.geom.Vec3D;

import javax.media.opengl.GL;  


import javax.media.opengl.*;
import javax.media.opengl.glu.GLU;
import com.jogamp.opengl.util.gl2.GLUT;

import java.nio.ByteBuffer;
import java.nio.ByteOrder;
import java.nio.FloatBuffer;

//import org.json.*;  //--> more than one library is competing for this sketch (Temboo & Unfolding).

 
PJOGL pgl;
GL2 gl;


ArrayList<ArcBarManager> widgets;

ArcBarManager widget1;
ArcBarManager widget2;
ArcBarManager widget3;

BarRandomLayoutStrategy strategy1;



/*****************************************************************************
* Setup
******************************************************************************/

void setup() 
{
  size( 1600, 720, P3D );
  smooth();
  colorMode( RGB, 1.0f );
  
  widgets = new ArrayList<ArcBarManager>();

  widget1 = new ArcBarManager(this);
  widget2 = new ArcBarManager(this);
  widget3 = new ArcBarManager(this);

  widgets.add(widget1);
  widgets.add(widget2);
  widgets.add(widget3);

  BarRandomLayoutStrategy strategy1 = new BarRandomLayoutStrategy(this);
  
  for (ArcBarManager widget : widgets)
  {
    widget.run(strategy1);
  }
  
  initOpenGL();
  initLights();
}



/*****************************************************************************
* Draw
******************************************************************************/
void draw() 
{
  frame.setTitle(this.getClass().getName() + ", Frame Rate : " + (int)frameRate);
 
  background( 0.4f ); // greyish.
  
  gl.glPushMatrix();
  
  gl.glTranslatef(width/2, height/2 , -( height / 2.0f ) / PApplet.tan( PApplet.PI * 60 /360.0f ));
  //gl.glTranslatef(width/2, height/2 , 0); //---> different lighting effect.

  float xMouseX = mouseX /1000f;
  gl.glScalef(xMouseX, xMouseX, xMouseX);
  
  gl.glRotatef( -45 +  mouseY /2f , 1, 0, 0 ); 
  
  widget2.render();

  gl.glTranslatef(-1600, 0 , 0);
  widget1.render();
  
  gl.glTranslatef(3200, 0 , 0);
  widget3.render();

  gl.glPopMatrix();

  endPGL();
 
}



/*****************************************************************************
* initOpenGL
******************************************************************************/
void initOpenGL ()
{
  pgl = (PJOGL)beginPGL();
  gl = GLU.getCurrentGL().getGL2();
  
  gl.setSwapInterval( 1 );

  // Enable Smooth Shading
  gl.glShadeModel( GL2.GL_SMOOTH );   
  
  // Black Background                    
  gl.glClearColor( 0.0f, 0.0f, 0.0f, 0.5f );  
  
  // Depth Buffer Setup          
  gl.glClearDepth( 1.0f );                    
  // Enables Depth Testing
  gl.glEnable( GL2.GL_DEPTH_TEST );               
  // The Type Of Depth Testing To Do
  gl.glDepthFunc( GL2.GL_LEQUAL );                  

  // Really Nice Perspective Calculations
  gl.glHint( GL2.GL_PERSPECTIVE_CORRECTION_HINT, GL2.GL_NICEST ); 

  // Enables texturing
  gl.glDisable( GL2.GL_TEXTURE_2D );

  // Set up lighting
  Boolean lightingEnabled  = true;
  float[] lightAmbient  = {   0.1f, 0.1f, 0.1f,   1.0f };  
  float[] lightDiffuse  = {   0.7f, 0.7f, 0.7f,   1.0f };
  float[] lightSpecular  = {  0.5f, 0.5f, 0.5f,   1.0f };
  float[] lightPosition  = {  -1.5f, 1.0f, -4.0f, 1.0f };
 

  gl.glLightfv( GL2.GL_LIGHT1, GL2.GL_AMBIENT, lightAmbient, 0 );
  gl.glLightfv( GL2.GL_LIGHT1, GL2.GL_DIFFUSE, lightDiffuse, 0 );
  gl.glLightfv( GL2.GL_LIGHT1, GL2.GL_SPECULAR, lightSpecular, 0 );
  gl.glLightfv( GL2.GL_LIGHT1, GL2.GL_POSITION, lightPosition, 0 );
  gl.glEnable( GL2.GL_LIGHTING );
  //gl.glEnable( GL2.GL_LIGHT0 );
  gl.glEnable( GL2.GL_LIGHT1 );

  endPGL();
}



/*****************************************************************************
* Keyboard & Mouse handlers
******************************************************************************/
void mousePressed()
{
   for (ArcBarManager widget : widgets)
  {
     widget.run(new BarRandomLayoutStrategy(this));
        
  }
}

void keyPressed()
{

   for (ArcBarManager widget : widgets)
  {
    widget.run(new BarRandomLayoutStrategy(this));
  }
}


public void initLights()
{  
  float[] lightAmbient   = { 
    0.1f, 0.1f, 0.1f, 1.0f
  };
  float[] lightDiffuse   = { 
    0.7f, 0.7f, 0.7f, 1.0f
  };
  float[] lightSpecular  = { 
    0.5f, 0.5f, 0.5f, 1.0f
  };
  float[] lightPosition  = {
    -1.5f, 1.0f, -4.0f, 1.0f
  };


  // Light model parameters:
  float lightModelAmbient[] = { 
    0.0f, 0.0f, 0.0f, 0.0f
  };
  gl.glLightModelfv(GL2.GL_LIGHT_MODEL_AMBIENT, FloatBuffer.wrap(lightModelAmbient));

  gl.glLightModelf(GL2.GL_LIGHT_MODEL_LOCAL_VIEWER, 1.0f);
  gl.glLightModelf(GL2.GL_LIGHT_MODEL_TWO_SIDE, 0.0f);

  // SETUP LIGHT 1 (Directional ? Light )
  // Common properties : ambient, diffuse, specular, position (which is direction in this case I think).
  gl.glLightfv(GL2.GL_LIGHT1, GL2.GL_AMBIENT, lightAmbient, 0);
  gl.glLightfv(GL2.GL_LIGHT1, GL2.GL_DIFFUSE, lightDiffuse, 0);
  gl.glLightfv(GL2.GL_LIGHT1, GL2.GL_SPECULAR, lightSpecular, 0);
  gl.glLightfv(GL2.GL_LIGHT1, GL2.GL_POSITION, lightPosition, 0);
  gl.glEnable(GL2.GL_LIGHTING);
  gl.glEnable(GL2.GL_LIGHT1);

  // Don't know what it does..
  gl.glEnable(GL2.GL_NORMALIZE);

  // SETUP LIGHT 0 ( Spot Light )

  // Spotlight Parameters..
  float spotDirection[]   = {
    1.0f, -1.0f, -1.0f
  };
  int spotExponent        = 30;
  int spotCutoff          = 180;

  gl.glLightfv(GL2.GL_LIGHT0, GL2.GL_SPOT_DIRECTION, FloatBuffer.wrap(spotDirection));  // Direction
  gl.glLighti(GL2.GL_LIGHT0, GL2.GL_SPOT_EXPONENT, spotExponent);                     // Exponent
  gl.glLighti(GL2.GL_LIGHT0, GL2.GL_SPOT_CUTOFF, spotCutoff);                       // CutOff

    float contantAttenuation   = 1.0f;
  float linarAttenuation     = 0.0f;
  float quadraticAttenuation = 0.0f;

  gl.glLightf(GL2.GL_LIGHT0, GL2.GL_CONSTANT_ATTENUATION, contantAttenuation);              // ContantAttenuation
  gl.glLightf(GL2.GL_LIGHT0, GL2.GL_LINEAR_ATTENUATION, linarAttenuation);                  // LinarAttenuation
  gl.glLightf(GL2.GL_LIGHT0, GL2.GL_QUADRATIC_ATTENUATION, quadraticAttenuation);           // QuadraticAttenuation

    // Common properties (ambient, diffuse, specular, position)..
  gl.glLightfv(GL2.GL_LIGHT0, GL2.GL_POSITION, FloatBuffer.wrap(lightPosition));
  gl.glLightfv(GL2.GL_LIGHT0, GL2.GL_AMBIENT, FloatBuffer.wrap(lightAmbient));
  gl.glLightfv(GL2.GL_LIGHT0, GL2.GL_DIFFUSE, FloatBuffer.wrap(lightDiffuse));
  gl.glLightfv(GL2.GL_LIGHT0, GL2.GL_SPECULAR, FloatBuffer.wrap(lightSpecular));


  // ENABLE LIGHT0 AND LIGHT 1
  gl.glEnable(GL2.GL_LIGHTING);

  gl.glEnable(GL2.GL_LIGHT0);
  gl.glEnable(GL2.GL_LIGHT1);
}





