package misc.lina;

import java.util.Random;

public class Matrix
{
	private final int height;
	private final int width;

	private double[][] values;

	public Matrix(int height, int width)
	{
		if (height < 1 || width < 1) {
			throw new IllegalArgumentException(
					"width and height must be positive");
		}

		this.height = height;
		this.width = width;
		values = new double[height][width];
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				values[y][x] = 0.0;
			}
		}
	}

	private Matrix(double[][] values)
	{
		this.width = values[0].length;
		this.height = values.length;
		this.values = values;
	}

	public int getWidth()
	{
		return width;
	}

	public int getHeight()
	{
		return height;
	}

	public void setValue(int x, int y, double v)
	{
		if (x < 0 || x > width - 1) {
			throw new IllegalArgumentException(
					"matrix out of bounds: x");
		}
		if (y < 0 || y > height - 1) {
			throw new IllegalArgumentException(
					"matrix out of bounds: y");
		}

		values[y][x] = v;
	}

	public double getValue(int x, int y)
	{
		if (x < 0 || x > width - 1) {
			throw new IllegalArgumentException(
					"matrix out of bounds: x");
		}
		if (y < 0 || y > height - 1) {
			throw new IllegalArgumentException(
					"matrix out of bounds: y");
		}

		return values[y][x];
	}

	public Matrix transponate()
	{
		Matrix transponated = new Matrix(width, height);
		for (int y = 0; y < height; y++) {
			for (int x = 0; x < width; x++) {
				transponated.setValue(y, x, getValue(x, y));
			}
		}
		return transponated;
	}

	public Matrix multiplyFromRight(Matrix other)
	{
		if (width != other.height) {
			throw new IllegalArgumentException("sizes don't fit");
		}

		Matrix result = new Matrix(height, other.width);
		for (int y = 0; y < result.getHeight(); y++) {
			for (int x = 0; x < result.getWidth(); x++) {
				double value = 0.0;
				for (int k = 0; k < width; k++) {
					value += getValue(k, y) * other.getValue(x, k);
				}
				result.setValue(x, y, value);
			}
		}
		return result;
	}

	public Matrix add(Matrix other)
	{
		if (!getDimension().equals(other.getDimension())) {
			throw new IllegalArgumentException("dimensions don't match");
		}

		Matrix result = new Matrix(height, width);

		for (int y = 0; y < result.getHeight(); y++) {
			for (int x = 0; x < result.getWidth(); x++) {
				result.setValue(x, y, getValue(x, y) + other.getValue(x, y));
			}
		}

		return result;
	}

	public Matrix subtract(Matrix other)
	{
		if (!getDimension().equals(other.getDimension())) {
			throw new IllegalArgumentException("dimensions don't match");
		}

		Matrix result = new Matrix(height, width);

		for (int y = 0; y < result.getHeight(); y++) {
			for (int x = 0; x < result.getWidth(); x++) {
				result.setValue(x, y, getValue(x, y) - other.getValue(x, y));
			}
		}

		return result;
	}

	public Matrix multiply(double lambda)
	{
		Matrix result = new Matrix(height, width);

		for (int y = 0; y < result.getHeight(); y++) {
			for (int x = 0; x < result.getWidth(); x++) {
				result.setValue(x, y, getValue(x, y) * lambda);
			}
		}

		return result;

	}

	public boolean isScalar()
	{
		return width == 1 && height == 1;
	}

	public boolean isVector()
	{
		return width == 1 || height == 1;
	}

	public double toScalar()
	{
		if (!isScalar()) {
			throw new IllegalArgumentException("matrix is not a scalar");
		}
		return getValue(0, 0);
	}

	public Vector toVector()
	{
		if (!isVector()) {
			throw new IllegalArgumentException("matrix is not a vector");
		}

		if (height == 1) {
			Vector vector = new Vector(width, VectorType.Row);
			for (int x = 0; x < width; x++) {
				vector.setValue(x, 0, getValue(x, 0));
			}
			return vector;
		} else {
			Vector vector = new Vector(height, VectorType.Column);
			for (int y = 0; y < height; y++) {
				vector.setValue(0, y, getValue(0, y));
			}
			return vector;
		}
	}

	public Dimension getDimension()
	{
		return new Dimension(width, height);
	}

	public String toString()
	{
		StringBuilder strb = new StringBuilder();
		String newline = System.getProperty("line.separator");

		for (int y = 0; y < getHeight(); y++) {
			for (int x = 0; x < getWidth(); x++) {
				strb.append(String.format("%10.4f", getValue(x, y)));
				if (x < getWidth() - 1) {
					strb.append(" ");
				}
			}
			if (y < getHeight() - 1) {
				strb.append(newline);
			}
		}

		return strb.toString();
	}

	public void initRandom(Random random, int maxValue)
	{
		for (int y = 0; y < getHeight(); y++) {
			for (int x = 0; x < getWidth(); x++) {
				int v = random.nextInt(maxValue + 1);
				setValue(x, y, v);
			}
		}
	}

	public static Matrix getIdentity(int size)
	{
		Matrix matrix = new Matrix(size, size);
		for (int i = 0; i < size; i++){
			matrix.values[i][i] = 1.0;
		}
		return matrix;
	}

	public Matrix invert()
	{
		Jama.Matrix jama = new Jama.Matrix(values);
		Jama.Matrix jamaInverse = jama.inverse();
		Matrix inverse = new Matrix(jamaInverse.getArray());
		return inverse;
	}

	public double determinant()
	{
		Jama.Matrix jama = new Jama.Matrix(values);
		return jama.det();
	}
}
