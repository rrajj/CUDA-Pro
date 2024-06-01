#include <iostream>
#include <math.h>
using namespace std;

// function to add elements of two arrays
void add(int n, float *x, float *y){
    for (int i=0; i<n; i++){
        y[i] = x[i] + y[i];
    }
}

int main(){
    int N = 1<<20;      // 1M elements

    float *x = new float[N];
    float *y = new float[N];

    // initialize x and y arrays on the host
    for(int i=0; i<N; i++){
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    // Run kernel on 1M elements on the CPU
    add(N, x, y);

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0f;

    for(int i=0; i<N; i++){
        // calculate maximum absolute difference between an 
        // element of array y and the value 3.0
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    }
    cout << "Max Error: " << maxError << endl;

    // free memory
    delete [] x;
    delete [] y;

    return 0;
}