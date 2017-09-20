import java.util.Arrays;
import java.util.Scanner;

public class Vector {

	int n;
	int[] data;

	public Vector(int n) {
		this.n = n;
		this.data = new int[n];
	}

	public int mul(Vector vr) {
		int result = 0;

    	for (int i = 0; i < n; i++) {
    	    result += this.data[i] * vr.data[i];
    	}

    	return result;
	}

	public Vector mul(Matrix mr) {
		Vector result = new Vector(n);
		for (int i = 0; i < mr.n; i++) {
			result.data[i] = 0;
			for (int j = 0; j < this.n; j++) {
				result.data[i] += this.data[j] * mr.data[j][i];
			}
		}
		return result;
	}

	public Vector add(Vector vr) {
		Vector result = new Vector(n);

		for (int i = 0; i < n; i++) {
			result.data[i] = this.data[i] + vr.data[i];
		}

		return result;
	}

	public Vector sort() {
		Arrays.sort(this.data);
		return this;
	}

	public void input(boolean auto_fill) {
		Scanner scan = new Scanner(System.in);
		for (int i = 0; i < n; i++) {
            data[i] = auto_fill ? 1 : scan.nextInt();
        } 
	}

	public String toString() {
		String result = "";
		for (int j = 0; j < n; j++) {
            result += Integer.toString(data[j]) + " ";
        }
        return result;
	}
}