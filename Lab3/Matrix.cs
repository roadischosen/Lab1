using System;
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
    public class Matrix
    {

        public int n;
        public int[,] data;

        public Matrix(int n)
        {
            this.n = n;
            this.data = new int[n, n];
        }

        // Matrix product
        public Matrix mul(Matrix mr)
        {
            Matrix result = new Matrix(n);
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    result.data[i, j] = 0;
                    for (int k = 0; k < n; k++)
                    {
                        result.data[i, j] += this.data[i, k] * mr.data[k, j];
                    }
                }
            }
            return result;
        }

        // Transposing
        public Matrix transp()
        {
            Matrix result = new Matrix(n);
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    result.data[i, j] = this.data[j, i];
                }
            }
            return result;
        }

        // Test data input
        public void input()
        {
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    data[i, j] = 1;
                }
            }
        }

        // String representation
        public String toString()
        {
            String result = "";
            for (int i = 0; i < n; i++)
            {
                for (int j = 0; j < n; j++)
                {
                    result += data[i, j].ToString() + " ";
                }
                result += "\n";
            }
            return result;
        }
    }
}
