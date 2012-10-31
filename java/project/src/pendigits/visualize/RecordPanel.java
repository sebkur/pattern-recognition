package pendigits.visualize;

import java.awt.BasicStroke;
import java.awt.Color;
import java.awt.Dimension;
import java.awt.Font;
import java.awt.Graphics;
import java.awt.Graphics2D;
import java.awt.RenderingHints;

import javax.swing.JComponent;

import pendigits.Coordinate;
import pendigits.PendigitRecord;


public class RecordPanel extends JComponent
{
	private static final long serialVersionUID = -2416340349885241185L;

	private PendigitRecord record;

	public RecordPanel(PendigitRecord record)
	{
		this.record = record;
	}

	public void setRecord(PendigitRecord record)
	{
		this.record = record;
	}

	@Override
	public void paintComponent(Graphics g)
	{
		super.paintComponent(g);

		Graphics2D g2d = (Graphics2D) g;
		g2d.setRenderingHint(RenderingHints.KEY_ANTIALIASING,
				RenderingHints.VALUE_ANTIALIAS_ON);

		g2d.setColor(getBackground());
		g2d.fillRect(0, 0, getWidth(), getHeight());

		Dimension size = getSize();
		int width = 4;
		int length = Math.min((int) size.getHeight(), (int) size.getWidth());
		int realLength = length - width;

		double factor = getHeight() / 200.0;
		
		g2d.clipRect(0, 0, length, length);

		g2d.setColor(new Color(0x66aaaaaa, true));
		g2d.setStroke(new BasicStroke((float) 4.0));
		g2d.drawRect(width / 2, width / 2, realLength, realLength);

		g2d.setColor(new Color(0x99000000, true));

		int coordNum = 0;
		Coordinate last = null;
		for (Coordinate c : record) {
			int x = (int) Math.round((c.getX() / 100.0 * realLength));
			int y = (int) (realLength - Math
					.round((c.getY() / 100.0 * realLength)));

			g2d.setColor(getColor(coordNum++, 8));

			int diameter = (int) (10 * factor);
			g2d.fillArc(x - diameter / 2, y - diameter / 2,
					diameter, diameter, 0, 360);
			
			g2d.setStroke(new BasicStroke((float) factor * 2));

			if (last != null) {
				int xLast = (int) Math
						.round((last.getX() / 100.0 * realLength));
				int yLast = (int) (realLength - Math
						.round((last.getY() / 100.0 * realLength)));
				g2d.setColor(new Color(0x99000000, true));
				g2d.drawLine(xLast, yLast, x, y);
			}

			last = c;
		}
		
		g2d.setColor(new Color(0x000000));
		Font font = g2d.getFont();
		font = new Font(font.getName(), font.getStyle(),
				(int) (factor * font.getSize()));
		g2d.setFont(font);
		g2d.drawString("Klasse: " + record.getClassNumber(), 10, (int) (20 * factor));
	}

	private Color getColor(int coordNum, int total)
	{
		float rel = (float) (coordNum / (float) total);
		float r = 1.0f - rel;
		float g = 0.0f + rel;
		float b = 0.0f;
		return new Color(r, g, b, 0.7f);
	}
}
