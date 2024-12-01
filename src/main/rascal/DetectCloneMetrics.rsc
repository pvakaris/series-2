module DetectCloneMetrics

import List;
import Set;
import String;
import DateTime;
import Location;
import lang::java::m3::Core;
import lang::java::m3::AST;

import utils::Helpers;
import utils::Calculator;
import utils::Logger;

import metrics::Volume;

// class metrics
data metric = metric(int i1, int i2, int i3, int i4);

bool compareMetrics(metric m1, metric m2){
    if(metric(m1n1, m1n2, m1n3, m1n4) := m1 && metric(m2n1, m2n2, m2n3, m2n4) := m2)
        return m1n1 == m2n1 && m1n2 == m2n2 && m1n3 == m2n3 && m1n4 == m2n4;
    else
        return false;
}

metric sumMetrics(metric m1, metric m2){
    if(metric(m1n1, m1n2, m1n3, m1n4) := m1 && metric(m2n1, m2n2, m2n3, m2n4) := m2)
        return metric(m1n1 + m2n1, m1n2 + m2n2, m1n3 + m2n3, m1n4 + m2n4);
    else
        return metric(-1, -1, -1, -1);
}

rel[loc, loc] analyze(loc project){
    return {<|tmp://myTempDirectory|, |tmp://myTempDirectory|>};
}