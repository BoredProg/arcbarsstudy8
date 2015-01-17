/*******************************************************************************************
*
* ARC BAR CLASS.
*
*******************************************************************************************/

/**
* ArcBar
*/
public class ArcBar
{
    
  // property holder variables.
  float   _angleStart         = 0;
  float   _angleEnd           = 20;
 
  float   _radiusSmall        = 300;
  float   _radiusBig          = 50;
 
  float   _height             = 50;
  float   _elevation          = 15;

  boolean _rotateClockwise;
  float   _rotationSpeed      = 1;

  // internal variables.
  Boolean drawQuads           = true;
  Boolean drawNormals         = false;
  float normLength            = 200;


  float[] colour = { 1, 1, 1, 1f   };   // transparency works !

  PApplet _engine;
  ArcBarManager _manager;



  public ArcBar (PApplet engine, ArcBarManager manager)
  {
    _engine   = engine;
    _manager  = manager;
  }


  public void update ()
  {
     _angleStart += _rotationSpeed;
  }

  


  /////////////////////////////////////////////////////////////////////////////////////////////////


  public void render ()
  {
    float x1, y1, x2, y2;
    float px1, py1, px2, py2;
    Vec3D vtemp, ntemp, n1, n2;
    Vec3D[] vtemps;
    int ang;
    int i, j;

    // init values..
    x1  = y1  = x2  = y2  = 0;
    px1 = py1 = px2 = py2 = 0;
    n1  = n2  = new Vec3D();
    
    // Calculate each step's angle..
    ang = (int)min( _angleEnd / _manager.getTrigLUT().getTrigTablePrecision() , _manager.getTrigLUT().getTrigTableLength() - 1 );

    gl.glPushMatrix();
    
    // Set elevation.
    gl.glTranslatef( 0, 0 , _elevation);
    
    //--> Handles rotation around center.
    int rotationDirection = (_rotateClockwise ? 1 : - 1);
    gl.glRotatef( _angleStart * rotationDirection, 0, 0, 1 );  
    
    
    for( i = 0; i < ang; i++ ) 
    {
      x1 = _manager.getTrigLUT().getCosTable(i) * ( _radiusSmall );
      y1 = _manager.getTrigLUT().getSinTable(i) * ( _radiusSmall );
      x2 = _manager.getTrigLUT().getCosTable(i) * ( _radiusBig + _radiusSmall );
      y2 = _manager.getTrigLUT().getSinTable(i) * ( _radiusBig + _radiusSmall );

     // normal pointing inwards.
      n1 = new Vec3D( 1, 0, 0 );
      n1 = n1.rotateAroundAxis( Vec3D.Z_AXIS, i * DEG_TO_RAD );

      if( drawQuads )
      {
        gl.glBegin( GL2.GL_QUADS );

        // set color.
        gl.glMaterialfv( GL2.GL_FRONT, GL2.GL_AMBIENT_AND_DIFFUSE, colour, 0 );

        if( ( i == 0 ) || ( i == ( ang - 1 ) ) )
        {
          //--> draw end faces.
          ntemp = new Vec3D( 0, -1, 0 );
          ntemp = ntemp.rotateAroundAxis( Vec3D.Z_AXIS.copy(), i * DEG_TO_RAD );
          if( i == ( ang - 1 ) )
          {
            ntemp.invert();
          }

          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( x1, y1, 0 );
          gl.glVertex3f( x2, y2, 0 );
          gl.glVertex3f( x2, y2, _height );
          gl.glVertex3f( x1, y1, _height );
        }

        if( i != 0 )
        {
          //--> draw inner faces.
          ntemp = n1.copy().invert();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( x1, y1, 0 );

          ntemp = n2.copy().invert();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( px1, py1, 0 );
          gl.glVertex3f( px1, py1, _height );

          ntemp = n1.copy().invert();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( x1, y1, _height );

          //--> draw outer faces.
          ntemp = n1.copy();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( x2, y2, 0 );

          ntemp = n2.copy();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( px2, py2, 0 );
          gl.glVertex3f( px2, py2, _height );

          ntemp = n1.copy();
          gl.glNormal3f( ntemp.x, ntemp.y, ntemp.z );
          gl.glVertex3f( x2, y2, _height );


          ///////////////////////////////////////////////////////////////////////////////////////
          //-->draw bottom faces.
          gl.glNormal3f( 0, 0, -1 );
          gl.glVertex3f( x1, y1, 0 );
          gl.glVertex3f( px1, py1, 0 );
          gl.glVertex3f( px2, py2, 0 );
          gl.glVertex3f( x2, y2, 0 );

          //--> draw top faces.
          gl.glNormal3f( 0, 0, 1 );
          gl.glVertex3f( x1, y1, _height );
          gl.glVertex3f( px1, py1, _height );
          gl.glVertex3f( px2, py2, _height );
          gl.glVertex3f( x2, y2, _height );
        }

        gl.glEnd();
      }


      // Normals drawing... not used for the moment..
      if( drawNormals )
      {
        gl.glBegin( GL2.GL_LINES );

        if( ( i == 0 ) || ( i == ( ang - 1 ) ) )
        {
          ntemp = new Vec3D( 0, -1, 0 );
          ntemp = ntemp.rotateAroundAxis( Vec3D.Z_AXIS.copy(), i * DEG_TO_RAD );
          if( i == ( ang - 1 ) )
          {
            ntemp.invert();
          }
          vtemps    = new Vec3D[ 4 ];
          vtemps[ 0 ]  = new Vec3D( x1, y1, 0 );
          vtemps[ 1 ]  = new Vec3D( x2, y2, 0 );
          vtemps[ 2 ]  = new Vec3D( x2, y2, _height );
          vtemps[ 3 ]  = new Vec3D( x1, y1, _height );

          for( j=0; j<vtemps.length; j++ )
          {
            vtemp = vtemps[ j ];

            gl.glVertex3f( vtemp.x, vtemp.y, vtemp.z );
            gl.glVertex3f
              (
            vtemp.x + ntemp.x * normLength,
            vtemp.y + ntemp.y * normLength, 
            vtemp.z + ntemp.z * normLength
              );
          }
        }

        if( ( i != 0 ) && ( i % 20 == 0 ) )
        {
          // draw inner face normals.
          ntemp    = n1.copy().invert();
          vtemps    = new Vec3D[ 4 ];
          vtemps[ 0 ]  = new Vec3D( x1, y1, 0 );
          vtemps[ 1 ]  = new Vec3D( px1, py1, 0 );
          vtemps[ 2 ]  = new Vec3D( px1, py1, _height );
          vtemps[ 3 ]  = new Vec3D( x1, y1, _height );

          for( j=0; j<vtemps.length; j++ )
          {
            vtemp = vtemps[ j ];

            gl.glVertex3f( vtemp.x, vtemp.y, vtemp.z );
            gl.glVertex3f
              (
            vtemp.x + ntemp.x * normLength,
            vtemp.y + ntemp.y * normLength, 
            vtemp.z + ntemp.z * normLength
              );
          }

          // draw outer face normals.
          ntemp    = n1.copy();
          vtemps    = new Vec3D[ 4 ];
          vtemps[ 0 ]  = new Vec3D( x2, y2, 0 );
          vtemps[ 1 ]  = new Vec3D( px2, py2, 0 );
          vtemps[ 2 ]  = new Vec3D( px2, py2, _height );
          vtemps[ 3 ]  = new Vec3D( x2, y2, _height );

          for( j=0; j<vtemps.length; j++ )
          {
            vtemp = vtemps[ j ];

            gl.glVertex3f( vtemp.x, vtemp.y, vtemp.z );
            gl.glVertex3f(vtemp.x + ntemp.x * normLength,
                          vtemp.y + ntemp.y * normLength, 
                          vtemp.z + ntemp.z * normLength);
          }

          // draw bottom face normals.
          ntemp    = new Vec3D( 0, 0, -1 );
          vtemps    = new Vec3D[ 4 ];
          vtemps[ 0 ]  = new Vec3D( x1, y1, 0 );
          vtemps[ 1 ]  = new Vec3D( px1, py1, 0 );
          vtemps[ 2 ]  = new Vec3D( px2, py2, 0 );
          vtemps[ 3 ]  = new Vec3D( x2, y2, 0 );

          for( j=0; j<vtemps.length; j++ )
          {
            vtemp = vtemps[ j ];

            gl.glVertex3f( vtemp.x, vtemp.y, vtemp.z );
            gl.glVertex3f
              (
            vtemp.x + ntemp.x * normLength,
            vtemp.y + ntemp.y * normLength, 
            vtemp.z + ntemp.z * normLength
              );
          }

          // draw top face normals.
          ntemp    = new Vec3D( 0, 0, 1 );
          vtemps    = new Vec3D[ 4 ];
          vtemps[ 0 ]  = new Vec3D( x1, y1, _height );
          vtemps[ 1 ]  = new Vec3D( px1, py1, _height );
          vtemps[ 2 ]  = new Vec3D( px2, py2, _height );
          vtemps[ 3 ]  = new Vec3D( x2, y2, _height );

          for( j=0; j<vtemps.length; j++ )
          {
            vtemp = vtemps[ j ];

            gl.glVertex3f( vtemp.x, vtemp.y, vtemp.z );
            gl.glVertex3f
              (
            vtemp.x + ntemp.x * normLength,
            vtemp.y + ntemp.y * normLength, 
            vtemp.z + ntemp.z * normLength
              );
          }
        }

        gl.glEnd();
      }

      px1 = x1;
      py1 = y1;
      px2 = x2;
      py2 = y2;
      n2  = n1;
    }

    gl.glPopMatrix();
  }




  /////////////////////////////////////////////////////////////////////////////////////////////////
  // SEB TEMP 

 

  /*****************************************
  * RadiusSmall  
  ******************************************/

  public void setRadiusSmall(float val)
  {
    _radiusSmall = val;
  }

  public float getRadiusSmall()
  {
    return _radiusSmall;
  }


  /*****************************************
  * RadiusMax  
  ******************************************/

  public void setRadiusBig(float val)
  {
    _radiusBig = val;    
  }

  public float getRadiusBig()
  {
    return _radiusBig;
  }


  /*****************************************
  * AngleStart  
  ******************************************/

  public void setAngleStart(float val)
  {
    _angleStart = val;
  }

  public float getAngleStart()
  {
    return _angleStart;
  }


  /*****************************************
  * AngleEnd  
  ******************************************/

  public void setAngleEnd(float val)
  {
    _angleEnd = val;    
  }

  public float getAngleEnd()
  {
    return _angleEnd;
  }


  /*****************************************
  * Height  
  ******************************************/
  public void setHeight(float val)
  {
    _height = val;
  }

  public float getHeight()
  {
    return _height;
  }


/*****************************************
  * Rotation Speed  
  ******************************************/
  public void setRotationSpeed(float val)
  {
    _rotationSpeed = val;
  }

  public float getRotationSpeed()
  {
    return _rotationSpeed;
  }
  

  /***************************************************
  * Elevation
  ****************************************************/
  public void setElevation(float val)
  {
    _elevation = val;
  }

  public float getElevation()
  {
    return _elevation;
  }



  
  /***************************************************
  * rotateClockWise
  ****************************************************/
  public void setRotateClockWise(boolean val)
  {
    _rotateClockwise = val;
  }

  public boolean getRotateClockWise()
  {
    return _rotateClockwise;
  }




}     // End ArcBar class  
