// pequeños scripts y validaciones


function Inicio() {

//    ponerTitulo();
    
    // ponerTitulo no funciona en IE

    usuario = null;

    setFocusUsuario();

}

function despedida(user) {

    var labelbye = document.getElementById("ctl00_lblCustomer");

    labelbye.style.display = 'none';

    labelbye.style.visibility = 'visible';

    labelbye.innerHTML = 'A hui hou ' + user;

    $("#ctl00_lblCustomer").slideToggle("slow");

    usuario = null;    

    setFocusUsuario();
}

function sessionOut() {

    var labelbye = document.getElementById("ctl00_lblCustomer");

    labelbye.style.display = 'none';

    labelbye.style.visibility = 'visible';

    labelbye.innerHTML = 'Mauka session';

    $("#ctl00_lblCustomer").slideToggle("slow");

    usuario = null;

    setFocusUsuario();
}




function irAmicarpetaCli() {

    window.location = "zonacli.aspx";
}

function irAmicarpetaPro() {

    window.location = "zonapro.aspx";
}

function irAinicio() {

    window.location = "inicio.aspx?desconexion=1";
}

function mostrarMenu() {

    document.getElementById("divmenu").style.visibility = "visible";
    
}


function setFocusUsuario() {

    document.getElementById("ctl00_BodyPlace_txtUsuario").focus();

}


function ValidarUsers() {

    var validos = true;
    
    var txtUser = document.getElementById("ctl00_BodyPlace_txtPwd").value;
    var txtPwd = document.getElementById("ctl00_BodyPlace_txtUsuario").value;

    if ((txtUser == "") || (txtPwd == "") || (/^\s+$/.test(txtUser)) || (/^\s+$/.test(txtPwd))) {
        document.getElementById("ctl00_BodyPlace_errAcceso").innerHTML = "hala";
        validos = false;
    }
    else {
        document.getElementById("ctl00_BodyPlace_errAcceso").innerHTML = " ";
    }    

    return validos;

}


function InicioReg() {

    //ponerTitulo();
    setFocusNombre();

}


function focusDest() {

    if (document.getElementById("ctl00_BodyPlace_txtBoxDest").value == "")

        document.getElementById("ctl00_BodyPlace_txtBoxDest").focus();

    else
        document.getElementById("ctl00_BodyPlace_txtText").focus();    
}

function setFocusNombre() {

    document.getElementById("ctl00_BodyPlace_txtNombre").focus();

}

function PasarFocoACargo() {

    document.getElementById("ctl00_BodyPlace_txtCargo").focus();

}

function mostrarTipoBD() {

    var check = document.getElementById("chkbd");

    if (check.checked) {

        $("#ctl00_BodyPlace_lblTipobd").fadeIn("fast");
        $("#ctl00_BodyPlace_ddTipobd").fadeIn("fast");
    }
    else {

        $("#ctl00_BodyPlace_lblTipobd").fadeOut("fast");
        $("#ctl00_BodyPlace_ddTipobd").fadeOut("fast");
    }
}


function ValidarRegistro() { // falta validar email con expresion regular

    var validos = true;

    var txtNombre = document.getElementById("ctl00_BodyPlace_txtNombre").value;
    var txtApellidos = document.getElementById("ctl00_BodyPlace_txtApellidos").value;
    var txtEmpresa = document.getElementById("ctl00_BodyPlace_txtEmpresa").value;
    var ddSector = document.getElementById("ctl00_BodyPlace_ddSector");
    var txtCargo = document.getElementById("ctl00_BodyPlace_txtCargo").value;
    var txteMail = document.getElementById("ctl00_BodyPlace_txteMail").value;
    var txtTel = document.getElementById("ctl00_BodyPlace_txtTel").value;
    var txtNick = document.getElementById("ctl00_BodyPlace_txtNick").value;
    var txtClave = document.getElementById("ctl00_BodyPlace_txtClave").value;
    var txtConfirmarClave = document.getElementById("ctl00_BodyPlace_txtConfirmarClave").value;

    if ((txtNombre.length < 3) || (txtNombre.length > 40) || (/^\s+$/.test(txtNombre))) {
        document.getElementById("ctl00_BodyPlace_errNombre").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errNombre").innerHTML = " ";

    if ((txtApellidos.length < 3) || (txtApellidos.length > 40) || (/^\s+$/.test(txtApellidos))) {
        document.getElementById("ctl00_BodyPlace_errApellidos").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errApellidos").innerHTML = " ";

    if ((txtEmpresa.length == 0) || (txtEmpresa.length > 40) || (/^\s+$/.test(txtEmpresa))) {
        document.getElementById("ctl00_BodyPlace_errEmpresa").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errEmpresa").innerHTML = " ";

    if ((ddSector.selectedIndex == 0) || (ddSector.selectedIndex == null)) {
        document.getElementById("ctl00_BodyPlace_errSector").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errSector").innerHTML = " ";

    if ((txtCargo.length == 0) || (txtCargo.length > 40) || (/^\s+$/.test(txtCargo))) {
        document.getElementById("ctl00_BodyPlace_errCargo").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errCargo").innerHTML = " ";

    if ((txteMail == "") || (txteMail.length > 40)) {
        document.getElementById("ctl00_BodyPlace_erreMail").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_erreMail").innerHTML = " ";

    if ((txtTel == "") || !(/^6|9\d{8}$/.test(txtTel))) {
        document.getElementById("ctl00_BodyPlace_errTel").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errTel").innerHTML = " ";

    if ((txtNick.length == 0) || (txtNick.length > 20) || (/^\s+$/.test(txtNick))) {
        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = " ";

    if ((txtClave == "") || (txtClave.length > 20) || (txtClave.length < 4) || (/^\s+$/.test(txtClave))) {
        document.getElementById("ctl00_BodyPlace_errClave").innerHTML = "!";
        validos = false;
        if ((txtClave.length < 4) && (txtClave != "")) {
            document.getElementById("ctl00_BodyPlace_errClave").innerHTML = "hala, keiki key";
        }
    } else
        document.getElementById("ctl00_BodyPlace_errClave").innerHTML = " ";

    if (txtConfirmarClave != txtClave) {
        document.getElementById("ctl00_BodyPlace_errConfirmarClave").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errConfirmarClave").innerHTML = " ";


    return validos;

}


function ValidarRegistroPro() { // falta validar email con expresion regular

    var validos = true;

    var numchecks = document.getElementsByTagName("td").length;
    var checks = document.getElementsByTagName("td");

    var algomarcado = false;

    for (i = 0; i < numchecks; i++) {

        if (checks.item(i).innerHTML != "") {

            if (checks.item(i).firstChild.checked)
                algomarcado = true;
        }
    }

    if (!(algomarcado)) {

        document.getElementById("ctl00_BodyPlace_Label7").innerHTML = "Experiencia!";
        document.getElementById("ctl00_BodyPlace_Label7").setAttribute("style", "font-weight:bold;");
        validos = false;
    }
    else {
        document.getElementById("ctl00_BodyPlace_Label7").innerHTML = "Experiencia";
        document.getElementById("ctl00_BodyPlace_Label7").setAttribute("style", "font-weight:normal;");

    }


    var txtNombre = document.getElementById("ctl00_BodyPlace_txtNombre").value;
    var txtApellidos = document.getElementById("ctl00_BodyPlace_txtApellidos").value;
    var txteMail = document.getElementById("ctl00_BodyPlace_txteMail").value;
    var txtTel = document.getElementById("ctl00_BodyPlace_txtTel").value;
    var txtEmpresa = document.getElementById("ctl00_BodyPlace_txtEmpresa").value;
    var txtNick = document.getElementById("ctl00_BodyPlace_txtNick").value;
    var txtClave = document.getElementById("ctl00_BodyPlace_txtClave").value;
    var txtConfirmarClave = document.getElementById("ctl00_BodyPlace_txtConfirmarClave").value;

    if ((txtNombre.length < 3) || (txtNombre.length > 40) || (/^\s+$/.test(txtNombre))) {
        document.getElementById("ctl00_BodyPlace_errNombre").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errNombre").innerHTML = " ";

    if ((txtApellidos.length < 3) || (txtApellidos.length > 40) || (/^\s+$/.test(txtApellidos))) {
        document.getElementById("ctl00_BodyPlace_errApellidos").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errApellidos").innerHTML = " ";

    if ((txteMail == "") || (txteMail.length > 40)) {
        document.getElementById("ctl00_BodyPlace_erreMail").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_erreMail").innerHTML = " ";

    if ((txtTel == "") || !(/^6|9\d{8}$/.test(txtTel))) {
        document.getElementById("ctl00_BodyPlace_errTel").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errTel").innerHTML = " ";

    if ((txtEmpresa.length == 0) || (txtEmpresa.length > 40) || (/^\s+$/.test(txtEmpresa))) {
        document.getElementById("ctl00_BodyPlace_errEmpresa").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errEmpresa").innerHTML = " ";

    if ((txtNick.length == 0) || (txtNick.length > 20) || (/^\s+$/.test(txtNick))) {
        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = " ";

    if ((txtClave == "") || (txtClave.length > 20) || (txtClave.length < 4) || (/^\s+$/.test(txtClave))) {
        document.getElementById("ctl00_BodyPlace_errClave").innerHTML = "!";
        validos = false;
        if ((txtClave.length < 4) && (txtClave != "")) {
            document.getElementById("ctl00_BodyPlace_errClave").innerHTML = "hala, keiki key";
        }
    } else
        document.getElementById("ctl00_BodyPlace_errClave").innerHTML = " ";

    if (txtConfirmarClave != txtClave) {
        document.getElementById("ctl00_BodyPlace_errConfirmarClave").innerHTML = "!";
        validos = false;
    } else
        document.getElementById("ctl00_BodyPlace_errConfirmarClave").innerHTML = " ";


    return validos;

}


function permiteCaracteres(elEvento, permitidos) {

    var numeros = "0123456789";
    var caracteres = "abcdefghijklmnñopqrstuvwxyzABCDEFGHIJKLMNÑOPQRSTUVWXYZ";
    var numsycaracs = numeros + caracteres;
    var teclas_especiales = [8, 9, 32, 37, 39, 46, 45, 35, 36, 16, 222];
            // retroceso, tabulador, espacio, flecha izq / Fin, flecha dcha / Inicio, 
            // Supr, Ins, Shift, Tilde                    

    switch (permitidos) {

        case 'num':
            permitidos = numeros;
            break;
        case 'car':
            permitidos = caracteres;
            break;
        case 'numscars':
            permitidos = numsycaracs;
    }

    var evento = elEvento || window.event; 
                // selecciona el adecuado según el navegador
    var codigoCaracter = evento.charCode || evento.keyCode;
    var caracter = String.fromCharCode(codigoCaracter);

    var tecla_especial = false;

    for (var i in teclas_especiales) {

        if (codigoCaracter == teclas_especiales[i]) {        
            tecla_especial = true;
            break;
        }    
    }

    return permitidos.indexOf(caracter) != -1 || tecla_especial;

}

