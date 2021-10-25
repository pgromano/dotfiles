function clock() {
    var date = new Date();

    var hours = date.getHours();
    var minutes = date.getMinutes();
    var seconds = date.getSeconds();
    var ampm = hours > 12 ? 'PM' : 'AM'

    hours = ('0' + hours % 12).slice(-2);
    minutes = ('0' + minutes).slice(-2);
    seconds = ('0' + seconds).slice(-2);

    let timestr = hours + ":" + minutes + " " + ampm;
    document.getElementById("clock").innerHTML = timestr
    setTimeout(clock, 500);
}

function runSearch() {
    let query = document.getElementById('searchBar').innerText
    console.log(query)
    window.location.href = "https://www.google.com/search/?q=" + query
}

clock();
