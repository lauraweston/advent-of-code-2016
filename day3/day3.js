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
    const transformedTriangles = [];
    while (sides.length > 2) {
        let setOfThreeTriangleSides = sides.splice(0, 3);
        transformSetOfThreeTriangleSides(setOfThreeTriangleSides)
            .forEach(triangle => {
                transformedTriangles.push(triangle);
            });
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
