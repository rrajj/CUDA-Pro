# Learning CUDA Programming  
This repo I am going to maintain code while learning CUDA.
  
## Basics  
#### `__global__` specifier  
Adding the specifier __global__ to the function, it tells the CUDA C++ compiler that the function runs on the GPU and can be called from CPU code.  
* __global__ functions are also known as kernels  
* Code running on GPU -> device code  
* Code running on CPU -> host code  