const assert = require("assert");
const fs = require("fs");
const day3 = require("../day3/day3.js");
const isValidTriangle = day3.isValidTriangle;
const parse = day3.parse;
const countValidTrianglesByRow = day3.countValidTrianglesByRow;
const countValidTrianglesByColumn = day3.countValidTrianglesByColumn;

describe("isValidTriangle", () => {
    describe("given the length of 3 sides", () => {
        const testCases = [
            [[1, 1, 1], true],
            [[25, 10, 5], false],
        ];
        testCases.forEach(testCase => {
            it("confirms if the sides make up a valid triangle", () => {
                const actual = isValidTriangle(testCase[0]);
                const expected = testCase[1];
                assert.equal(actual, expected);
            });
        });
    });
});

describe("parse input", () => {
    const testCases = [
        ["  1  1 1\n25 5 10", [[1, 1, 1], [25, 5, 10]]]
    ];

    testCases.forEach(testCase => {
        it("splits given puzzle input at line breaks into an array", () => {
            const actual = parse(testCase[0]);
            const expected = testCase[1];
            assert.deepEqual(actual, expected);
        });
    });
});

describe("Horizontal valid triangle counter", () => {
    const testCases = [
        ["1 1 1\n1 1 1", 2],
        [fs.readFileSync(__dirname + "/puzzleInput.txt", "utf8"), 993]
    ];
    testCases.forEach(testCase => {
        it("counts number of valid triangles given a list of sides grouped by row", () => {
            const actual = countValidTrianglesByRow(testCase[0]);
            const expected = testCase[1];
            assert.equal(actual, expected);
        });
    });
});

describe("Vertical valid triangle counter", () => {
    const testCases = [
        ["2 2 2\n3 3 3\n4 4 4", 3],
        ["2 2 2\n3 3 3\n4 4 4\n2 2 2\n3 3 3\n4 4 4", 6],
        [fs.readFileSync(__dirname + "/puzzleInput.txt", "utf8"), 1849]
    ];
    testCases.forEach(testCase => {
        it("counts number of valid triangles given a list of sides grouped in vertical threes", () => {
            const actual = countValidTrianglesByColumn(testCase[0]);
            const expected = testCase[1];
            assert.equal(actual, expected);
        });
    });
});