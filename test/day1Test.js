const day1 = require("../day1/day1.js");
const Parser = day1.Parser;
const DistanceCalculator = day1.DistanceCalculator;
const assert = require("assert");

describe("directions parser", () => {
    const testCases = [
        ["", []],
        ["R1", [{ direction: 'R', distance: 1 }]],
        ["R1, L3", [{ direction: 'R', distance: 1 }, { direction: 'L', distance: 3 }]]
    ];
    testCases.forEach(tc => {
        it("splits the input into an array of instructions", () => {
            const input = tc[0];
            const expected = tc[1];
            const parser = new Parser();
            assert.deepEqual(parser.parse(input), expected);
        });
    });
});

describe("distance calculator", () => {
    const testCases = [
        [[], 0],
        [[{ direction: 'R', distance: 1 }], 1],
        [[{ direction: 'R', distance: 1 },{ direction: 'R', distance: 2 }], 3],
        [[{ direction: 'R', distance: 2 },{ direction: 'L', distance: 3 }], 5]
    ];

    testCases.forEach(tc => {
        it("calculates shortest distance correctly", () => {
            const input = tc[0];
            const expected = tc[1];
            const distanceCalculator = new DistanceCalculator();
            assert.equal(distanceCalculator.shortestDistance(input), expected);
        });
    });
});

describe("integration", () => {
    const testCases = [
        ["", 0],
        ["R2, L3", 5],
        ["R2, R2, R2", 2],
        ["R5, L5, R5, R3", 12],
        ["R4, R1, L2, R1, L1, L1, R1, L5, R1, R5, L2, R3, L3, L4, R4, R4, R3, L5, L1, R5, R3, L4, R1, R5, L1, R3, L2, R3, R1, L4, L1, R1, L1, L5, R1, L2, R2, L3, L5, R1, R5, L1, R188, L3, R2, R52, R5, L3, R79, L1, R5, R186, R2, R1, L3, L5, L2, R2, R4, R5, R5, L5, L4, R5, R3, L4, R4, L4, L4, R5, L4, L3, L1, L4, R1, R2, L5, R3, L4, R3, L3, L5, R1, R1, L3, R2, R1, R2, R2, L4, R5, R1, R3, R2, L2, L2, L1, R2, L1, L3, R5, R1, R4, R5, R2, R2, R4, R4, R1, L3, R4, L2, R2, R1, R3, L5, R5, R2, R5, L1, R2, R4, L1, R5, L3, L3, R1, L4, R2, L2, R1, L1, R4, R3, L2, L3, R3, L2, R1, L4, R5, L1, R5, L2, L1, L5, L2, L5, L2, L4, L2, R3", 161]
    ];

    testCases.forEach(tc => {
        it("calculates shortest distance correctly", () => {
            const input = tc[0];
            const expected = tc[1];

            const parser = new Parser();
            const distanceCalculator = new DistanceCalculator();

            const instructions = parser.parse(input);
            const distance = distanceCalculator.shortestDistance(instructions);

            assert.equal(distance, expected);
        });
    });
});