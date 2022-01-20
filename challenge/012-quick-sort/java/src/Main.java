import java.util.*;

public class Main {

    public static void main(final String[] args) {
        if (args.length != 1) {
            System.err.println("Usage; java Main \"<integer list>\"");
            System.exit(2);
        }
        // Read arguments
        Integer[] integers = Arrays
                .stream(args[0].split("[, \n]"))
                .map(Integer::parseInt)
                .toArray(Integer[]::new);

        quickSort(integers, 0, integers.length - 1);
        print(integers);
    }

    private static void print(final Integer[] array) {
        if (array.length == 0) {
            System.out.println("Empty");
        }
        for (int i = 0; i < array.length - 1; i++) {
            System.out.print(String.format("%d,", array[i]));
        }
        System.out.println(String.format("%d", array[array.length - 1]));
    }

    private static void quickSort(final Integer[] array, final int low, final int high) {
        if (array.length < 2) {
            return;
        }
        if (low < 0 || high <= low) {
            return;
        }
        int pivot = partition(array, low, high);
        quickSort(array, low, pivot);
        quickSort(array, pivot + 1, high);
    }

    private static void swap(final Integer[] array, final int indexFrom, final int indexTo) {
        Integer tmp = array[indexFrom];
        array[indexFrom] = array[indexTo];
        array[indexTo] = tmp;
    }

    private static int partition(final Integer[] array, final int low, final int high) {
        Integer pivot = array[(high + low) / 2];
        int indexLeft = low;
        int indexRight = high;

        while (true) {
            while (array[indexLeft] < pivot) {
                indexLeft++;
            }
            while (array[indexRight] > pivot) {
                indexRight--;
            }
            // Indexes have overlapped - what is indexRight is
            // now in the correct position; return.
            if (indexLeft >= indexRight) {
                return indexRight;
            }
            swap(array, indexLeft, indexRight);
        }
    }
}