window.addEventListener("load", function(){
    document.getElementById("btn_tema").onclick=function(){
        var tema = localStorage.getItem("tema");
        if(tema){
            localStorage.removeItem("tema");
            if(tema == "dark"){
                localStorage.setItem("tema", "halloween");
                this.classList.toggle("fa-moon");
                this.classList.toggle("fa-ghost");
                document.documentElement.classList.toggle("dark");
                document.documentElement.classList.toggle("halloween");
            }
            else{
                this.classList.toggle("fa-ghost");
                this.classList.toggle("fa-sun");
                document.documentElement.classList.toggle("halloween");
            }
        }
        else{
            localStorage.setItem("tema", "dark");
            this.classList.toggle("fa-moon")
            this.classList.toggle("fa-sun");
            document.documentElement.classList.toggle("dark");
        }
    }
});