package ubx;

import java.io.IOException;
import java.util.List;
import java.util.Map;

import pendigits.PendigitReader;
import pendigits.PendigitRecord;
import ub1.a2.PendigitClassificator;
import classificator.WeightedRecord;

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

		// for each record and each record in the training data, calculate their
		// distance. Put all distances in a list with ascending order by
		// distance.
		// This is a cache for optimizing performance of the successive tests
		// with k = 1, 2, 3, ...
		Map<PendigitRecord, List<WeightedRecord<PendigitRecord>>> recordToNeighbors = classificator
				.calculateAllNeighborDistances(recordsTesting, recordsTraining);

		// number of testing records.
		int n = recordsTesting.size();
		// test different values for k:
		for (int k = 1; k <= 30; k++) {
			// determine the number of successfully classified records
			int success = classificator.classifyAll(recordsTesting,
					recordToNeighbors, k);
			// and the number of failed records
			int fail = n - success;
			// and the detection rate
			double detectionRate = success / (double) n;
			System.out.println(String.format(
					"k: %d, succes: %d, fail: %d, detectionRate: %f", k,
					success, fail, detectionRate));
			System.out.println(String.format("%d %f", k, detectionRate));
		}
	}

}
