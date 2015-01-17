
//public class JSONRandomLayoutStrategy extends AbstractStrategy<ArcBarManager>
//{
//
//  private PApplet   	_engine;
//
//  private JSONObject 	_jsonObject;
//  private String 		_jsonFileName;
//
//  
//
//  public JSONRandomLayoutStrategy(PApplet engine, String JSONFileName)
//  {
//    _engine = engine; 
//    _jsonFileName = JSONFileName;
//
//    parseJSONFile();
//
//  } 
//
//
//  public void parseJSONFile()
//  {
//  	// loads the JSON File..
//  	_jsonObject = loadJSONObject(_jsonFileName);
//  	
//
//  	// Get THE ArcBar
////  	JSONArray values = json.getJSONArray("ArcBars");
//  	
//  	// for each ArcBar found (even one..)
//  	for (int i = 0; i < values.size(); i++) 
//  	{
//    
//	  	JSONObject arcBar = values.getJSONObject(i); 
//
//    	//int id = arcBar.getInt("id");
//    	//String species = arcBar.getString("species");
//    	//String name = arcBar.getString("name");
//
//    	
//    	//println(id + ", " + species + ", " + name);
//
//    	arcBar.setRadiusSmall		( arcBar.getFloat("radiusSmall"));
//    	arcbar.setRadiusBig			( arcBar.getFloat("radiusBig"));
//    	arcbar.setElevation			( arcBar.getFloat("elevation"));
//    	arcbar.setAngleStart		( arcBar.getFloat("angleStart"));
//    	arcbar.setAngleEnd			( arcBar.getFloat("angleEnd"));
//    	arcbar.setrotateClocWise	( arcBar.getBoolean("rotateClocWise"));
//    	arcBar.setRotationSpeed		( arcBar.getBoolean("rotationSpeed"));
//    	arcbar.setColor				( arcBar.getString("color"));	
//
//
//   //  		radiusSmall 	: 50 		, 
//			// radiusBig 		: 500		, 
//			// elevation 		: 0.01		, 
//			// height 			: 0.1		, 
//			// angleStart		: 360		,
//			// angleEnd		: 250		,
//			// rotateClocWise	: true		,
//			// rotationSpeed	: 0.5 		,
//			// color			: [ 0.1, 0.1, 0.1, 1 ],
//  	}	
//  }
//
//  public void run(ArcBarManager barManager)
//  {}
//
//
//}
