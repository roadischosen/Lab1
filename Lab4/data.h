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
 * File: data.h
 */
#pragma once
#include <string>
#include <algorithm>

void input_vector(int *vector, size_t n);
void input_matrix(int *matrix, size_t n);

void matrix_prod(int *ma, int* mb, int *res, size_t n);
int vector_prod(int *va, int *vb, size_t n);
void matvec_prod(int* v, int *m, int *res, size_t n);
void transp(int *m, int *res, size_t n);

void vector_sum(int *v1, int *v2, int *res, size_t n);

std::string vector_to_string(int *v, size_t n);
std::string matrix_to_string(int *m, size_t n);
