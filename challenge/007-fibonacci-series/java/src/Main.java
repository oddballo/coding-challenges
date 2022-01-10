public class Main {

	public static void main(String[] args) {
		// Setup - format the input argument into a int array as intended by the task
		// Exit 2 to represent validation error
		if (args.length != 1) {
			System.err.println("Usage; java Main \"<Upto>\"");
			System.exit(2);
		}
		int upto = Integer.parseInt(args[0]);
		int a = 1;
		int b = 1;
		int c;
		while(b <= upto){
			c = a + b;
			a = b;
			b = c;
		}
		System.out.println(a);
	}
}