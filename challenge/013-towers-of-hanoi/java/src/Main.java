import java.util.*;

public class Main {

    public static void main(final String[] args) {
        if (args.length != 1) {
            System.err.println("Usage; java Main \"<size>\"");
            System.exit(2);
        }
        final int size = Integer.parseInt(args[0]);
        solve(size);
    }

    private static void solve(final int size) {
        List<Integer> towerA = new ArrayList<Integer>();
        List<Integer> towerB = new ArrayList<Integer>();
        List<Integer> towerC = new ArrayList<Integer>();

        // Fill the first tower.
        for (int i = size; i > 0; i--) {
            towerA.add(0, i);
        }

        List<List<List<Integer>>> considerationOrder;
        if (size % 2 == 0) {
            considerationOrder = List.of(
                    List.of(towerA, towerB),
                    List.of(towerA, towerC),
                    List.of(towerB, towerC)
            );
        } else {
            considerationOrder = List.of(
                    List.of(towerA, towerC),
                    List.of(towerA, towerB),
                    List.of(towerB, towerC)
            );
        }

        print(size, towerA, towerB, towerC);

        outerloop:
        while (true) {
            for (List<List<Integer>> consideration : considerationOrder) {
                boolean moved = makeLegalMove(consideration.get(0), consideration.get(1))
                        || makeLegalMove(consideration.get(1), consideration.get(0));
                if (moved) {
                    print(size, towerA, towerB, towerC);
                    // Check if we have completed
                    if (towerA.isEmpty() && towerB.isEmpty()) {
                        break outerloop;
                    }
                }
            }
        }
    }

    private static void print(final int size,
                              final List<Integer> towerA,
                              final List<Integer> towerB,
                              final List<Integer> towerC) {
        int maxLength = String.valueOf(size).length();
        for (int i = 0; i < size; i++) {
            for (List<Integer> tower : List.of(towerA, towerB, towerC)) {
                int index = i - size + tower.size();

                if (index < 0) {
                    System.out.print("-".repeat(maxLength)+" ");
                } else {
                    System.out.print(tower.get(index));

                    System.out.print(" ".repeat(maxLength - String.valueOf(index).length() + 1));
                }
            }
            // Separate rows
            System.out.println();
        }
        // Separate print outs
        System.out.println();
    }

    private static boolean makeLegalMove(final List<Integer> from,
                                         final List<Integer> to) {

        // Return early if nothing to move
        if (from.size() == 0) {
            return false;
        }

        // Don't considered movements which are illegal
        if (!to.isEmpty() && from.get(0) > to.get(0)) {
            return false;
        }

        int disk = from.get(0);
        from.remove(0);
        to.add(0, disk);
        return true;
    }


}