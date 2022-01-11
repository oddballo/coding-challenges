import java.util.Arrays;

public class Main {

	public static void main(String[] args) {
		if (args.length != 1) {
			System.err.println("Usage; java Main \"<integer list>\"");
			System.exit(2);
		}
		// Read arguments
		Integer[] integers = Arrays
				.stream(args[0].split("[, ]"))
				.map(Integer::parseInt)
				.toArray(Integer[]::new);

		bubbleSort(integers);
		print(integers);
	}

	private static void print(Integer[] array){
		if(array.length == 0){
			System.out.println("Empty");
		}
		for(int i = 0; i < array.length - 1; i++){
			System.out.print(String.format("%d,", array[i]));
		}
		System.out.println(String.format("%d", array[array.length-1]));
	}

	private static void bubbleSort(Integer[] array){
		Integer tmp;
		for(int i = 0; i < array.length-1; i++){
			for(int j = i+1; j < array.length; j++){
				int comparison = Integer.compare(array[i], array[j]);
				if(comparison > 0){
					tmp = array[i];
					array[i] = array[j];
					array[j] = tmp;
				}
			}
		}
	}
}