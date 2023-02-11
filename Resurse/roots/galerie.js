const fs=require("fs");
module.exports = function(app){
    var nrimaginiAleator;
    app.get("/gallery", function(req, res){
                let poze = [];
                let i = 0;
                let d = new Date();
                let sfert = 1+Math.floor(d.getMinutes()/15);
                for(let imag of obImagini.imagini){
                    let sfert_poza = Number(imag.sfert_ora);
                    if(sfert == sfert_poza){
                        poze.push(imag);
                        i++;
                    }
                    if(i == 10){
                        break;
                    }
                }
                var nrimagini=[3,6,9,12];
                var indiceAleator = Math.floor(Math.random()*nrimagini.length);
                //console.log(nrimaginiAleator);
                nrimaginiAleator = nrimagini[indiceAleator];
                res.render("pagini/gallery", {ip:req.ip, imagini:poze, nrimg:nrimaginiAleator});
    })
    app.get("*/galerie-animata.css",function(req,res){
        var sirScss=fs.readFileSync(__dirname+"/Resurse/scss/galerie_animata.scss").toString("utf-8");
        var culori=["red","blue","purple"];
        var indiceAleator = Math.floor(Math.random()*culori.length);
        var culoareAleatoare = culori[indiceAleator];
        //console.log(nrimaginiAleator);
        rezScss = ejs.render(sirScss,{culoare:culoareAleatoare, nrimagini:nrimaginiAleator});
        ///console.log(rezScss);
        var caleScss = __dirname+"/temp/galerie_animata.scss";
        fs.writeFileSync(caleScss, rezScss);
        try{
            rezCompilare=sass.compile(caleScss,{sourceMap:true});
            var caleCss = __dirname+"/temp/galerie_animata.css";
            fs.writeFileSync(caleCss,rezCompilare.css);
            res.setHeader("Content-Type","text/css");
            res.sendFile(caleCss);
        }
        catch(err){
            console.log(err);
            res.send("Eroare");
        }
    });
};