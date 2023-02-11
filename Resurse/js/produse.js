window.addEventListener("load", function(){

    ///viitoare elem din local storage
    let iduriCos = localStorage.getItem("cos_virtual");
    if(iduriCos){
        iduriCos = iduriCos.split(",");
    }else{
        iduriCos = [];
    }
    for(let id_p of iduriCos){
        var ch = document.querySelector(`[value='${id_p}'].select-cos`);
        if(ch){
            ch.checked = true;
        }
    }


    document.getElementById("inp-pretmin").onchange = function(){
        document.getElementById("infoRangeMin").innerHTML = "(" + this.value + ")";
    }
    document.getElementById("inp-pretmax").onchange = function(){
        document.getElementById("infoRangeMax").innerHTML = "(" + this.value + ")";
    }

    document.getElementById("filtrare").onclick = function(){
        var valNume = document.getElementById("inp-nume").value.toLowerCase();
        let ok = 0;
        if(valNume.includes("*")){
            var start, sfarsit;
            [start, sfarsit] = valNume.split("*");
            ok = 1
        }
        var butoaneRadio = document.getElementsByName("gr_rad");
        for(let rad of butoaneRadio){
            if(rad.checked){
                var valCalorii = rad.value;
                break;
            }
        }
        if(valCalorii!='toate'){
            var minCalorii,maxCalorii;
            [minCalorii,maxCalorii] = valCalorii.split(":");
            minCalorii = parseInt(minCalorii);
            maxCalorii = parseInt(maxCalorii);
        }
        else{
            minCalorii = 0;
            maxCalorii = 9999999;
        }

        var valPretMin = document.getElementById("inp-pretmin").value;
        var valPretMax = document.getElementById("inp-pretmax").value;
        var valCateg = document.getElementById("inp-categorie").value;
        var valSugar = document.getElementById("inp-sugar");
        var valTextAera = document.getElementById("inp-textarea").value.toLowerCase();
        var optiuni=document.getElementById("inp-milk").options;	
		var valMultiplu = [];
        var existalapte = 0;
		for(let opt of optiuni){
			if(opt.selected){
                existalapte = 1;
				valMultiplu.push(opt.value);
            }
		}
        var valDataList = document.getElementById("inp-ingredient").value;

        var articole = document.getElementsByClassName("produs");
        for(let art of articole){
            art.style.display="none";
            let numeArt = art.getElementsByClassName("val-nume")[0].innerHTML.toLowerCase();
            let caloriiArt = parseInt(art.getElementsByClassName("val-calorii")[0].innerHTML);
            let pretArt = parseFloat(art.getElementsByClassName("val-pret")[0].innerHTML);
            let categArt = art.getElementsByClassName("val-categorie")[0].innerHTML;
            let sugarArt = art.getElementsByClassName("val-sugar")[0].innerHTML;
            let descriereArt = art.getElementsByClassName("val-descriere")[0].innerHTML.toLowerCase();
            let milkArt = art.getElementsByClassName("val-milk")[0].innerHTML.toLowerCase();
            let ingredienteArt = art.getElementsByClassName("val-ingredients")[0].innerHTML.split(",");
            console.log(ingredienteArt);

            let conditie1 = (numeArt.startsWith(valNume) && ok == 0) || (ok == 1 && numeArt.startsWith(start) && numeArt.endsWith(sfarsit));
            let conditie2 = (minCalorii <= caloriiArt && caloriiArt <= maxCalorii);
            let conditie3 = (valPretMin <= pretArt);
            let conditie4 = (valPretMax >= pretArt);
            let conditie5 = (valCateg == categArt  || valCateg == "toate");
            let conditie6 = (valSugar.checked && sugarArt == "false") || !valSugar.checked;
            let conditie7 = descriereArt.includes(valTextAera);
            let conditie8 = (valMultiplu.includes(milkArt) && existalapte) || !existalapte;
            let conditie9 = ingredienteArt.includes(valDataList) || !valDataList;
            let conditieFinala = conditie1 && conditie2 && conditie3  && conditie4 && conditie5 && conditie6 && conditie7 && conditie8 && conditie9;
            let d = document.createElement("p")
            d.innerHTML = valSugar + sugarArt;
            if(conditieFinala){
                art.style.display="block";
            }
        }
    }
    document.getElementById("resetare").onclick = function(){
        var articole = document.getElementsByClassName("produs");
        for(let art of articole){
            art.style.display="block";
        }
        document.getElementById("inp-nume").value="";
        document.getElementById("i_rad4").checked=true;
        document.getElementById("inp-pretmin").value = 0;
        document.getElementById("inp-pretmax").value = 300;
        document.getElementById("infoRangeMin").innerHTML = "(" + 0 + ")";
        document.getElementById("infoRangeMax").innerHTML = "(" + 300 + ")";
        document.getElementById("inp-sugar").checked=false;
        document.getElementById("sel-toate").selected = true;
        document.getElementById("inp-textarea").value="";
        document.getElementById("inp-ingredient").value="";
        var optiuni=document.getElementById("inp-milk").options;		
		for(let opt of optiuni){
			opt.selected = false;
		}
    }

    function sortare(semn){
        var articole=document.getElementsByClassName("produs");
        var v_articole=Array.from(articole)
        v_articole.sort(function(a,b){
            let pret_a=parseFloat(a.getElementsByClassName("val-pret")[0].innerHTML);
            let pret_b=parseFloat(b.getElementsByClassName("val-pret")[0].innerHTML);
            if(pret_a!=pret_b)
                return semn*(pret_a-pret_b);
            else{
                let nume_a = a.getElementsByClassName("val-nume")[0].innerHTML;
                let nume_b = b.getElementsByClassName("val-nume")[0].innerHTML;
                return semn*nume_a.localeCompare(nume_b);
            }
        })
        for(let art of v_articole){
            art.parentElement.appendChild(art);
        }
    }

    document.getElementById("sortCrescNume").onclick = function(){
        sortare(1);
    }
    document.getElementById("sortDescrescNume").onclick = function(){
        sortare(-1);
    }
    /*
    window.onkeydown=function(e){
        if(e.key == "c" && e.altKey == true){
            let p_vechi = document.getElementById("afis_suma");
            if(!p_vechi){
                let p = document.createElement("p");
                p.id = "afis_suma";
                let suma = 0;
                var articole=document.getElementsByClassName("produs");
            
                for(let art of articole){
                    if(art.style.display != "none")
                        suma += parseFloat(art.getElementsByClassName("val-pret")[0].innerHTML);
                }
                p.innerHTML = "<b> Suma: </b>" + suma;
                var sectiune = document.getElementById("produse");
                sectiune.parentNode.insertBefore(p, sectiune);

                setTimeout(function(){
                    let p_vechi = document.getElementById("afis_suma");            
                    if(p_vechi){
                        p_vechi.remove();
                    }
                }, 2000)
            }
        }
    }*/

    document.getElementById("p-suma").onclick = function(){
        let p_vechi = document.getElementById("afis_suma");
            if(!p_vechi){
                let p = document.createElement("p");
                p.id = "afis_suma";
                let suma = 0;
                var articole=document.getElementsByClassName("produs");
            
                for(let art of articole){
                    if(art.style.display != "none")
                        suma += parseFloat(art.getElementsByClassName("val-pret")[0].innerHTML);
                }
                p.innerHTML = "<b> Suma: </b>" + suma;
                var sectiune = document.getElementById("produse");
                sectiune.parentNode.insertBefore(p, sectiune);

                setTimeout(function(){
                    let p_vechi = document.getElementById("afis_suma");            
                    if(p_vechi){
                        p_vechi.remove();
                    }
                }, 2000)
            }
    }

    var checkboxuri = document.getElementsByClassName("select-cos");
    for(let ch of checkboxuri){
        ch.onchange = function(){
            if(this.checked){
                let iduriCos = localStorage.getItem("cos_virtual");
                ///hint cantitate 3/20
                if(iduriCos){
                    iduriCos = iduriCos.split(",");
                }else{
                    iduriCos = [];
                }
                iduriCos.push(this.value);
                localStorage.setItem("cos_virtual", iduriCos.join(","));
            }else{
                let iduriCos = localStorage.getItem("cos_virtual");
                if(iduriCos){
                    iduriCos = iduriCos.split(",");
                    for(let i of iduriCos){
                        if(i == this.value){
                            var index = iduriCos.indexOf(i);
                            if (index !== -1) {
                                iduriCos.splice(index, 1);
                            }
                        }
                    }
                }
                localStorage.setItem("cos_virtual", iduriCos.join(","));
            }
        }
    }

});