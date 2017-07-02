import './main.css'
const Elm = require('./App.elm')
const icons = {
  pencil1: require("./assets/nova/SVG/Line icons/01-Content-Edition/pencil-1.svg").default
}

const root = document.getElementById('root');

Elm.App.embed(root, {icons})
