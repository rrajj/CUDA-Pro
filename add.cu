// add_gpu.cpp -> run the add.cpp code on a GPU

#include <iostream>
#include <math.h>
using namespace std;

// function to add elements of two arrays
/*
GPU can run a function called a `kernel` in CUDA.
Add the specifier __global__ to the function, it tells
the CUDA C++ compiler that the function runs on the GPU
and can be called from CPU code.
* __global__ functions are also known as kernels
Code running on GPU -> device code
             on CPU -> host code
*/
__global__
void add(int n, float *x, float *y){
    for (int i=0; i<n; i++){
        y[i] = x[i] + y[i];
    }
}

int main(){
    int N = 1<<20;      // 1M elements

    float *x, *y;
    cudaMallocManaged(&x, N*sizeof(float));
    cudaMallocManaged(&y, N*sizeof(float));

    // initialize x and y arrays on the host
    for(int i=0; i<N; i++){
        x[i] = 1.0f;
        y[i] = 2.0f;
    }

    // Run kernel on 1M elements on the CPU
    /*
    launch one GPU thread to run add().
    */
    add<<<1, 1>>>(N, x, y);

    cudaDeviceSynchronize();

    // Check for errors (all values should be 3.0f)
    float maxError = 0.0f;

    for(int i=0; i<N; i++){
        // calculate maximum absolute difference between an 
        // element of array y and the value 3.0
        maxError = fmax(maxError, fabs(y[i] - 3.0f));
    }
    cout << "Max Error: " << maxError << endl;

    // free memory
    cudaFree(x);
    cudaFree(y);

    return 0;
}