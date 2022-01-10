public class Main {

	public static void main(String[] args) {
		if (args.length != 1) {
			System.err.println("Usage; java Main \"<prime>\"");
			System.exit(2);
		}
		long n = Long.parseLong(args[0]);
		System.exit(isPrime(n) ? 0 : 1);
	}

	private static boolean isPrime(long n){
		// Save costlier modulus operation
		if (n == 2 || n == 3) {
			return true;
		}

		// Check if divisible by 2 or 3 (not covered by optimization below)
		// not a natural number and not 1
		if (n <= 1 || n % 2 == 0 || n % 3 == 0){
			return false;
		}

		// Take advantage of 6k(+-)1 optimization - any prime > 3
		// can be represented by this. Saves looking at all numbers
		// - Early i*i exit as products identified after that are
		// 	 the inverse of products we've already considered
		// - Start with 5 instead of 6 to save one arithmetic operation
		//	 i.e. when k=1, 5 and 5+2 instead of 6-1 and 6+1
		for (long i = 5; i * i <= n; i += 6){
			if (n % i == 0 || n % (i + 2) == 0) {
				return false;
			}
		}

		return true;
	}
}