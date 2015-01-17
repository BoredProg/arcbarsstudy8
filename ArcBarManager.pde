import java.util.*;
  //
public class ArcBarManager
{
	PApplet							_engine;
	private ArrayList<ArcBar>		_arcs;
	private LookupTableProvider		_lookupTableProvider;

	
	public ArcBarManager(PApplet engine)
	{
		this(engine, 1.0f);
	}

	public ArcBarManager(PApplet engine, float trigTablePrecision)
	{
		_engine = engine;
		
		_arcs = new ArrayList<ArcBar>();

		_lookupTableProvider = new LookupTableProvider( _engine, trigTablePrecision );
	}


	public ArrayList<ArcBar> getArcs()
	{
		return _arcs;
	}

	public LookupTableProvider getTrigLUT()
	{
		return _lookupTableProvider;
	}

	public void run(AbstractStrategy<ArcBarManager> strategy)
	{
		strategy.run(this);
	}

	public void update()
	{
		for(ArcBar arcBar : _arcs)
		{
			arcBar.update();
		}
	}

	public void render()
	{
		for(ArcBar arcBar : _arcs)
		{
			arcBar.update();
			arcBar.render();
		}
	}




}
