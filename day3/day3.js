'use strict';

function isValidTriangle(input) {
    const sides = input.trim().split(/\s+/);
    const sideLengths = sides.map(side => parseInt(side, 10));
    sideLengths.sort((a, b) => a - b);
    return sideLengths[0] + sideLengths[1] > sideLengths[2];
}

function parse(input) {
    return input.split(/\n/);
}

function countValidTriangles(input) {
    const triangles = parse(input);
    return triangles.filter(isValidTriangle).length;
}

module.exports = {
    isValidTriangle,
    parse,
    countValidTriangles
};
