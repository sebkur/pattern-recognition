package ub1.a1;

import java.awt.Color;
import java.awt.Graphics2D;
import java.awt.image.BufferedImage;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.IOException;
import java.io.OutputStreamWriter;
import java.io.UnsupportedEncodingException;
import java.io.Writer;
import java.util.Collection;
import java.util.List;

import javax.imageio.ImageIO;

import org.apache.batik.dom.GenericDOMImplementation;
import org.apache.batik.svggen.SVGGraphics2D;
import org.apache.batik.svggen.SVGGraphics2DIOException;
import org.w3c.dom.DOMImplementation;
import org.w3c.dom.Document;

import pendigits.PendigitRecord;
import pendigits.PendigitReader;
import pendigits.visualize.RecordPanel;

public class TestDrawImages {
	public static void main(String[] args) throws IOException {
		if (args.length != 3) {
			System.out
					.println("TestDisplay <data file> <output prefix> <# files to generate>");
			System.exit(1);
		}

		String filePath = args[0];
		String outPath = args[1];
		String numValue = args[2];

		int n = 0;
		try {
			n = Integer.parseInt(numValue);
		} catch (NumberFormatException e) {
			System.out.println(String.format("unable to read number: '%s'",
					numValue));
			System.exit(1);
		}

		List<PendigitRecord> records = PendigitReader.readAtFilePath(filePath);

		System.out.println(String.format("#records: %d", records.size()));
		System.out.println("will generate up to " + n + " images");

		test(records, outPath, n);
	}

	private static void test(Collection<PendigitRecord> records,
			String prefixPath, int n) {
		int i = 0;
		for (PendigitRecord record : records) {
			if (i++ > n) {
				break;
			}
			String path = prefixPath + "-" + i + ".svg";
			// test(record, path);
			testSVG(record, path);
		}
	}

	private static void testSVG(PendigitRecord record, String path) {
		DOMImplementation domImpl = GenericDOMImplementation
				.getDOMImplementation();
		String svgNS = "http://www.w3.org/2000/svg";
		Document document = domImpl.createDocument(svgNS, "svg", null);
		SVGGraphics2D svgGenerator = new SVGGraphics2D(document);

		int width = 600;
		int height = 600;
		RecordPanel recordPanel = new RecordPanel(record);
		recordPanel.setBackground(Color.WHITE);
		recordPanel.setSize(width, height);
		recordPanel.paintComponent(svgGenerator);

		File file = new File(path);
		File parent = file.getParentFile();
		if (parent != null) {
			parent.mkdirs();
		}

		boolean useCSS = true;
		Writer out = null;
		try {
			FileOutputStream fos = new FileOutputStream(path);
			out = new OutputStreamWriter(fos, "UTF-8");
			svgGenerator.stream(out, useCSS);
		} catch (UnsupportedEncodingException e) {
			System.out.println("unsupported encoding: " + e.getMessage());
		} catch (SVGGraphics2DIOException e) {
			System.out.println("svg exception: " + e.getMessage());
		} catch (FileNotFoundException e) {
			System.out.println("file not found: " + e.getMessage());
		}
	}

	private static void test(PendigitRecord record, String path) {
		int width = 600;
		int height = 600;

		BufferedImage image = new BufferedImage(width, height,
				BufferedImage.TYPE_4BYTE_ABGR);
		Graphics2D graphics = image.createGraphics();

		// graphics.setColor(Color.BLACK);
		// graphics.fillRect(0, 0, width, height);
		// graphics.setColor(Color.WHITE);
		// graphics.fillRect(0, 0, width / 2, height);

		RecordPanel recordPanel = new RecordPanel(record);
		recordPanel.setSize(width, height);
		recordPanel.paintComponent(graphics);

		try {
			ImageIO.write(image, "png", new File(path));
		} catch (IOException e) {
			System.out.println("unable to write image: " + e.getMessage());
		}
	}

}
