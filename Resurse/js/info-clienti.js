class ButonCantitate extends React.Component{
  constructor(props){
    super(props)
    this.clickCantitate=this.clickCantitate.bind(this);   
    
  }

  clickCantitate(){
    this.props.onClick({tip:this.props.tip,nume: this.props.numeIngredient, semn:this.props.semn});
  }


  render(){
    return React.createElement("button",{onClick:this.clickCantitate},`${this.props.semn} ${this.props.ingredient.cantitate}${this.props.ingredient.unitate}`)
  }
}

class ButonNull extends React.Component{
  constructor(props){
    super(props)
    this.clickCantitate=this.clickCantitate.bind(this);   
    
  }

  clickCantitate(){
    this.props.onClick({tip:this.props.tip,nume: this.props.numeIngredient, semn:this.props.semn});
  }


  render(){
    return React.createElement("button",{onClick:this.clickCantitate},`Delete all`)
  }
}

function rotunjeste2zecimale(nr){return Math.round(nr*100)/100}



class ListaIngrediente extends React.Component {
  constructor(props){
    super(props)
  }

  render(){
    let grupRandare=[]
    let i=0;
    for (let numeIngredient of this.props.nume_ingrediente){
      i++;
      let ingredient=this.props.specificatiiIngrediente[numeIngredient];
      let tipIngredient=this.props.vectIngrediente[this.props.tip];
      let stareIngredient=tipIngredient[numeIngredient];
      let cantitateTotalaIngredient=stareIngredient.cant*ingredient.cantitate
      grupRandare.push(React.createElement("div",{key:"d"+i, className:"panouIngredient"},[
        React.createElement("span",{className:"nume-ingredient",key:"nume-ingr"+i},numeIngredient),
        React.createElement(ButonCantitate, {
          semn:'+', 
          key:"adauga"+i, 
          ingredient:ingredient,
          tip:this.props.tip,
          numeIngredient:numeIngredient,
          onClick:this.props.onClick}),
        React.createElement(ButonCantitate, {
          semn:'-', 
          key:"sterge"+i, 
          ingredient:ingredient, 
          tip:this.props.tip,
          numeIngredient:numeIngredient,
          onClick:this.props.onClick}),
        React.createElement(ButonNull, {
          semn:'*', 
          key:"null"+i, 
          ingredient:ingredient, 
          tip:this.props.tip,
          numeIngredient:numeIngredient,
          onClick:this.props.onClick}),
         React.createElement("span",{className:"rezultat",key:"rez"+i},
                    ` Quantity: ${cantitateTotalaIngredient}${ingredient.unitate} Calories:${rotunjeste2zecimale(stareIngredient.cant*ingredient.calorii)}`),
      
      ]));
    }
    return grupRandare;
  }
}

class GrupIngrediente extends React.Component {
  constructor(props){
    super(props)
    this.state={}
    this.vectIngrediente={}
    this.onClick=this.onClick.bind(this);
    //construiesc starea de cantitati selectate
    let grIngrediente=this.props.json.grup_ingrediente
    for (let i=0; i<grIngrediente.length;i++){
      this.vectIngrediente[grIngrediente[i].tip]={}
      for (let j=0;j<grIngrediente[i].nume_ingrediente.length; j++){

        let numeIngredient=grIngrediente[i].nume_ingrediente[j]
        
        this.vectIngrediente[grIngrediente[i].tip][numeIngredient]= {cant:0, calorii:0};
      }
    }
    this.totalCalorii=0;
    this.updateCantitati();
    //console.log("GrupIngrediente vectIngrediente:",this.state);
  }

  onClick(infoIngredient){
    this.updateCantitati(infoIngredient)  
    this.setState({});
  }

  updateCantitati(infoIngredient){ //infoIngredient are tipul de numele cantitatea si semnul pentru update
    this.totalCalorii=0
    for(let tip in this.vectIngrediente){
      for(let ingredient in this.vectIngrediente[tip]){
        console.log(ingredient);
        if(infoIngredient){
          if (tip==infoIngredient.tip && ingredient==infoIngredient.nume) {
            if(infoIngredient.semn=="+")
              this.vectIngrediente[tip][ingredient].cant++;
            else if(infoIngredient.semn=="*")
              this.vectIngrediente[tip][ingredient].cant = 0;
            else
              if(this.vectIngrediente[tip][ingredient].cant>0)
                this.vectIngrediente[tip][ingredient].cant--;
          }
        }
        this.totalCalorii+=this.vectIngrediente[tip][ingredient].cant*this.props.json.ingrediente[ingredient].calorii;
        
      }

    }
  }
 

  render(){
    let i=0;
    let rez=[];
    for (let gr of this.props.json.grup_ingrediente){
      i++;
      
      rez.push(React.createElement("p",{className:"titlu-grup-ingrediente", key:"titlu"+i},gr.tip),
        React.createElement(ListaIngrediente,{
          tip:gr.tip,
          nume_ingrediente:gr.nume_ingrediente, 
          key:"lista"+i, 
          onClick:this.onClick,
          specificatiiIngrediente:this.props.json.ingrediente,
          vectIngrediente:this.vectIngrediente})
      )
    }
    rez.push(React.createElement("p",null,`Total number of calories: ${this.totalCalorii}`))
    if(this.totalCalorii > 300){
      rez.push(React.createElement("p",null,`Watch out, there are too many calories in your recipe! 300kcals are more than enough!`))
    }
  return rez;
  }
}



window.addEventListener("load", function(){
  fetch("/Resurse/json/ingrediente.json",
  {
    method:"GET",
    headers: {"Content-Type":"application/json"},
    cache:"default",
    mode:"cors"
  })
  .then(function(raspuns){ return raspuns.json()})
  .then(function(obIngrediente){
    let radReact=ReactDOM.createRoot(document.getElementById("creare-prajitura"));
    radReact.render(React.createElement(GrupIngrediente,{json:obIngrediente}))
  })
})



class ComponentaSimpla2 extends React.Component {
  constructor(props){
    super(props);
    this.exempluClick2=this.exempluClick2.bind(this);

  }

  exempluClick2(){
    console.log(this.props)
    this.props.exempluClick();
  }

  render(){
    console.log(this.props);
    return React.createElement("b",{onClick:this.exempluClick2}, `Change clock!`);
  }
}

class ComponentaSimpla extends React.Component {
  constructor(props){
    super(props);
    this.state={data: new Date()}
    this.exempluClick=this.exempluClick.bind(this);
  }

  exempluClick(){
    //this.setState({data: new Date()})
    this.setState({})
  }

  render(){
    var currentdate = new Date();
var datetime = "Date and time: " + currentdate.getDay() + "/" + currentdate.getMonth() 
+ "/" + currentdate.getFullYear() + "   " 
+ currentdate.getHours() + ":" 
+ currentdate.getMinutes() + ":" + currentdate.getSeconds();
    console.log(this.props);
    //return React.createElement("p",{title:"text tooltip", className:"test"}, `whatever  ${this.props.proprietate}`);
    return [React.createElement("p",
              {title:"text tooltip", onClick: this.exempluClick,className:"test"}, 
              `${this.props.proprietate} ${datetime}`),
            React.createElement(ComponentaSimpla2,
              {title:"text tooltip", exempluClick:this.exempluClick, className:"test"})];
  }
}



window.addEventListener("load", function(){

    let radReact=ReactDOM.createRoot(document.getElementById("exemplu-curs"));
    radReact.render(React.createElement(ComponentaSimpla,{proprietate:"", a:10, b:20}));
  
})