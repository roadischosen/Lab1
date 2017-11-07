/*
* Laboratory work #5
* Threads in OpenMP
* Author: Zemin V.M.
* Group: IO-53
*
* Tasks:
* 1.18 -- d  = (A*B) + (C*(B*(MA*MD))
* 2.06 -- MG = TRANS(MK) * (MH*MF)
* 3.11 -- T  = SORT(O + P)*TRANS(MR*MS)
*
* File: Lab5.cpp
*/
#include <omp.h>
#include <iostream>
#include "data.h"

#define N 3

void T1() {
	std::cout << "Thread 1 started\n";

	size_t n = N;

	int *A = new int[n];
	input_vector(A, n);

	int *B = new int[n];
	input_vector(B, n);

	int *C = new int[n];
	input_vector(C, n);

	int *MA = new int[n*n];
	input_matrix(MA, n);

	int *MD = new int[n*n];
	input_matrix(MD, n);

	int *mp = new int[n*n];
	matrix_prod(MA, MD, mp, n);

	int *vmp = new int[n];
	matvec_prod(B, mp, vmp, n);

	std::cout << "Thread 1 result: " + std::to_string(vector_prod(A, B, n) + vector_prod(C, vmp, n)) + '\n';

	delete[] A;
	delete[] C;
	delete[] MA;
	delete[] MD;
	delete[] mp;
	delete[] vmp;

	std::cout << "Thread 1 finished\n";
}

void T2() {
	std::cout << "Thread 2 started\n";

	size_t n = N;

	int *MK = new int[n*n];
	input_matrix(MK, n);

	int *MH = new int[n*n];
	input_matrix(MH, n);

	int *MF = new int[n*n];
	input_matrix(MF, n);

	int *mp = new int[n*n];
	matrix_prod(MH, MF, mp, n);

	transp(MK, MH, n); // MH = Transp(MK)

	matrix_prod(MH, mp, MK, n); // MK = MH * mp == thread result

	if (n <= 5)
		std::cout << "Thread 2 results:\n" + matrix_to_string(MK, n) + '\n';

	delete[] MK;
	delete[] MH;
	delete[] MF;
	delete[] mp;

	std::cout << "Thread 2 finished\n";
}

void T3() {
	std::cout << "Thread 3 started\n";

	size_t n = N;

	int *O = new int[n];
	input_vector(O, n);

	int *P = new int[n];
	input_vector(P, n);

	int *MR = new int[n*n];
	input_matrix(MR, n);

	int *MS = new int[n*n];
	input_matrix(MS, n);

	vector_sum(O, P, O, n);
	std::sort(O, O + n);

	int *mp = new int[n*n];
	matrix_prod(MR, MS, mp, n);

	transp(mp, MR, n); // MR = Transp(MR*MS)
	matvec_prod(O, MR, P, n); // P == thread results

	if (n <= 5)
		std::cout << "Thread 3 results:\n" + vector_to_string(P, n) + '\n';

	delete[] MR;
	delete[] MS;
	delete[] P;
	delete[] O;
	delete[] mp;

	std::cout << "Thread 3 finished\n";
}

int main()
{
	std::cout << "Lab5 started" << std::endl;

	#pragma omp parallel
	{
		#pragma omp sections
		{
			#pragma omp section
			{
				T1();
			}
			#pragma omp section
			{
				T2();
			}
			#pragma omp section
			{
				T3();
			}
		}
	}


	std::cout << "Lab5 finished" << std::endl;
	system("pause");
}

