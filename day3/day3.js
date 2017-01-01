'use strict';

function parseTriangleRow(row) {
    return row
        .trim()
        .split(/\s+/)
        .map(side => parseInt(side, 10));
}

function parse(input) {
    return input.split(/\n/).map(parseTriangleRow);
}

function isValidTriangle(sideLengths) {
    sideLengths.sort((a, b) => a - b);
    return sideLengths[0] + sideLengths[1] > sideLengths[2];
}

function countValidTrianglesByRow(input) {
    const triangles = parse(input);
    return triangles.filter(isValidTriangle).length;
}

function transformSetOfThreeTriangleSides(setOfThreeTriangleSides) {
    const transformedTriangles = [[], [], []];
    setOfThreeTriangleSides.forEach(sides => {
        for (let i = 0; i < sides.length; i++) {
            transformedTriangles[i].push(sides[i]);
        }
    });
    return transformedTriangles;
}

function splitSidesIntoSetsOfThree(sides) {
    let transformedTriangles = [];
    while (sides.length > 2) {
        const setOfThreeTriangleSides = sides.splice(0, 3);
        const transformedSetOfThree = transformSetOfThreeTriangleSides(setOfThreeTriangleSides);
        transformedTriangles = transformedTriangles.concat(transformedSetOfThree);
    }
    return transformedTriangles;
}

function countValidTrianglesByColumn(input) {
    const sides = parse(input);
    return splitSidesIntoSetsOfThree(sides).filter(isValidTriangle).length;
}

module.exports = {
    isValidTriangle,
    parse,
    countValidTrianglesByRow,
    countValidTrianglesByColumn
};
