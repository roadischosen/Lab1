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
    public class Vector
    {

        int n;
        int[] data;

        public Vector(int n)
        {
            this.n = n;
            this.data = new int[n];
        }

        // Scalar product
        public int mul(Vector vr)
        {
            int result = 0;

            for (int i = 0; i < n; i++)
            {
                result += this.data[i] * vr.data[i];
            }

            return result;
        }

        // Matrix and vector product
        public Vector mul(Matrix mr)
        {
            Vector result = new Vector(n);
            for (int i = 0; i < mr.n; i++)
            {
                result.data[i] = 0;
                for (int j = 0; j < this.n; j++)
                {
                    result.data[i] += data[j] * mr.data[j, i];
                }
            }
            return result;
        }

        // Vector sum
        public Vector add(Vector vr)
        {
            Vector result = new Vector(n);

            for (int i = 0; i < n; i++)
            {
                result.data[i] = this.data[i] + vr.data[i];
            }

            return result;
        }

        // Vector sort
        public Vector sort()
        {
            Array.Sort(this.data);
            return this;
        }

        // Test data input
        public void input()
        {
            for (int i = 0; i < n; i++)
            {
                data[i] = 1;
            }
        }

        // String reprezentation
        public String toString()
        {
            String result = "";
            for (int j = 0; j < n; j++)
            {
                result += data[j].ToString() + " ";
            }
            return result;
        }
    }
}
