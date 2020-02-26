#include "pch.h"
#include <iostream>
#include <cstdlib>
#include <ctime>

using namespace std;

extern "C" void FILL_MAS(int xMin, int xMax, int *numbers, int nCount, int *mas);
extern "C" void COMPUTE_LIMITS(int xMin, int xMax, int *mas, int *ranges, int *out, int limitsMaxIndex);
extern "C" void COMPUTE_PR(int xMin, int xMax, int *mas, int *ranges, int *out, int limitsMaxIndex);

int mRand(int xMin, int xMax) {
	return rand() % (xMax - xMin + 1) + xMin;
}

int main() {
	srand(time(0));

	int xMin, xMax, nCount, rCount;

	cout << "Enter xMin, xMax, numbers count and ranges count divided by spaces, f.e. <-10 20 2000 4>" << endl;
	cin >> xMin >> xMax >> nCount >> rCount;

	rCount--;

	if (rCount < 0) {
		cout << "Oops, not enough limits" << endl;
		return 0;
	}

	int *ranges = (int*) calloc(rCount, sizeof(int)),
		*results = (int*) calloc(rCount + 1, sizeof(int));

	if (rCount > 0)
		cout << "Enter " << rCount << " left edges" << endl;
	for (int i = 0; i < rCount; i++) {
		cin >> ranges[i];
	}

	int *numbers = (int*) calloc(nCount, sizeof(int));

	cout << "Generated " << nCount << " numbers: ";
	for (int i = 0; i < nCount; i++) {
		int test = mRand(xMin, xMax);
		numbers[i] = test;
		cout << test << " ";
	}
	cout << endl;

	int *mas = (int*)calloc(xMax - xMin + 1, sizeof(int));

	FILL_MAS(xMin, xMax, numbers, nCount, mas);
	for (int i = 0; i < (xMax - xMin + 1); i++) {
		cout << i + xMin << ": " << mas[i] << endl;
	}
	COMPUTE_LIMITS(xMin, xMax, mas, ranges, results, rCount);
	cout << "Numbers counts in ranges: ";
	for (int i = 0; i <= rCount; i++) {
		cout << results[i] << " ";
		results[i] = 1; // clear to pass array to COMPUTE_PR function
	}

	COMPUTE_PR(xMin, xMax, mas, ranges, results, rCount);
	cout << endl << "Numbers products in ranges: ";
	for (int i = 0; i <= rCount; i++) {
		cout << results[i] << " ";
	}


	delete ranges, results, numbers, mas;
	return 0;
}