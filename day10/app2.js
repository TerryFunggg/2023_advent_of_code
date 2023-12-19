targetS.label = 'J'

let reduceList = dataSet.flat();
reduceList = reduceList.filter(node => !markList.includes(node))

function drawRay(x1, y1, x2, y2) {
    setTimeout(() => {
        ctx.strokeStyle = 'pink'

        ctx.lineWidth = 8;

        ctx.beginPath();

    ctx.moveTo(x1 * fontSize, y1 * fontSize + (fontSize / 2));
    ctx.lineTo(x2 * fontSize, y2 * fontSize + (fontSize / 2));
        ctx.stroke();

    }, 100 * x1)
}


function line() {
    node = dataSet[20][32]
    console.log(node)
    drawRay(node.x, node.y, DATASET_WIDTH, node.y)
    drawRay(node.x, 0, node.x, node.y)
}

//line()
//loop()

//console.log(node)

resultList  = [];
reduceList.forEach((node) => {

    let tmp = dataSet[node.y]
    let lastBluePoint = tmp.findLastIndex((node) => node.color == 'blue')
    if(lastBluePoint >= 0)
    {
        drawRay(node.x, node.y, lastBluePoint, node.y)
        drawRay(node.x, 0, node.x, node.y)
        tmp = tmp.slice(node.x, lastBluePoint + 1)
        tmp.shift()

        tmp = tmp
            .filter(node => node.color == 'blue')
            .filter((node) => node.label != '-')
            .filter((node) => node.label != '.')
            .reduce((acc, node)  => acc  + `${node.label}`
                    ,"")
        if(tmp && tmp.length > 0){
            let match = tmp.match(/(FJ)|(L7)|(\|)/g)
            //console.log(tmp)
            //console.log(match)
            if(match && match.length % 2 != 0) {
                resultList.push(node)
            }
        }
    }
})

resultList.map(node => {
    node.color = 'green'
})

//loop()
console.log("Reuslt: " + resultList);
