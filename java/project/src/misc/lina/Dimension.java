package misc.lina;

public class Dimension
{

	int width;
	int height;

	public Dimension(int width, int height)
	{
		this.width = width;
		this.height = height;
	}

	public int getWidth()
	{
		return width;
	}

	public int getHeight()
	{
		return height;
	}

	@Override
	public boolean equals(Object o)
	{
		if (!(o instanceof Dimension)) {
			return false;
		}
		Dimension other = (Dimension) o;
		return other.height == height && other.width == width;
	}
	
	@Override
	public String toString()
	{
		return String.format("%dx%d", height, width);
	}
}
