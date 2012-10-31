package classificator;


import java.util.ArrayList;
import java.util.Collection;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import misc.histogram.Entry;
import misc.histogram.Histogram;


public abstract class Classificator<T extends ClassRecord>
{
	/**
	 * Classify a single record according to the training dataset without using
	 * a precomputed cache of distances.
	 * 
	 * @param record
	 *            the record to classify.
	 * @param recordsTraining
	 *            the training records.
	 * @param k
	 *            the number of neighbors to poll.
	 * @return the most often occurring class within the nearest <code>k</code>
	 *         neighbors.
	 */
	public int classify(T record,
			Collection<T> recordsTraining, int k)
	{
		// first compute the distances to all training records.
		List<WeightedRecord<T>> neighbors = calculateNeighborDistances(record,
				recordsTraining);
		// than classify according to the k nearest neighbors.
		return classify(record, neighbors, k);
	}
	
	/**
	 * Classify all specified records and determine the detection rate.
	 * 
	 * @param recordsTesting
	 *            the records to classify.
	 * @param recordToNeighbors
	 *            the distance cache.
	 * @param k
	 *            the number of neighbors to poll.
	 * @return the number of correctly classified records.
	 */
	public int classifyAll(List<T> recordsTesting,
			Map<T, List<WeightedRecord<T>>> recordToNeighbors, int k)
	{
		int success = 0;
		for (T record : recordsTesting) {
			List<WeightedRecord<T>> neighbors = recordToNeighbors.get(record);
			// classify the current record
			int guess = classify(record, neighbors, k);
			boolean succeeded = record.getClassNumber() == guess;
			// and increment the number of succeeded classifications if
			// necessary
			if (succeeded) {
				success += 1;
			}
		}
		return success;
	}

	/**
	 * Classify a single record by polling the first <code>k</code> elements.
	 * 
	 * @param record
	 *            the record to classify.
	 * @param neighbors
	 *            all training records with their distance to
	 *            <code>record</code>
	 * @param k
	 *            the number of nearest neighbors to poll.
	 * @return the most often occurring class within the nearest <code>k</code>
	 *         neighbors.
	 */
	public int classify(T record,
			List<WeightedRecord<T>> neighbors, int k)
	{
		// create a list of candidates with duplicates
		List<Integer> classCandidates = new ArrayList<Integer>();
		// for the k nearest neighbors
		for (int i = 0; i < k; i++) {
			// find the i'th nearest neighbor
			WeightedRecord<T> wr = neighbors.get(i);
			// determine its class number
			int classNumber = wr.getRecord().getClassNumber();
			// and add it to the candidate list
			classCandidates.add(classNumber);
		}
		// from the candidates, pick the one that occurs most often
		int classNumber = pickClass(classCandidates);
		return classNumber;
	}

	/**
	 * Given a list of integer candidates with duplicates, select the number a
	 * that occurs most often in this list.
	 * 
	 * @param candidates
	 *            a list of candidates to select the most frequent one from.
	 * @return the most often occurring item in the list.
	 */
	private int pickClass(List<Integer> candidates)
	{
		// put all values into the histogram
		Histogram<Integer> histogram = new Histogram<Integer>();
		for (int value : candidates) {
			histogram.put(value, 1);
		}
		// retrieve the sorted list of frequencies.
		List<Entry<Integer>> frequencyList = histogram.getFrequencyList();

		// pick the entry with the highest frequency.
		Entry<Integer> entry = frequencyList.get(0);
		return entry.getElement();
	}

	/**
	 * For a each record of the testing data, calculate the distance to all
	 * records of the training data. This map can be used as a cache for
	 * subsequent computations where the distance is needed more often than
	 * once.
	 * 
	 * @param recordsTesting
	 *            the starting record.
	 * @param recordsTraining
	 *            the records to calculate the distances to.
	 * @return a map from records to ordered lists of records annotated with
	 *         their distance to the specified record. The records appear in
	 *         this list in ascending distance.
	 */
	public Map<T, List<WeightedRecord<T>>> calculateAllNeighborDistances(
			List<T> recordsTesting, List<T> recordsTraining)
	{
		Map<T, List<WeightedRecord<T>>> recordToNeigbors = new HashMap<T, List<WeightedRecord<T>>>();
		for (T record : recordsTesting) {
			List<WeightedRecord<T>> neighbors = calculateNeighborDistances(
					record,
					recordsTraining);
			recordToNeigbors.put(record, neighbors);
		}
		return recordToNeigbors;
	}

	/**
	 * For a denoted record, calculate the distance to all records of the
	 * training data.
	 * 
	 * @param record
	 *            the starting record.
	 * @param recordsTraining
	 *            the records to calculate the distances to.
	 * @return an ordered list of records annotated with their distance to the
	 *         specified record. The records appear in this list in ascending
	 *         distance.
	 */
	private List<WeightedRecord<T>> calculateNeighborDistances(
			T record,
			Collection<T> recordsTraining)
	{
		// create the list to store records along with distances
		List<WeightedRecord<T>> list = new ArrayList<WeightedRecord<T>>();
		for (T other : recordsTraining) {
			// compute distance
			double dist = distance(record, other);
			// and store the record with this distance
			WeightedRecord<T> weightedRecord = new WeightedRecord<T>(other,
					dist);
			list.add(weightedRecord);
		}
		// sort the list with ascending distance
		Collections.sort(list);
		return list;
	}

	/**
	 * Implement this distance method to provide a means to select records by
	 * their respective distance to a specified record.
	 * 
	 * @param record
	 *            the first record.
	 * @param other
	 *            the record to compute the distance to.
	 * @return the distance of record to other.
	 */
	public abstract double distance(T record, T other);

}
