package ub1.a1;

import java.io.IOException;
import java.util.List;

import javax.swing.JFrame;
import javax.swing.JList;
import javax.swing.JScrollPane;

import pendigits.PendigitRecord;
import pendigits.PendigitReader;
import pendigits.visualize.ListListModel;
import pendigits.visualize.RecordCellRenderer;
import pendigits.visualize.RecordPanel;


public class TestDisplay
{
	public static void main(String[] args) throws IOException
	{
		if (args.length != 1) {
			System.out.println("TestDisplay <data file>");
			System.exit(1);
		}

		String filePath = args[0];

		List<PendigitRecord> records = PendigitReader.readAtFilePath(filePath);

		System.out.println(String.format("#records: %d",
				records.size()));

		// Record record = recordsTraining.iterator().next();
		// test(record);

		testShowList(records);
	}

	/**
	 * Display a single record in a frame.
	 * 
	 * @param record
	 *            the record to display.
	 */
	public static void test(PendigitRecord record)
	{
		JFrame frame = new JFrame();
		RecordPanel recordPanel = new RecordPanel(record);
		frame.setContentPane(recordPanel);
		frame.setSize(300, 300);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}

	/**
	 * Display a list of records in a JList.
	 * 
	 * @param records
	 *            the records to display.
	 */
	public static void testShowList(List<PendigitRecord> records)
	{
		ListListModel<PendigitRecord> listModel = new ListListModel<PendigitRecord>(records);
		JList list = new JList(listModel);
		list.setCellRenderer(new RecordCellRenderer(200));
		JScrollPane jsp = new JScrollPane(list);

		JFrame frame = new JFrame();
		frame.setContentPane(jsp);
		frame.setSize(300, 300);
		frame.setVisible(true);
		frame.setDefaultCloseOperation(JFrame.EXIT_ON_CLOSE);
	}
}
