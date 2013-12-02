#include <stdio.h>
#include <string.h>
#include "mex.h"

void mexFunction(int nlhs, mxArray *plhs[], int nrhs, const mxArray *prhs[])
{
	const mxArray *C;
	mxArray *Cdiff;
	double *C_ptr, *Cdiff_ptr;
	const mwSize *dims;
	mwSize ylim, xlim;
	unsigned int i, j;


/*
	if (nlhs != 1)
		mexErrMsgIdAndTxt("MATLAB:hexdiff:maxlhs", "Too many output arguments.");
*/
	if (nrhs != 1)
		mexErrMsgIdAndTxt("MATLAB:hexdiff:maxlhs", "Want one input argument.");

	C = prhs[0];
	C_ptr = mxGetPr(C);
	dims = mxGetDimensions(C);
	ylim = dims[0];
	xlim = dims[1];

/*	fprintf(stderr, "ylim = %d, xlim=%d\n", ylim, xlim);*/


	Cdiff = mxCreateDoubleMatrix(ylim, xlim, mxREAL);
	Cdiff_ptr = mxGetPr(Cdiff);

	/* For simplicity, we only care about the non-border elements */
	for (i = 1; i < xlim - 1; i++) {
		for(j = 1; j < ylim - 1; j++) {
			double diff = 0;
			double curr_C = C_ptr[i *ylim + j];

			/* The guy on the left */
			diff += (C_ptr[i * ylim + (j - 1)] - curr_C) / 2;
			/* The guy on the right */
			diff += (C_ptr[i * ylim + (j + 1)] - curr_C) / 2;
			/* The guy on top */
			diff += (C_ptr[(i - 1) * ylim + j] - curr_C) / 2;
			/* The guy below */
			diff += (C_ptr[(i + 1) * ylim + j] - curr_C) / 2;

			if (i % 2) {
				/* If it's odd, also look at the top-left and bottom-left ones.  */
				/* Left-top one */
				diff += (C_ptr[(i - 1) * ylim + (j - 1)] - curr_C) / 2;
				/* Left-bottom one */
				diff += (C_ptr[(i + 1) * ylim + (j - 1)] - curr_C) / 2;
			} else {
				/* If it's even, look at top-right and bottom-right ones. */
				/* Right-top one */
				diff += (C_ptr[(i - 1) * ylim + (j + 1)] - curr_C) / 2;
				/* Right-bottom  one */
				diff += (C_ptr[(i + 1) * ylim + (j + 1)] - curr_C) / 2;
			}
			/* Do the magic */
			Cdiff_ptr[i * ylim + j] = curr_C + diff / 6;
		}
	}

	plhs[0] = Cdiff;
}

