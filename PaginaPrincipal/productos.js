function ClickCamposAvanzados() {
    const check = document.getElementById("checkAvanzado");

    const campos = document.getElementById("camposAvanzados");

if(check.checked){
        campos.hidden = false;
    }else{
        campos.hidden = true;
    }

}