package classificator;

public class WeightedRecord<T> implements Comparable<WeightedRecord<T>>
{
	private final T record;
	private final double weight;

	public WeightedRecord(T record, double weight)
	{
		this.record = record;
		this.weight = weight;
	}

	public T getRecord()
	{
		return record;
	}

	public double getWeight()
	{
		return weight;
	}

	@Override
	public int compareTo(WeightedRecord<T> other)
	{
		if (weight < other.weight) {
			return -1;
		} else if (weight > other.weight) {
			return 1;
		} else {
			return 0;
		}
	}
}
