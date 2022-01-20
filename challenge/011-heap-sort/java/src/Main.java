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

        heapSort(integers);
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

    private static void heapSort(final Integer[] array) {
        if (array.length < 2) {
            return;
        }

        // Heapify all non-leaf nodes.
        for (int i = array.length / 2 - 1; i >= 0; i--) {
            heapify(array, array.length, i);
        }

        // Swap, heapify, and shrink the amount of the array we consider
        // until we've sorted the array
        for (int i = array.length - 1; i >= 0; i--) {
            swap(array, 0, i);
            heapify(array, i, 0);
        }
    }

    private static void heapify(final Integer[] array, final int totalNodes, final int indexCurrent) {
        int indexLargest = indexCurrent;

        // Because it's a complete binary tree, we can use the array
        // structure to represent the tree
        int indexLeft = 2 * indexCurrent + 1;
        int indexRight = 2 * indexCurrent + 2;

        // Find the largest index; choice of current node, the left node
        // (if it exists), or the right node (if it exists)
        if (indexLeft < totalNodes
                && array[indexLeft] > array[indexLargest]) {
            indexLargest = indexLeft;
        }
        if (indexRight < totalNodes
                && array[indexRight] > array[indexLargest]) {
            indexLargest = indexRight;
        }

        // If there is no need to change, return early
        if (indexLargest == indexCurrent) {
            return;
        }

        swap(array, indexCurrent, indexLargest);
        heapify(array, totalNodes, indexLargest);
    }

    private static void swap(final Integer[] array, final int indexFrom, final int indexTo) {
        Integer tmp = array[indexFrom];
        array[indexFrom] = array[indexTo];
        array[indexTo] = tmp;
    }
}
