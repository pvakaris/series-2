module utils::MapHelpers


import Node;
import Map;
import Set;

import lang::java::m3::Core;

import metrics::Volume;


import metrics::Volume;

int sumMap(map[value, set[loc]] mapp){
    int sum = 0;
    for (key <- mapp) {
        for (val <- mapp[key]) {
            sum += 1;
        }
    }
    return sum;
}

tuple[int, int] sumMapDeep(map[value, set[loc]] mapp) {
    int sum = 0;
    int total = 0;

    for (key <- mapp) {
        int size = size(mapp[key]);

        if (size > 0) {
            sum += 1;
            funcl = countFunctionalLines(getFirstFrom(mapp[key]));
            total += size * funcl;
        }
    }
    return <sum, total>;
}

map[value, set[loc]] filterEntriesAboveThreshold(map[value, set[loc]] mapp, int threshold=1) {
    map[value, set[loc]] result = ();
    for (entry <- mapp) {
    
        if (size(mapp[entry]) > threshold) {
            result[entry] = mapp[entry];
        }
    }
    return result;
}

map[value, set[loc]] addEntry(map[value, set[loc]] mapp, node entry) {
    node unsetEntry = unsetRec(entry);

    if (unsetEntry in mapp) {
        mapp[unsetEntry] += entry.src;
    } else {
        mapp[unsetEntry] = {entry.src};
    }
    return mapp;
}
