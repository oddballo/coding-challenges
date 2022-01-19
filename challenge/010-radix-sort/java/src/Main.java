import java.util.*;

public class Main {

	static final int BUCKET_SIZE = 10;

	public static void main(final String[] args) {
		if (args.length != 2) {
			System.err.println("Usage; java Main \"<integer list>\" \"<keyLength>\"");
			System.exit(2);
		}
		// Read arguments
		Integer[] integers = Arrays
				.stream(args[0].split("[, \n]"))
				.map(Integer::parseInt)
				.toArray(Integer[]::new);

		int keyLength = Integer.parseInt(args[1]);

		integers = radixSort(integers, keyLength);
		print(integers);
	}

	private static void print(final Integer[] array){
		if(array.length == 0){
			System.out.println("Empty");
		}
		for(int i = 0; i < array.length - 1; i++){
			System.out.print(String.format("%d,", array[i]));
		}
		System.out.println(String.format("%d", array[array.length-1]));
	}

	private static Integer[] radixSort(Integer[] array, final int keyLength){
		if(array.length < 2){
			return array;
		}

		ArrayList<ArrayList<Integer>> buckets;
		for(int significantBit = 1; significantBit <= keyLength; significantBit++) {
			buckets = new ArrayList<>(BUCKET_SIZE);
			for(int i = 0; i < BUCKET_SIZE; i++){
				buckets.add(i, new ArrayList<>());
			}
			for (Integer integer : array) {
				int key = (integer % (int)Math.pow(BUCKET_SIZE, significantBit))
						/ (int)Math.pow(BUCKET_SIZE, significantBit-1);
				buckets.get(key).add(integer);
			}
			array = buckets.stream()
					.flatMap(Collection::stream)
					.toArray(Integer[]::new);
		}
		return array;
	}
}