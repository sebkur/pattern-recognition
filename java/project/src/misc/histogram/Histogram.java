package misc.histogram;

import java.util.ArrayList;
import java.util.Collections;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

public class Histogram<T>
{
	Map<T, Integer> map = new HashMap<T, Integer>();
	
	public void put(T element, int count) {
		int occurrences = 0;
		if (map.containsKey(element)){
			occurrences = map.get(element);
		}
		occurrences += count;
		map.put(element, occurrences);
	}
	
	public int getFrequency(T element) {
		if (!map.containsKey(element)){
			return 0;
		}
		return map.get(element);
	}
	
	public List<Entry<T>> getFrequencyList() {
		List<Entry<T>> list = new ArrayList<Entry<T>>();
		for (T element : map.keySet()){
			int occurences = map.get(element);
			list.add(new Entry<T>(element, occurences));
		}
		Collections.sort(list);
		Collections.reverse(list);
		return list;
	}
}
