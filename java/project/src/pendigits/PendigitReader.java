package pendigits;

import java.io.BufferedReader;
import java.io.FileReader;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.regex.Matcher;
import java.util.regex.Pattern;



public class PendigitReader
{

	public static List<PendigitRecord> readAtFilePath(String filePath)
			throws IOException
	{
		// iterate lines of file
		BufferedReader reader = new BufferedReader(new FileReader(filePath));
		List<PendigitRecord> records = new ArrayList<PendigitRecord>();
		while (true) {
			String line = reader.readLine();
			if (line == null) {
				break;
			}
			try {
				// extract numbers in line
				List<Integer> numbers = analyseLine(line);
				PendigitRecord record = new PendigitRecord(numbers);
				records.add(record);
			} catch (Exception e) {
				System.out.println("unable to parse line: " + e.getMessage());
			}
		}
		return records;
	}

	private static Pattern pattern = Pattern.compile("([^\\s]+)");

	private static List<Integer> analyseLine(String line) throws Exception
	{
		// split line at whitespace
		List<String> groups = new ArrayList<String>();
		Matcher matcher = pattern.matcher(line);
		while (matcher.find()) {
			String group = matcher.group(1);
			groups.add(group);
		}
		// throw an exception if that weren't 17
		if (groups.size() != 17) {
			throw new Exception(String.format(
					"error analysing line: size is %d. Line is %d",
					groups.size(), line));
		}
		// extract numbers from strings
		List<Integer> numbers = new ArrayList<Integer>();
		for (String group : groups) {
			numbers.add(Integer.parseInt(group));
		}
		return numbers;
	}
}
