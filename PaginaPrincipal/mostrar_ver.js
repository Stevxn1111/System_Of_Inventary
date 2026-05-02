function mostrarMenu(event){

    let menu = document.getElementById("menuOpciones");

    if(menu.style.display == "block"){
        menu.style.display = "none";
    }else{
        menu.style.display = "block";

        menu.style.left = event.pageX + "px";

        menu.style.top = event.pageY + "px";
    }
}

document.addEventListener("click", function(event){

    let menu = document.getElementById("menuOpciones");

    let boton = event.target.closest("button");

    if(!boton || boton.innerText != "Ver"){
        menu.style.display = "none";
    }

});
function eliminarFactura(id){
    fetch("/eliminarFactura/" + id,{ 
        method: "DELETE"
    });
}