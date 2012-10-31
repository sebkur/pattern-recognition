package classificator;

import misc.lina.Vector;

public interface VectorRecord<V>
{
	public int getNumberOfDimensions();
	
	public V getValue(int k);
	
	public Vector toVector();
}
