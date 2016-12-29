const assert = require("assert");
const fs = require("fs");
const day3 = require("../day3/day3.js");
const isValidTriangle = day3.isValidTriangle;
const parse = day3.parse;
const countValidTriangles = day3.countValidTriangles;

describe("isValidTriangle", () => {
    describe("given the length of 3 sides", () => {
        const testCases = [
            ["1 1 1", true],
            ["  1  1 1  ", true],
            ["25 10 5", false],
            ["  25 10   5 ", false]
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
        ["1 1 1\n1 1 1", ["1 1 1", "1 1 1"]]
    ];

    testCases.forEach(testCase => {
        it("splits given puzzle input at line breaks into an array", () => {
            const actual = parse(testCase[0]);
            const expected = testCase[1];
            assert.deepEqual(actual, expected);
        });
    });
});

describe("Valid triangle counter", () => {
    const testCases = [
        ["1 1 1\n1 1 1", 2],
        [fs.readFileSync(__dirname + "/puzzleInput.txt", "utf8"), 993]
    ];
     testCases.forEach(testCase => {
        it("counts number of valid triangles given a list of sides", () => {
            const actual = countValidTriangles(testCase[0]);
            const expected = testCase[1];
            assert.equal(actual, expected);
        });
    });
});