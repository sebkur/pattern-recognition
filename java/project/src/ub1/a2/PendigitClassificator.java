package ub1.a2;

import pendigits.Coordinate;
import pendigits.PendigitRecord;
import classificator.Classificator;

public class PendigitClassificator extends Classificator<PendigitRecord>
{
	@Override
	public double distance(PendigitRecord record, PendigitRecord other)
	{
		double sum = 0;
		for (int i = 0; i < record.getNumberOfCoordinates(); i++) {
			Coordinate ca = record.getCoordinate(i);
			Coordinate cb = other.getCoordinate(i);
			sum += Math.pow(cb.getX() - ca.getX(), 2);
			sum += Math.pow(cb.getY() - ca.getY(), 2);
		}
		return Math.sqrt(sum);
	}
}
