using System;
/*
 * Лабораторна робота №3
 * Процеси в мові С#
 * Виконав: Земін В.М.
 * Група: ІО-53
 * 
 * Завдання:
 * 1.18 -- d  = (A*B) + (C*(B*(MA*MD))
 * 2.06 -- MG = TRANS(MK) * (MH*MF)
 * 3.11 -- T  = SORT(O + P)*TRANS(MR*MS)
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

        // Скалярний добуток
        public int mul(Vector vr)
        {
            int result = 0;

            for (int i = 0; i < n; i++)
            {
                result += this.data[i] * vr.data[i];
            }

            return result;
        }

        // Множення на матрицю
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

        // Сума векторів
        public Vector add(Vector vr)
        {
            Vector result = new Vector(n);

            for (int i = 0; i < n; i++)
            {
                result.data[i] = this.data[i] + vr.data[i];
            }

            return result;
        }

        // Сортування вектору
        public Vector sort()
        {
            Array.Sort(this.data);
            return this;
        }

        // Заповнення тестовими даними
        public void input()
        {
            for (int i = 0; i < n; i++)
            {
                data[i] = 1;
            }
        }

        // Рядкове представлення
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
