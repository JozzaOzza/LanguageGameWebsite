const numbers = [1, 2, 3, 4, 5]
numbers.filter

// trying to make a function which randoomly selects from a list
// the only condition is that it cannot choose an element which it has chosen before
// current thought is to choose a random element, then remove it

function selectRandom(list) {
    let selected = Math.floor(Math.random() * list.length)
    console.log(list[selected])
    list.filter(index => index != selected)
}
