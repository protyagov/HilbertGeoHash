# HilbertGeoHash
Calculate Hilbert curve value in linear time O(n) on huge space

![Alt text](h2.png?raw=true "Hilbert Curve of 8 and 16 order")

In my search for some fast Geo Hash function to use on iPhone project I did not find much. Start looking around and found various space curves. A space curve is 1D line that goes throught every coordinate exactly one time and therefore can be used as hash for mapping coordinates. After consideration I choose Z-Curve and Hilber-Curve and finally decieded to implement Hilbert curve. 
Found several implementation in C, Java and C# languages. Converted about 3 different implementations into Swift 4 and was upset with performance. I want to use geo has on world map with acceptable accuracy. 

So, globe is 360 degrees and good accuracy would be 100,000 points per degree. Therefore I needed fast way to calculate Hilber curve of order 360 x 100000 = 36,000,000. All implementations I found did not peform well on box 36 by 36 million points. The one I liked the most was implementation Xian Lu algorithm published in 1996 and then implemented in several different languages. I have converted one of implemnetaitons to Swift 4 but was not happy with performance and I doubt it can work on very large Hilber resolution without modifications.

When I almost gave up on Hilber Curve implementation I found awsome work published in 2006 by Ningtao Chen from Huazhong University, China. That algorithm does run in linear O(n) time and can handle 2^32 resoluctions. Actual calculation of Hilbert code (geo hash) only takes coordinates and does not requre to provide resoluction N as others implemenations do.
In addition calculated geo hash is build so that it can be compared with < and > with other hashes. Therefore we can compare geo hash of A and B and see which one is closer to origin on the curve.

---------------
Here is some benchmark results. It calculates hilbert value for each coordinate on (0,0)-(n,n) diagonal:
```bash
Hibert Cruve algorithm by Ningtao Chen, Data size:  100 -> 0.646988 msec

Hilbert Cruve algorithm by Xian Lu,     Data size:  100 -> 1.449083 msec

Hibert Cruve algorithm by Ningtao Chen, Data size: 1000 -> 3.899346 msec

Hilbert Cruve algorithm by Xian Lu,     Data size: 1000 -> 130.5336 msec
```
