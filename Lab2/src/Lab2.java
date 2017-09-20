// import Data.Matrix;
// import Data.Vector;

public class Lab2 {

	public static void main(String args[]) throws InterruptedException {

		System.out.println("Lab2 starterd");

		int N = 3;
		boolean auto = true;

		Thread t1 = new T1("Thread1", Thread.MIN_PRIORITY, N, auto);
		Thread t2 = new T2("Thread2", Thread.NORM_PRIORITY, N, auto);
		Thread t3 = new Thread(new T3("Thread3 (Runnable)", Thread.MAX_PRIORITY, N, auto));

		t1.start();
		t2.start();
		t3.start();

		t1.join();
		t2.join();
		t2.join();

		System.out.println("Lab2 finished");
	}
}


class T1 extends Thread {

	private int n;
	private boolean auto_fill;

	public T1(String name, int priority, int n, boolean auto_fill) {
		super(name);
		this.setPriority(priority);
		this.n = n;
		this.auto_fill = auto_fill;
	}

	public void run() {
		System.out.println(this.getName() + " started");

        Vector A = new Vector(n);
        A.input(auto_fill);

        Vector B = new Vector(n);
        B.input(auto_fill);

        Vector C = new Vector(n);
        C.input(auto_fill);

        Matrix MA = new Matrix(n);
        MA.input(auto_fill);

        Matrix MD = new Matrix(n);
        MD.input(auto_fill);


        System.out.printf(this.getName() + " result: %d\n", calc(A, B, C, MA, MD));
        System.out.println(this.getName() + " finished");
	}

	private int calc(Vector a, Vector b, Vector c, Matrix ma, Matrix md) {
		return a.mul(b) + c.mul(b.mul(ma.mul(md)));
	}
}

class T2 extends Thread {

	private int n;
	private boolean auto_fill;
	
	public T2(String name, int priority, int n, boolean auto_fill) {
		super(name);
		this.setPriority(priority);
		this.n = n;
		this.auto_fill = auto_fill;
	}

	public void run() {
		System.out.println(this.getName() + " started");

        Matrix MK = new Matrix(n);
        MK.input(auto_fill);
        Matrix MH = new Matrix(n);
        MH.input(auto_fill);
        Matrix MF = new Matrix(n);
        MF.input(auto_fill);

        Matrix result = calc(MK, MH, MF);
        if (n < 5) {
        	System.out.print(this.getName() + " results:\n" + result.toString());
        }

        System.out.println(this.getName() + " finished");
	}

	private Matrix calc(Matrix mk, Matrix mh, Matrix mf) {
		return mk.transp().mul(mh.mul(mf));
	}
}

class T3 implements Runnable {

	private int n;
	private Thread thread;
	private boolean auto_fill;
	
	public T3(String name, int priority, int n, boolean auto_fill) {
		thread = new Thread(name);
		thread.setPriority(priority);
		this.n = n;
		this.auto_fill = auto_fill;
	}

	public void run() {
		System.out.println(thread.getName() + " started");

        Vector O = new Vector(n);
        O.input(auto_fill);
        Vector P = new Vector(n);
        P.input(auto_fill);

        Matrix MR = new Matrix(n);
        MR.input(auto_fill);
        Matrix MS = new Matrix(n);
        MS.input(auto_fill);

        Vector result = calc(O, P, MR, MS);
        if (n < 5) {
        	System.out.println(thread.getName() + " results:\n" + result.toString());
        }

        System.out.println(thread.getName() + " finished");
	}

	private Vector calc(Vector o, Vector p, Matrix mr, Matrix ms) {
		o = o.add(p);
		o.sort();
		return o.mul(mr.mul(ms).transp());
	}
}
