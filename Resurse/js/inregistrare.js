 window.onload= function(){
    var formular=document.getElementById("form_inreg");
    if(formular){
    formular.onsubmit= function(){
            if(document.getElementById("parl").value!=document.getElementById("rparl").value){
                alert("Not the same input for \"Password\" and \"Confirm password\".");
                return false;
            }
            return true;
        }
    }
 }