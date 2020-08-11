var selected;
var BRAKECHAR = "<!--BRAKECHAR-->"
document.execCommand("defaultParagraphSeparator", false, "BR");

document.addEventListener("click", function(event) {
    // slect(document.getSelection().focusNode.parentElement);
});

document.addEventListener("keydown", function(event) {
    // console.log(event.code);
    if (event.code == "Enter") {
        //console.log("event.code");
        if (selected.length == 1) {
            selected[0].split();
        }
    }
    if (event.code == "Escape") {
        for (i = 0; i < selected.length; i++) {
            selected[i].deselect();
        }
        selected = new Array();
    }

});

document.addEventListener("keyup", function(event) {
    // slect(document.getSelection().focusNode.parentElement);

});

document.addEventListener('click', e => {
    // console.log(e.target.text);
    // console.log('Caret at: ', e.target.text.selectionStart);
    // var sel = document.getSelection();
    // sel is a string in Firefox and Opera, 
    // and a selectionRange object in Google Chrome, Safari and IE from version 9
    // the alert method displays the result of the toString method of the passed object
    // console.log(sel.collapse(content.firstChild, 3));
});

function formatDoc(sCmd, sValue) {
    document.execCommand(sCmd, false, sValue);
    //page.focus();
}

function setStyle(s) {
    for (i = 0; i < selected.length; i++) {
        selected[i].setStyle(s);
    }
    console.log("Style updated for " + selected.length + " boxers");
}

function setDisplay(d) {
    for (i = 0; i < selected.length; i++) {
        selected[i].setDisplay(d);
    }
    console.log("Display updated for " + selected.length + " boxers");
}

function swapStyleSheet(sheet) {
    document.getElementById("pagestyle").setAttribute("href", "file:///home/edward/Documents/SandBox/gtk-hello/css/" + sheet);
    //document.getElementById("pagestyle").innerHTML = sheet;
}
var selected = new Array();

function select(e) {
    if (e) {
        if (event.shiftKey) {
            selected.push(e);
            e.select();
        } else {
            for (i = 0; i < selected.length; i++) {
                selected[i].deselect();
            }
            selected = new Array();
            selected.push(e);
            e.select();
        }

    }
}

function desel() {

    var toRemove = [].slice.call(document.getElementsByClassName("sel"));

    toRemove.slice();
    var len = toRemove.length;

    var i;
    for (i = 0; i < len; i++) {
        toRemove[i].classList.remove("sel");
        console.log(toRemove[i]);
    }
}

var handleClick = function(event) {
    // event.target.div.setAttribute('contenteditable', 'false');
    select(event.target);
    //console.log(event.target);
    // sel(event.target)
};

class GlyphBox extends HTMLElement {

    constructor() {
        super();

        this.displayClass = 'glyph-block';
        this.styleClass = 'glyph-p';


        var shadow = this.attachShadow({
            mode: 'closed'
        });

        this.localStyle = document.createElement('style');
        this.localStyle.textContent = `
                    br {
                        display: none;
                    }
                    div{
                        outline: 0;
                    }
                `;

        this.text = document.createElement('div');
        this.text.setAttribute('contenteditable', 'true');

        shadow.appendChild(this.localStyle);
        shadow.appendChild(this.text);

        this.loadText("The most common tasks within unsupervised learning are clustering, representation learning, and density estimation. In all of these cases, we wish to learn the inherent structure of our data without using explicitly-provided labels.");


        // this.setStyle(Math.random());

        this.addEventListener('click', handleClick);

        // this.addEventListener('select', handleClick);
    }

    connectedCallback() {
        this.setStyle();
        console.log(this.displayClass + ' ' + this.styleClass + ' glyph-box added to page.');
        // this.innerHTML = "hi";
        // console.log(this.innerHTML);
    }

    loadText(t) {
        this.text.innerHTML = t;
    }

    setStyle(style = null) {
        if (style) {
            this.styleClass = style;
            this.setAttribute('class', this.displayClass + ' ' + this.styleClass + ' selected')
        } else {
            this.setAttribute('class', this.displayClass + ' ' + this.styleClass);
        }
    }

    setDisplay(display = null) {
        if (display) {
            this.displayClass = display;
            this.setAttribute('class', this.displayClass + ' ' + this.styleClass + ' selected')
        } else {
            this.setAttribute('class', this.displayClass + ' ' + this.styleClass);
        }
    }

    select() {
        this.classList.add('selected');
    }
    deselect() {
        this.classList.remove('selected');
    }
    split() {

        document.execCommand("insertHTML", false, BRAKECHAR);
        var content = this.text.innerHTML.split(BRAKECHAR);
        this.text.innerHTML = content[1];

        var newBox = document.createElement("glyph-box");
        newBox.setStyle(this.styleClass);
        newBox.setDisplay(this.displayClass);
        console.log(this.text.selectionStart);

        newBox.loadText(content[0]);

        this.parentNode.insertBefore(newBox, this);

        var range = document.createRange();
        var sel = window.getSelection();
        range.setStart(this.text, 0);
        range.collapse(true);
        sel.removeAllRanges();
        sel.addRange(range);

        console.log(this.text.innerHTML);
        this.text.innerHTML = this.text.innerHTML.replace(/(\r\n|\n|\r)/gm, "");
        // newBox.focus();
    }


}
customElements.define('glyph-box', GlyphBox);