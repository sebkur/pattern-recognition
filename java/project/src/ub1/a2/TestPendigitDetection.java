package ub1.a2;

import java.io.IOException;
import java.util.List;

import pendigits.PendigitReader;
import pendigits.PendigitRecord;

public class TestPendigitDetection {

	public static void main(String[] args) throws IOException {
		if (args.length != 2) {
			System.out
					.println("TestPendigitDetection <training data> <testing data>");
			System.exit(1);
		}

		String filePathTraining = args[0];
		String filePathTesting = args[1];

		List<PendigitRecord> recordsTraining = PendigitReader
				.readAtFilePath(filePathTraining);
		List<PendigitRecord> recordsTesting = PendigitReader
				.readAtFilePath(filePathTesting);

		System.out.println(String.format("#records training: %d",
				recordsTraining.size()));
		System.out.println(String.format("#records testing: %d",
				recordsTesting.size()));

		PendigitClassificator classificator = new PendigitClassificator();

		int successCount = 0;
		int n = recordsTesting.size();
		for (PendigitRecord record : recordsTesting) {
			int trueClass = record.getClassNumber();
			int guessedClass = classificator.classify(record, recordsTraining,
					1);
			boolean success = trueClass == guessedClass;
			if (success) {
				successCount += 1;
			}
		}
		double successRate = successCount / (double) n;
		double failureRate = 1 - successRate;
		System.out.println(String.format("success rate: %.2f%%",
				successRate * 100));
		System.out.println(String.format("failure rate: %.2f%%",
				failureRate * 100));
	}
}
