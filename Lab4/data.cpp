/*
 * Laboratory work #4
 * Threads in C++
 * Author: Zemin V.M.
 * Group: IO-53
 * 
 * Tasks:
 * 1.18 -- d  = (A*B) + (C*(B*(MA*MD))
 * 2.06 -- MG = TRANS(MK) * (MH*MF)
 * 3.11 -- T  = SORT(O + P)*TRANS(MR*MS)
 * 
 * File: data.cpp
 */
#include "data.h"

void input_vector(int *vector, size_t n) {
	for (auto i = 0; i < n; i++)
		vector[i] = 1;
}
void input_matrix(int *matrix, size_t n) {
	for (size_t i = 0; i < n*n; i += n)
		input_vector(&matrix[i], n);
}

void matrix_prod(int *ma, int* mb, int *res, size_t n) {
	for (auto i = 0; i < n; i++)
		for (auto j = 0; j < n; j++)
		{
			res[i*n+j] = 0;
			for (auto k = 0; k < n; k++)
				res[i*n+j] += ma[i*n+k] * mb[k*n+j];
		}
}

int vector_prod(int *va, int *vb, size_t n) {
	int result = 0;
	for (auto i = 0; i < n; i++)
		result += va[i] * vb[i];

	return result;
}

void matvec_prod(int* v, int *m, int *res, size_t n) {
	for (auto i = 0; i < n; i++)
	{
		res[i] = 0;
		for (auto j = 0; j < n; j++)
			res[i] += v[j] * m[j*n+i];
	}
}

void transp(int *m, int *res, size_t n) {
	for (auto i = 0; i < n; i++)
		for (auto j = 0; j < n; j++)
			res[i*n+j] = m[j*n+i];
}

void vector_sum(int *v1, int *v2, int *res, size_t n) {
	for (auto i = 0; i < n; i++)
		res[i] = v1[i] + v2[i];
}


std::string vector_to_string(int *v, size_t n) {
	std::string res ("");
	for (auto i = 0; i < n; i++)
		res += std::to_string(v[i]) + " ";
	return res;
}

std::string matrix_to_string(int *m, size_t n) {
	std::string res ("");
	for (size_t i = 0; i < n*n; i += n)
		res += vector_to_string(&m[i], n) + "\n";
	return res;
}


