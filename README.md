# LRTV_revision
1. LRTV [1] is a super-resolution method that does not need any training data.

  [1] Shi, Feng, et al. "LRTV: MR image super-resolution with low-rank and total variation regularizations." IEEE transactions on medical imaging 34.12 (2015): 2459-2466.

2. LRTV has publicly abailable code:
https://bitbucket.org/fengshi421/superresolutiontoolkit/src/master/

3. LRTV only considers isotropic super-resolution. For example, given an image with resolution 2x2x2mm, it can super-resolve a resulted image with resolution of 1x1x1mm. 

In clinical practice, medical images usually have anisotropic resolution of axaxb, e.g., 0.8x0.8x3 mm. Original LRTV cannot super-resolve a resulted image with resolution of axaxa, i.e., 0.8x0.8x0.8mm for this example.

4. This problem can be solved by simply substituting ./mylib/my_upsample.m and ./mylib/my_downsample.m with these two scripts. 
