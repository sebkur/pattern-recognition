package misc.lina;


public class Vector extends Matrix
{
	private final VectorType type;

	public Vector(int size, VectorType type)
	{
		super(type == VectorType.Row ? 1 : size,
				type == VectorType.Column ? 1 : size);
		this.type = type;
	}

	public void setValue(int p, double v)
	{
		if (type == VectorType.Column) {
			setValue(0, p, v);
		} else {
			setValue(p, 0, v);
		}
	}

	public double getValue(int p)
	{
		if (type == VectorType.Column) {
			return getValue(0, p);
		} else {
			return getValue(p, 0);
		}
	}

	public int getSize()
	{
		if (type == VectorType.Column) {
			return getHeight();
		} else {
			return getWidth();
		}
	}

	public String toString()
	{
		StringBuilder strb = new StringBuilder();
		for (int i = 0; i < getSize(); i++) {
			strb.append(getValue(i));
			if (i < getSize() - 1) {
				strb.append(",");
			}
		}
		return strb.toString();
	}

	public String toString(int k)
	{
		StringBuilder strb = new StringBuilder();
		for (int i = 0; i < getSize(); i++) {
			String format = String.format("%%.%df", k);
			strb.append(String.format(format, getValue(i)));
			if (i < getSize() - 1) {
				strb.append(",");
			}
		}
		return strb.toString();
	}

	public double distance(Vector prev)
	{
		double sum = 0;
		for (int i = 0; i < getSize(); i++) {
			sum += Math.pow(prev.getValue(i) - getValue(i), 2);
		}
		return Math.sqrt(sum);
	}
	
	public double norm()
	{
		return Math.sqrt(this.transponate().multiplyFromRight(this).toScalar());
	}
	
	public Vector normalized()
	{
		return this.multiply(1.0 / this.norm()).toVector();
	}
}
