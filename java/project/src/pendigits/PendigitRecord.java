package pendigits;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import classificator.ClassRecord;
import classificator.VectorRecord;

import misc.lina.Vector;
import misc.lina.VectorType;


public class PendigitRecord implements Iterable<Coordinate>, ClassRecord, VectorRecord<Integer>
{
	private int classNumber;
	private List<Coordinate> coordinates;

	public PendigitRecord(List<Integer> numbers)
	{
		this(numbers.get(numbers.size() - 1),
				numbers.subList(0, numbers.size() - 1));
	}

	public PendigitRecord clone()
	{
		PendigitRecord copy = new PendigitRecord(classNumber, new ArrayList<Integer>());
		copy.coordinates = coordinates;
		return copy;
	}
	
	public PendigitRecord(int classNumber, List<Integer> coords)
	{
		this.classNumber = classNumber;
		this.coordinates = new ArrayList<Coordinate>();
		for (int i = 0; i < coords.size() / 2; i++) {
			Coordinate c = new Coordinate(
					coords.get(i * 2), coords.get(i * 2 + 1));
			coordinates.add(c);
		}
	}

	@Override
	public int getClassNumber()
	{
		return classNumber;
	}
	
	public void setClassNumber(int classNumber) {
		this.classNumber = classNumber;
	}

	@Override
	public Iterator<Coordinate> iterator()
	{
		return coordinates.iterator();
	}

	public int getNumberOfCoordinates()
	{
		return coordinates.size();
	}

	public Coordinate getCoordinate(int n)
	{
		return coordinates.get(n);
	}

	@Override
	public String toString()
	{
		StringBuilder strb = new StringBuilder();
		Iterator<Coordinate> iterator = coordinates.iterator();
		while (iterator.hasNext()) {
			Coordinate c = iterator.next();
			strb.append(String.format("%d,%d", c.getX(), c.getY()));
			if (iterator.hasNext()) {
				strb.append(",");
			}
		}
		return strb.toString();
	}

	public String toFormat()
	{
		StringBuilder strb = new StringBuilder();
		Iterator<Coordinate> iterator = coordinates.iterator();
		while (iterator.hasNext()) {
			Coordinate c = iterator.next();
			strb.append(String.format("%d %d", c.getX(), c.getY()));
			if (iterator.hasNext()) {
				strb.append(" ");
			}
		}
		strb.append(" ");
		strb.append(classNumber);
		return strb.toString();
	}

	@Override
	public int getNumberOfDimensions()
	{
		return getNumberOfCoordinates() * 2;
	}

	@Override
	public Integer getValue(int k)
	{
		Coordinate coord = getCoordinate(k / 2);
		if (k % 2 == 0){
			return coord.getX();
		}else{
			return coord.getY();
		}
	}

	@Override
	public Vector toVector()
	{
		Vector vector = new Vector(getNumberOfDimensions(), VectorType.Column);
		for (int i = 0; i < getNumberOfDimensions(); i++){
			double d = getValue(i) / 100.0;
			vector.setValue(i, d);
		}
		return vector;
	}
}
