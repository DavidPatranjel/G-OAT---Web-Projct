window.onload = function(){
    console.log(window.location.href);
    let cookies = document.cookie;
    if(getCookie("acceptat_banner")){
        setCookie("lastPage", window.location.href, 50000)
    }
}