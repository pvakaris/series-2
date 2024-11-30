module ast::ASTHelpers

import IO;
import lang::java::m3::AST;
import Node;
import Map;
import List;
import Set;
import Type;


/*
    Inspired by Baxter et al.
   
    Calculate the similarity between two subtrees
    Similarity = 2 * S / (2 * S + L + R)
    where:
        S = number of shared nodes
        L = number of different nodes in sub-tree 1
        R = number of different nodes in sub-tree 2
*/

real calculateSimilarity(list[str] subtree1, list[str] subtree2) {
    list[str] sharedNodes = subtree1 & subtree2;
    int s = size(sharedNodes);
    int l = size(subtree1 - sharedNodes);
    int r = size(subtree2 - sharedNodes);

    return (2.0 * s / (2.0 * s + l + r)) * 100.0;
}