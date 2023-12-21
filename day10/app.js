let width = 1800;
let height = 1800;
let fontSize = 10;
let dataSet = [];
let markList = [];
let excludeList = [];
let targetS;
let DATASET_HIGHT;
let DATASET_WIDTH;

// up, right, down, left
// N ,  E  ,   S  , W
const direction = {
    "|" : [1, 0, 1, 0],
    "-" : [0, 1, 0, 1],
    "L" : [1, 1, 0, 0],
    "J" : [1, 0, 0, 1],
    "7" : [0, 0, 1, 1],
    "F" : [0, 1, 1, 0],
    "S" : [1, 1, 1, 1],
    "." : [0, 0, 0, 0]
}


function canConnect(pipe1, pipe2, postition) {
    if(postition < 0 || postition > 4) return false

    const pipe1Direction = direction[pipe1]
    const pipe2Direction = direction[pipe2]

    if(pipe1Direction[postition] === 0) return true

    let relatedPosition = postition - 2
    if(relatedPosition < 0) {
        relatedPosition = 4 - Math.abs(relatedPosition)
    }

    return pipe2Direction[relatedPosition] === pipe1Direction[postition]
}


function Node(x,y,label){
    this.x = x;
    this.y = y;
    this.label = label;
    this.color = 'black';
    this.value = 0;
    this.memo = {...this}
}

const canvas = document.getElementById('game');
const ctx = canvas.getContext('2d');

canvas.width = width;
canvas.height = height;

function init() {
    r = input.split('\n')
    for (let y = 0; y < r.length; y++) {
        let col = r[y].split('')
        let tmp = [];
        for (let x = 0; x < col.length; x++) {
            let char = col[x];
            n = new Node(x,y, char)
            n.color = char === 'S' ? 'red' : 'black'
            tmp.push(n)

            if(char === 'S')
            {
                targetS = n
            }
        }

        dataSet.push(tmp)
    }
}

function loop() {
    ctx.clearRect(0, 0, height, width)

    for (let y = 0; y < dataSet.length; y++) {
        let col = dataSet[y]
        for (let x = 0; x < col.length; x++) {
            let n = col[x];
            let char = n.label
            let xPos = n.x * fontSize;
            let yPos = n.y * fontSize + fontSize;
            ctx.fillStyle = n.color
            ctx.fillText(char, xPos, yPos);
        }
    }
}

init()
loop()
DATASET_HIGHT = dataSet.length
DATASET_WIDTH = dataSet[0].length

let frame;
function start() {
    frame = setInterval(() => {
        loop();
    }, 500);
}

function stop() {
    clearInterval(frame)
}

start();
let stack = [];

function transLocation(x, y,direct){
    if(direct == 0) return [x, y - 1];
    if(direct == 1) return [x + 1, y];
    if(direct == 2) return [x, y + 1];
    if(direct == 3) return [x - 1, y];
}

function isOverLine(x,y) {
    return x < DATASET_WIDTH && y <  DATASET_HIGHT && x >= 0 && y >= 0;
}

function scan(node) {
    markList.push(node)

    let arrDirection  = direction[node.label] || [];
    arrDirection.map((connect, d) => {
        let targetPos = transLocation(node.x, node.y, d);
        if(isOverLine(targetPos[0], targetPos[1])) {

            let targetNode = dataSet[targetPos[1]][targetPos[0]]
            if(connect === 1) {
                if(targetNode !== undefined) {
                    if(canConnect(node.label, targetNode.label, d)){
                        stack.push(targetNode)
                        targetNode.value = node.value + 1;
                    }
                }
            }else {
                excludeList.push(targetNode)
            }
        }
    })
}


scan(targetS)
while(true)
{
    let node = stack.pop();

    if(node == targetS) break;

    if(!markList.includes(node))
    {
        // node.color = 'yellow'
        scan(node);
    }
    if(stack.length == 0) break;
}

markList.map(node => {
    node.color = 'blue'
})

console.log(stack)
console.log(markList)
console.log("Longest node length in loop: " + markList.length / 2)

// excludeList = excludeList.filter(node => !markList.includes(node))
// excludeList.map(node => {
//     node.color = 'red'
// })
