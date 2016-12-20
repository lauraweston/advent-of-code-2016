'use strict';

function Parser() { };

Parser.prototype.parse = input => {
    if (input.length === 0) {
        return [];
    }
    const directions = input.split(", ");
    return directions.map(d => {
        const direction = d.slice(0, 1);
        const distance = parseInt(d.slice(1));
        return { direction, distance };
    });
}

const directions = {
    north: 0,
    east: 1,
    south: 2,
    west: 3
};

const rotate = (position, turnDirection) => {
    const orientationChange = turnDirection === 'R' ? 1 : -1;
    let newOrientation = position.orientation + orientationChange;
    if (newOrientation > 3) {
        newOrientation = 0;
    } else if (newOrientation < 0) {
        newOrientation = 3;
    }
    // TODO: use Object.assign?
    return {
        x: position.x,
        y: position.y,
        orientation: newOrientation
    };
};

const move = (position, distance) => {
    let xDiff = 0;
    let yDiff = 0;

    switch (position.orientation) {
        case directions.north:
            yDiff = distance;
            break;
        case directions.east:
            xDiff = distance;
            break;
        case directions.south:
            yDiff = -distance;
            break;
        case directions.west:
            xDiff = -distance;
            break;
    }

    return {
        x: position.x + xDiff,
        y: position.y + yDiff,
        orientation: position.orientation
    };
};

function DistanceCalculator() { };

DistanceCalculator.prototype.shortestDistance = instructions => {
    if (instructions.length === 0) {
        return 0;
    }
    const startingPosition = {
        x: 0,
        y: 0,
        orientation: directions.north
    };

    const finalPosition = instructions.reduce((previousPosition, instruction) => {
        const rotatedPosition = rotate(previousPosition, instruction.direction);
        return move(rotatedPosition, instruction.distance);
    }, startingPosition);
    return Math.abs(finalPosition.x) + Math.abs(finalPosition.y);
};

module.exports = {
    Parser,
    DistanceCalculator
}
