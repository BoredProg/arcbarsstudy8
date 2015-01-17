public class LookupTableProvider
{

	private PApplet _engine;
	private float 	sinLUT[];
	private float 	cosLUT[];

	// the smaller the better (but eats framerate damn quick !) Range 0.0f --> infinity. 
	private float 	SINCOS_PRECISION	= 1.0f;
	private int 	SINCOS_LENGTH       = (int)(360.0f / SINCOS_PRECISION);


	public LookupTableProvider(PApplet engine)
	{
		this(engine, 1.0f);
	}	


	public LookupTableProvider(PApplet engine, float trigTablesPrecision)
	{
		_engine = engine;

		SINCOS_PRECISION 	= trigTablesPrecision;
		SINCOS_LENGTH       = (int)(360.0f / SINCOS_PRECISION);

		 initLookUpTables();
	}



	private final void initLookUpTables ()
	{
	  sinLUT = new float[SINCOS_LENGTH];
	  cosLUT = new float[SINCOS_LENGTH];
	  
	  for (int i = 0; i < SINCOS_LENGTH; i++)
	  {
	    sinLUT[i]= (float)Math.sin( i * DEG_TO_RAD * SINCOS_PRECISION );
	    cosLUT[i]= (float)Math.cos( i * DEG_TO_RAD * SINCOS_PRECISION );
	  }
	}

	public float getSinTable(int val)
	{
		return sinLUT[val];
	}

	public float getCosTable(int val)
	{
		return cosLUT[val];
	}

	public float getTrigTablePrecision()
	{
		return SINCOS_PRECISION;
	}

	public int getTrigTableLength()
	{
		return (int)(360.0f / SINCOS_PRECISION);
	}


}	// End LookupTableProvider Class

