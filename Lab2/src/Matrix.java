import java.util.Scanner;

public class Matrix {

	int n;
	int[][] data;

	public Matrix(int n) {
		this.n = n;
		this.data = new int[n][n];
	}

	public Matrix mul(Matrix mr) {
		Matrix result = new Matrix(n);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
            	result.data[i][j] = 0;
                for (int k = 0; k < n; k++) {
                    result.data[i][j] += this.data[i][k] * mr.data[k][j];
                }
            }
        }
        return result;
	}
	
	public Matrix transp() {
		Matrix result = new Matrix(n);
        for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
                result.data[i][j] = this.data[j][i];
            }
        }
        return result;
	}

	public void input(boolean auto_fill) {
		Scanner scan = new Scanner(System.in);
		for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
            	data[i][j] = auto_fill ? 1 : scan.nextInt();
            }
        } 
	}

	public String toString() {
		String result = "";
		for (int i = 0; i < n; i++) {
            for (int j = 0; j < n; j++) {
            	result += Integer.toString(data[i][j]) + " ";
            }
            result += "\n";
        }
        return result;
	}
}

	
