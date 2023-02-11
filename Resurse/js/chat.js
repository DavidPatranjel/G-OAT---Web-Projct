port = 8080;
socketUrl = "../../";
if (document.location.href.indexOf("localhost") != -1) {
    socketUrl = "http://127.0.0.1:" + port;
}
//const socket = io(socketUrl,{reconnect: true});  
socket = io();
socket.on("mesaj_nou", function (nume, culoare, mesaj) {

    var chat = document.getElementById("mesaje_chat");
    var today = new Date();
    var time = today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds();
    chat.innerHTML += `<p>[${time}]<span style='font-style: italic; font-weight: bold';> ${nume}</span>: <span style='color:${culoare}'>${mesaj}</span></p> `;


    //ca sa scrolleze la final
    chat.scrollTop = chat.scrollHeight;
});

function trimite() {
    var culoare = document.getElementById("culoare").value;
    var nume = document.getElementById("nume").value;
    var mesaj = document.getElementById("mesaj").value;
    fetch("/mesaj", {

        method: "POST",
        headers: { 'Content-Type': 'application/json' },

        mode: 'cors',
        cache: 'default',
        body: JSON.stringify({
            culoare: culoare,
            nume: nume,
            mesaj: mesaj
        })
    })


}