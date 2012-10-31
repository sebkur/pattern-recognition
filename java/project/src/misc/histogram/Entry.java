package misc.histogram;

public class Entry<T> implements Comparable<Entry<T>>
{
	T element;
	int occurences;

	public Entry(T element, int occurences)
	{
		this.element = element;
		this.occurences = occurences;
	}

	@Override
	public int compareTo(Entry<T> o)
	{
		return occurences - o.occurences;
	}

	public T getElement()
	{
		return element;
	}

	public int getOccurrences()
	{
		return occurences;
	}
}
