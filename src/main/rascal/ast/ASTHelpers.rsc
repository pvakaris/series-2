module ast::AstHelpers

import Node;
import Set;

import lang::java::m3::Core;

import metrics::Volume;


/*
    Inspired by Baxter et al.
   
    Calculate the similarity between two subtrees
    Similarity = 2 * S / (2 * S + L + R)
    where:
        S = number of shared nodes
        L = number of different nodes in sub-tree 1
        R = number of different nodes in sub-tree 2
*/

real calculateSimilarity(set[node] subtree1, set[node] subtree2) {
    set[node] sharedNodes = subtree1 & subtree2;
    int s = size(sharedNodes);
    int l = size(subtree1 - sharedNodes);
    int r = size(subtree2 - sharedNodes);

     if (s == 0 && (l + r) == 0) {
        return 100.0;
    } else if ((2 * s + l + r) == 0) {
        return 0.0;
    }

    return (2.0 * s / (2.0 * s + l + r)) * 100.0;
}