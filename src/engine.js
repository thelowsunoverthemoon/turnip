/* turnip Variables */
var inser = document.getElementById("Anchor");
var fso = new ActiveXObject("Scripting.FileSystemObject");
var user = fso.GetStandardStream(0).ReadLine().split(";");

/* Set up */
if (user[0] == "") {
    user[0] = "#FFFFFF";
}

if (user[1] == "") {
    user[1] = 500;
}

if (user[2] == "") {
    user[2] = 500;
}
if (user[3] == "") {
    user[3] = 0;
}
if (user[4] == "") {
    user[4] = 0;
}
if (user[5] == "") {
    user[5] = 10;
}

document.getElementById("Anchor").style.background = user[0];
window.resizeTo(user[1], user[2]);
window.moveTo(user[3], user[4]);

var image = [];
if (user[10] != "") {
    setImage(altInput(user[10]));
}

var sprite = [];
if (user[11] != "") {
    setSprite(altInput(user[11]));
}
if (user[6] != "") {
    makeScene(altInput(user[6]));
}

var arr = [];
var sprInd = [];
var idInd = [];
if (user[7] != "") {
    makeSprite(altInput(user[7]));
}

var arrLen = arr.length;
var musInd = [];
if (user[8] != "") {
    makeMusic(altInput(user[8]));
}

var hoveInd = [];
if (user[9] != "") {
    makeInter(altInput(user[9]));
}


/* Input */
document.onkeypress = function (e) {
    var e = e || window.event;
    msgKey(e.keyCode);
};


/* Game Loop */
var frame = 0;
var pause = 0;
var prevKey = ["0"];
var fileKey = readFile("output.txt");
if (!fileKey) {
    window.close();
}

var prevHov = ["0"];
var fileHover = readFile("mouse.txt");
if (!fileHover) {
    window.close();
}

setInterval(function () {
    if (pause == 0) {
        updSprites();
        frame++;
    }
}, user[5])

setInterval(function () {
    getOutput(fileKey, prevKey);
    getOutput2(fileHover, prevHov);
}, 10);

/* Functions */
function altInput(str) {
    return str.slice(0, -1).split("@");
}

function setImage(elem) {
    for (i = 0; i < elem.length; i++) {
        image[i] = elem[i];
    }
}

function setSprite(elem) {
    for (i = 0; i < elem.length; i++) {
        var spr = elem[i].split("#");
        sprite[i] = {
            src: spr[0],
            n: spr[1]
        };
    }
}

function makeInter(inter) {
    for (i = 0; i < inter.length; i++) {
        (function (i) {
            var elem = inter[i].split(".");
            var doc = document.getElementById("Sprite" + elem[0]);
            if (elem[1] == "C") {
                doc.onclick = function () {
                    msgMouse("C " + elem[0]);
                }
            } else {
                doc.onmouseleave = function () {
                    msgMouse("D " + elem[0]);
                    hoveInd[i] = 0;
                }
                doc.onmouseover = function () {
                    if (!hoveInd[i]) {
                        msgMouse("H " + elem[0]);
                        hoveInd[i] = 1;
                    }
                }
            }
        })(i)
    }
}

function updSprites() {
    var msg = "";
    for (i = 0; i < arrLen; i++) {
        if (!(frame % arr[i].eve)) {
            var spr = idInd[arr[i].ind];
            spr.style.backgroundPosition = "-" + (arr[i].w * arr[i].cur) + "px 0";
            if (arr[i].cur == arr[i].max) {
                arr[i].cur = 1;
                if (arr[i].onr == 1) {
                    msg += arr[i].ind + ",";
                }
            } else {
                arr[i].cur += 1;
            }
        }
    }
    if (msg != "") {
        msgAnim(msg);
    }
}

function getOutput(file, prev) {
    var line;
    while (!file.AtEndOfStream) {
        line = file.ReadLine();
    }
    if (line != null) {
        var chk = line.split("@");
        if (!(prev[0] == chk[0])) {
            var chl = chk.length;
            for (var k = 1; k < chl; k++) {
                var elem = chk[k].split(";");
                elem[0] = elem[0].slice(1);
                switch (elem[0]) {
                case "~":
                    editMusic(elem);
                    break;
                case "*":
                    makeSound(elem);
                    break;
                case "S":
                    window.close();
                    break;
                case "P":
                    pause = 1;
                    break;
                case "U":
                    pause = 0;
                    break;
                default:
                    editSprite(elem);
                    break;
                }
            }
            prev[0] = chk[0];
        }
    }
}

function getOutput2(file, prev) {
    var line;
    while (!file.AtEndOfStream) {
        line = file.ReadLine();
        var chk = line.split("@");
        if (!(prev[0] == chk[0])) {
            var chl = chk.length;
            for (var k = 1; k < chl; k++) {
                var elem = chk[k].split(";");
                elem[0] = elem[0].slice(1);

                switch (elem[0]) {
                case "~":
                    editMusic(elem);
                    break;
                case "*":
                    makeSound(elem);
                    break;
                case "S":
                    window.close();
                    break;
                case "P":
                    pause = 1;
                    break;
                case "U":
                    pause = 0;
                    break;
                default:
                    editSprite(elem);
                    break;
                }
            }
            prev[0] = chk[0];
        }
    }
}

function makeSound(elem) {
    var mus = new Audio(elem[1]);
    mus.play();
}

function editMusic(elem) {
    var mus = musInd[elem[1]];
    if (elem[2] == "0") {
        mus.play();
    } else if (elem[2] == "1") {
        mus.pause();
    } else {
        mus.pause();
        mus.currentTime = 0;
        mus.play();
    }
}


function editSprite(elem) {
    var doc = idInd[elem[0]].style;
    var len = elem.length;

    for (k = 1; k < len; k++) {
        var det = elem[k].split("$");
        switch (det[0]) {
        case "x":
            doc.left = det[1] + "px";
            break;
        case "y":
            doc.top = det[1] + "px";
            break;
        case "w":
            doc.width = det[1] + "px";
            break;
        case "h":
            doc.height = det[1] + "px";
            break;
        case "t":
            doc.msTransform = det[1];
            break;
        case "b":
            doc.backgroundColor = det[1];
            break;
        case "r":
            doc.borderRadius = det[1] + "px";
            break;
        case "s":
            doc.display = "none";

            doc.backgroundImage = "url('" + sprite[det[1]].src + "')";
            doc.backgroundSize = (det[2] * sprite[det[1]].n) + "px " + det[3] + "px";

            var num = sprInd[elem[0]];
            arr[num] = {
                max: sprite[det[1]].n - 1,
                cur: arr[num].cur > sprite[det[1]].n ? 0 : det[6] == 0 ? arr[num].cur : 0,
                w: det[2],
                eve: det[4],
                ind: arr[num].ind,
                onr: det[5]
            }

            doc.display = "block";
            break;
        case "f":
            doc.color = det[1];
            doc.fontSize = det[2] + "px";
            doc.textAlign = det[3];
            doc.fontFamily = det[4];
            idInd[elem[0]].getElementsByClassName("text")[0].innerHTML = det[5].replace(/`/g, "!").replace(/#/g, "&").replace(/~/g, "?"); // maybe change later
            break;
        }
    }
}

function readFile(file) {
    try {
        handle = fso.OpenTextFile(file, 1);
        return handle;
    } catch (err) {
        return null;
    }
}

function makeScene(bkg) {
    for (var i = 0; i < bkg.length; i++) {
        var det = bkg[i].split("$");
        var img = makeElement();

        img.className = "image";
        img.id = "Image" + i;
        img.style.backgroundImage = "url('" + image[det[0]] + "')";
        img.style.backgroundSize = det[4] + "px " + det[5] + "px";
        img.style.backgroundRepeat = "no-repeat";

        img.style.left = det[1] + "px";
        img.style.top = det[2] + "px";
        img.style.zIndex = String(det[3]);
        img.style.width = det[4] + "px";
        img.style.height = det[5] + "px";
    }
}

function makeMusic(music) {
    for (var i = 0; i < music.length; i++) {
        var det = music[i].split("#");
        var mus = new Audio(det[0]);
        mus.loop = "true";
        if (det[1] == 1) {
            mus.play();
        }

        musInd.push(mus);
    }
}

function makeSprite(spr) {
    for (var i = 0; i < spr.length; i++) {
        var det = spr[i].split("$");
        var img = det[8] == null ? makeElement() : makeText(det[8], det[13]);

        img.className = "sprite";
        img.id = "Sprite" + i;

        idInd.push(img);
        if (det[0] == "~") {
            img.style.backgroundColor = det[4];
            img.style.borderRadius = det[7] + "px";

            if (det[8] != null) {
                img.style.color = det[10];
                img.style.fontSize = det[9] + "px";
                img.style.textAlign = det[11];
                img.style.fontFamily = det[12];
            }
        } else {
            img.style.backgroundImage = "url('" + sprite[det[0]].src + "')";
            img.style.backgroundSize = (det[5] * sprite[det[0]].n) + "px " + det[6] + "px";
            sprInd[i] = arr.length;
            arr.push({
                max: sprite[det[0]].n - 1,
                cur: 1,
                w: det[5],
                eve: det[4],
                ind: i,
                onr: det[7]
            });
        }
        img.style.left = det[1] + "px";
        img.style.top = det[2] + "px";
        img.style.zIndex = String(det[3]);
        img.style.width = det[5] + "px";
        img.style.height = det[6] + "px";
    }
}

function makeElement() {
    var img = document.createElement("div");
    var inser = document.getElementById("Anchor");
    inser.parentNode.insertBefore(img, inser);
    return img
}

function makeText(text, pad) {
    var img = document.createElement("div");
    var inser = document.getElementById("Anchor");

    var p = document.createElement("div");
    p.className = "text";
    p.innerHTML = text.replace(/`/g, "!").replace(/#/g, "&").replace(/~/g, "?");
    p.style.padding = pad + "px";

    img.appendChild(p);

    inser.parentNode.insertBefore(img, inser);
    return img
}

function msgKey(reply) {
    msgKey.chk = msgKey.chk * -1 || 1;

    if (msgKey.prev != null) {
        fso.DeleteFile(msgKey.prev);
    }

    msgKey.prev = reply + "." + msgKey.chk;
    fso.CopyFile("input.txt", msgKey.prev);
}

function msgMouse(reply) {
    msgMouse.chk = msgMouse.chk * -1 || 2;

    if (msgMouse.prev != null) {
        fso.DeleteFile(msgMouse.prev);
    }

    msgMouse.prev = reply + "." + msgMouse.chk;

    fso.CopyFile("input.txt", msgMouse.prev);
}

function msgAnim(reply) {
    msgAnim.chk = msgAnim.chk * -1 || 3;
    if (msgAnim.prev != null) {
        fso.DeleteFile(msgAnim.prev);
    }

    msgAnim.prev = reply + "." + msgAnim.chk;

    fso.CopyFile("input.txt", msgAnim.prev);
}