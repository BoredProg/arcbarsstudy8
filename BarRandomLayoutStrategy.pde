public class BarRandomLayoutStrategy extends AbstractStrategy<ArcBarManager>
{

  private PApplet   _engine;


  public BarRandomLayoutStrategy(PApplet engine)
  {
    _engine = engine; 
  } 



  public void run (ArcBarManager barManager)
  {
    int arcsTotal      = 14;
    float arcLocZ      = 0; //-400 //--> position of the arc in the z axis 
    
    float arcLocZInc   = 0.01f;//-5;   // Sets the elevation between bars. 0 means z-fighting !
  
    float arcHeight    = 5; // 0.1f;
  
    float arcAngleMin  = 10;
    float arcAngleMax  = 200;

    float arcRadiusMin = 50;
    float arcRadiusMax = 500;
    
    float arcWidthMin  = 5;
    float arcWidthMax  = 200;
    
    ArcBar arcBar = null;
    int i;
    
    // Creates the ArcBar Array..
    //arcBars = new ArcBar[ arcsTotal ];

    barManager.getArcs().clear();

    // For each ArcBar, init values..
    for( i = 0; i< arcsTotal; i++ )
    {
      arcBar = new ArcBar(_engine, barManager);
      
      //arcBar.loc.z += arcLocInc;
      arcLocZ += arcLocZInc;    
      arcBar.setElevation(arcLocZ);       
      arcBar.setElevation(arcBar.getElevation() + arcLocZInc);

      // Set arc height
      arcBar.setHeight(arcHeight );    // try (arcHeight * i * i)  :)

      // set radius small
      arcBar.setRadiusSmall(random( arcRadiusMin, arcRadiusMax ));
      
      // set radius big
      arcBar.setRadiusBig(random( arcWidthMin, arcWidthMax ));
      
      // set start angle (in degrees)
      arcBar.setAngleStart(random(360));

      // set angle length (in degrees)
      arcBar.setAngleEnd(random( arcAngleMin, arcAngleMax ));
      
      // Rotation direction    
      if ( random(1f) > 0.5f)
      {
        arcBar.setRotateClockWise(true);
      }
      else
      {
        arcBar.setRotateClockWise(false);  
      }

      // rotation speed..
      arcBar.setRotationSpeed(random(0.0f,0.5f));

      // color.
      arcBar.colour[ 0 ] = random(0,1f);
      arcBar.colour[ 1 ] = random(0,1f);
      arcBar.colour[ 2 ] = random(0,1f);
      arcBar.colour[ 3 ] = 1.0f;//random(1.0f);
    
      // Adds to the widget arcs collection..
      barManager.getArcs().add(arcBar);  
     
    }

  }
}