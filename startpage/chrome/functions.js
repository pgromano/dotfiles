function clock() {
    var date = new Date();

    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var ampm = hours >= 12 ? 'PM' : 'AM'

    // modulo for hour 12 needs to be shifted to 12 
    // otherwise, the results should be as is
    hours = hours % 12 === 0 ? 12 : hours % 12

    // cast the timestamps to zero-padded strings
    hours = ('0' + hours).slice(-2);
    minutes = ('0' + minutes).slice(-2);
    seconds = ('0' + seconds).slice(-2);

    // pretty printing is the thing to do!
    let timestr = hours + ":" + minutes + " " + ampm;
    document.getElementById("clock").innerHTML = timestr
    setTimeout(clock, 500);
}

clock();
