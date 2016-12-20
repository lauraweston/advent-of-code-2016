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

    return Object.assign({}, position, { orientation: newOrientation });// TODO: use Object.assign?
};

const move = (position, distance) => {
    let xDiff = 0;
    let yDiff = 0;

    switch (position.orientation) {
        case directions.north:
            yDiff = 1;
            break;
        case directions.east:
            xDiff = 1;
            break;
        case directions.south:
            yDiff = -1;
            break;
        case directions.west:
            xDiff = -1;
            break;
    }

    const pathTaken = [];
    for (let i = 1; i <= distance; i++) {
        pathTaken.push({
            x: position.x + (xDiff * i),
            y: position.y + (yDiff * i)
        });
    }

    return Object.assign({}, position, {
        x: position.x + (xDiff * distance),
        y: position.y + (yDiff * distance),
        path: position.path.concat(pathTaken)
    });
};

function DistanceCalculator() { };

const firstLocationVisitedTwice = (locations) => {

    const visitedLocations = new Set();
    for (let i = 0; i < locations.length; i++) {
        const location = locations[i];
        const locationKey = `${location.x},${location.y}`;

        if (visitedLocations.has(locationKey)) {
            return location;
        }

        visitedLocations.add(locationKey);
    }
};

const followInstructions = (instructions) => {
    const startingPosition = {
        x: 0,
        y: 0,
        orientation: directions.north,
        path: [{ x: 0, y: 0 }]
    };

    return instructions.reduce((previousPosition, instruction) => {
        const rotatedPosition = rotate(previousPosition, instruction.direction);
        return move(rotatedPosition, instruction.distance);
    }, startingPosition);
};

DistanceCalculator.prototype.shortestDistance = instructions => {
    const finalPosition = followInstructions(instructions);

    return Math.abs(finalPosition.x) + Math.abs(finalPosition.y);
};

DistanceCalculator.prototype.shortestDistanceToFirstIntersection = instructions => {
    const finalPosition = followInstructions(instructions);

    const visitedTwice = firstLocationVisitedTwice(finalPosition.path);

    return Math.abs(visitedTwice.x) + Math.abs(visitedTwice.y);
};

module.exports = {
    Parser,
    DistanceCalculator
}
