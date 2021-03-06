# MN_Assignments

Home assignments for Year 1 Sem 2 Numerical Methods course at the Faculty of 
Automatic Control and Computers

# MN1

**This assignment consisted of four parts.** 

* The first part revolves around the **Jacobi** factorization algorithm used 
with sparse matrices to solve an experiment based on the probability a mice 
trapped in a triangle maze has to reach a coridor with food.

![Part1](https://github.com/TudorPescaru/MN_Assignments/blob/master/MN1/maze.png)

* The second part uses the **K-Means** n-dimensional clustering algorith to 
teach a model to separate optimally a set of D-dimensional points in NC 
clusters.

* The third part uses **Householder** factorization and the upper-triangular 
system algorithm to solve an Ax=b system where A is a matrix of image 
histograms created from a dataset of cat and non-cat images, x is a trained 
model and y is a set of image clases, these are represented as a vector of 1 
for cat images and -1 for non-cat images. The histograms can be built in both 
RGB and HSV formats. This model is then used with a test set of cat and non-cat 
images in an attempt to corectly calsify the images. The success rate is 
arround 85%.

* The fourth and final part is a redesign of the third part to accomodate very 
large sets of data. This time we use the **Gradient Descent** iterative 
algorithm to train the model. The algorithm is scaled down to a Mini-batch 
format using only a batch-size of 64. The algorithm is ran through 500 epochs 
to train the model. Due to the downscale of the algorithm and the large set of 
images, the average accuracy of the model is only around 60%.

# MN2

This assignment tackled the behind-the-scenes of the Google search engine. 
More speciffically it was centered around the **PageRank** algorith. The 
assignment was split into 3 small parts. 
* The first part involved the implementation of the **Iterative** variant of 
the algorithm. 
* The second part implemented the **Algebraic** variant of the algorithm. This 
part also required the implementation of a **Modified Gram-Schmidt** 
factorization algorithm to efficiently calculate the inverse of a matrix. 
* The final part involved using a member function to calculate the **Fuzzy 
Logic** values for each page and sort all the analysed pages in order of 
importance, thus emulating the process behind a Google search.

