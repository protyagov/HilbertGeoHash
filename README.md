# HilbertGeoHash
Calculate Hilbert curve value in linear time O(n) on huge space

![Alt text](h2.png?raw=true "Hilbert Curve of 8 and 16 order")

**GeoHash** - Hash for a spatial coordinate

**Hilbert Curve** - Line that travels through every coordinate exactly once and therefore is perfect candidate for geo hash value.

Globe is 360 degrees, good precision is 100,000 points per a degree = 360 x 100,000 = 36,000,000. I needed a function to quickly calculate geohash for 36x36 million box. Second requirement is ability to use < and > on geo hash value to figure our how far given coordinates from each other or from origin -- so instead of comparing coordinates we would compare their geohashes which would be faster, especially when number of dimensions increase.

While looking for fast geo hash in Swift for iPhone project I did not really find anything. Search for spatial curves produced several results and Hilbert's curve was selected. Several algorithms in C, Java and C# to calculate Hilbert's value were found. The most I liked Xian Lu algorithm (published in 1996) implementation in Java. I converted that to Swift 4 and ran several tests. Unfortunately performance on real size data was slow.

When I almost gave up I have discovered work of Ningtao Chen (Huazhong University, China) published in 2006. His algorithm runs in linear O(n) time and can handle 2^32 resolution. Also, it does not require to know space resolution N, it only takes coordinates. Therefore performance is O(m) instead of O(n) where m < n.

Benchmark results in Swift 4 compiled with -OFast flag. Program calculates hilbert value for each coordinate on (0,0)-(n,n) diagonal using Chen and Lu algorithms:

---------------
Here is some benchmark results. It calculates hilbert value for each coordinate on (0,0)-(n,n) diagonal:
```bash
H-Cruve algorithm by Ningtao Chen, Resolution:  100 ->   0.64 msec

H-Cruve algorithm by Xian Lu,      Resolution:  100 ->   1.44 msec

H-Cruve algorithm by Ningtao Chen, Resolution: 1000 ->   3.93 msec

H-Cruve algorithm by Xian Lu,      Resolution: 1000 -> 130.53 msec
```
