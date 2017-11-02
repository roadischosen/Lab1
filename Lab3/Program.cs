using System;
using System.Threading;
/*
 * Laboratory work #3
 * Threads in C#
 * Author: Zemin V.M.
 * Group: IO-53
 * 
 * Tasks:
 * 1.18 -- d  = (A*B) + (C*(B*(MA*MD))
 * 2.06 -- MG = TRANS(MK) * (MH*MF)
 * 3.11 -- T  = SORT(O + P)*TRANS(MR*MS)
 * 
 * File: Matrix.cs
 */
namespace Lab3
{
    public class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("Lab3 started");
            int N = 2000;
            
            Thread t1 = new Thread(T1, 1000000);
            Thread t2 = new Thread(T2, 1000000);
            Thread t3 = new Thread(T3, 1000000);

            t1.Name = "Thread 1";
            t1.Priority = ThreadPriority.Lowest;
            t2.Name = "Thread 2";
            t2.Priority = ThreadPriority.Normal;
            t3.Name = "Thread 3";
            t3.Priority = ThreadPriority.Highest;

            t1.Start(N);
            t2.Start(N);
            t3.Start(N);

            t1.Join();
            t2.Join();
            t3.Join();

            Console.WriteLine("Lab3 finished\nPress any key to exit");
            Console.ReadKey();
        }


        static void T1(Object param)
        {
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            Thread.Sleep(1);

            int n = (int)param;

            Vector A = new Vector(n);
            A.input();

            Vector B = new Vector(n);
            B.input();

            Vector C = new Vector(n);
            C.input();

            Matrix MA = new Matrix(n);
            MA.input();

            Matrix MD = new Matrix(n);
            MD.input();

            Console.WriteLine(Thread.CurrentThread.Name + " result: {0}\n", A.mul(B) + C.mul(B.mul(MA.mul(MD))));

            Thread.Sleep(1);
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }


        static void T2(Object param)
        {
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            Thread.Sleep(1);

            int n = (int)param;

            Matrix MK = new Matrix(n);
            MK.input();
            Matrix MH = new Matrix(n);
            MH.input();
            Matrix MF = new Matrix(n);
            MF.input();

            Matrix result = MK.transp().mul(MH.mul(MF));
            if (n <= 5)
            {
                Console.WriteLine(Thread.CurrentThread.Name + " results:\n" + result.toString());
            }

            Thread.Sleep(1);
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }


        static void T3(Object param)
        {
            Console.WriteLine(Thread.CurrentThread.Name + " started");
            Thread.Sleep(1);

            int n = (int)param;

            Vector O = new Vector(n);
            O.input();
            Vector P = new Vector(n);
            P.input();

            Matrix MR = new Matrix(n);
            MR.input();
            Matrix MS = new Matrix(n);
            MS.input();

            O = O.add(P);
            O.sort();
            Vector result = O.mul(MR.mul(MS).transp());

            if (n <= 5)
            {
                Console.WriteLine(Thread.CurrentThread.Name + " results:\n" + result.toString());
            }

            Thread.Sleep(1);
            Console.WriteLine(Thread.CurrentThread.Name + " finished");
        }
    }
}
