import java.util.List;

public class Main {

	private final static int BOARD_DIMENSION = 8;

	private static class Cartesian {
		public final int x;
		public final int y;

		public Cartesian(int x, int y){
			this.x = x;
			this.y = y;
		}

		public Cartesian transform(Cartesian cartesian){
			return new Cartesian(this.x + cartesian.x, this.y + cartesian.y);
		}

		public boolean inRange(){
			return this.x < BOARD_DIMENSION
					&& this.x >= 0
					&& this.y < BOARD_DIMENSION
					&& this.y >= 0;
		}
	}

    public static boolean cannotCapture(int[][] board) {
		final List<Cartesian> movements = List.of(
				new Cartesian(-2, 1),
				new Cartesian(-2, -1),
				new Cartesian(2, 1),
				new Cartesian(2, -1),
				new Cartesian(1, 2),
				new Cartesian(-1, 2),
				new Cartesian(-1, -2),
				new Cartesian(1, -2)
		);

		for(int i = 0; i < BOARD_DIMENSION; i++){
			for(int j = 0; j < BOARD_DIMENSION; j++){
				// Skip to next if 0 (no knight)
				if (board[i][j] == 0){
					continue;
				}
				final Cartesian cartesian = new Cartesian(i, j);
				for(Cartesian movement: movements){
					Cartesian potential = cartesian.transform(movement);
					if(potential.inRange() && board[potential.x][potential.y] == 1){
						return false;
					}
				}
			}
		}
		return true;
    }

    public static void main(String[] args) {
		// Setup - format the input argument into a int array as intended by the task
		// Exit 2 to represent validation error
		if (args.length != 1) {
			System.err.println("Usage; java Main \"0,0,0,0,0,1...\"");
			System.exit(2);
		}
		String[] entries = args[0].replaceAll("[^01,]","").split(",");
		if(entries.length != 64){
			System.err.println("Input data; failed validation (size)");
			System.exit(2);
		}
		int[][] board = new int[BOARD_DIMENSION][BOARD_DIMENSION];
		for(int i = 0; i < BOARD_DIMENSION; i++){
			for(int j = 0; j < BOARD_DIMENSION; j++){
				board[i][j] = Integer.parseInt(entries[i * BOARD_DIMENSION + j]);
			}
		}

		// Exit 0 to represent true, Exit 1 to represent false
		System.exit(cannotCapture(board) ? 0 : 1);
    }
}
