// en este archivo los scripts relacionados
// con trasporte AJAX

var usuario = null;
var posX, posY = 0;
var descrips;
var taimout;
var vistaSols = 'Todas';
var vistaOfers = 'Todas';
var vistaOferClis = 'Todas';
var vistaSolPros = 'Todas';
var pag = 1;
var numRowsTotal;
var numRowsPagina;
var indice;
var idactual;
var numPaginas;

function setUsuario(logged) {

    usuario = logged;
}

function setXY(e) {

    posX = e.clientX;
    posY = e.clientY;
}

function setIdActual(value) {

    idactual = value;
}

function setIndice(value) {

    indice = value;

    var filastipo = new Array(5);

    filastipo[0] = document.getElementById("fila0");
    filastipo[1] = document.getElementById("fila1");
    filastipo[2] = document.getElementById("fila2");
    filastipo[3] = document.getElementById("fila3");
    filastipo[4] = document.getElementById("fila4");
    filastipo[5] = document.getElementById("fila5");

    for (var i = 0; i <= 5; i++) {

        if (filastipo[i]) {

            filastipo[i].setAttribute('class', 'celltipo');

            if (i == value) {

                setIdActual(filastipo[i].getAttribute('name'));
                filastipo[i].setAttribute('class', 'celltiposel');
            }
        }
    }

    var filasedit = new Array(5);

    filasedit[0] = document.getElementById("edit0");
    filasedit[1] = document.getElementById("edit1");
    filasedit[2] = document.getElementById("edit2");
    filasedit[3] = document.getElementById("edit3");
    filasedit[4] = document.getElementById("edit4");
    filasedit[5] = document.getElementById("edit5");

    for (var e = 0; e <= 5; e++) {

        if (filasedit[e]) {

            $("#edit" + e).fadeOut("slow");
        }
    }
}

function informarPosicion() {

    var labelinfo = document.getElementById("spanPosition");

    if (numRowsTotal > 0) {

        var ind = (indice + 1) + (6 * (pag - 1));

        labelinfo.innerHTML = ind + " de " + numRowsTotal + ". Página " + pag + " de " + numPaginas;
    }
    else
        labelinfo.innerHTML = "";     
}


function editarFila(actualrow) {

    $("#edit" + actualrow).fadeIn("slow");

    var bdedit = document.getElementById("select" + indice);
    var infobd = document.getElementById("fila" + indice).firstChild.nodeValue;

    if (infobd.indexOf('Cliente / Servidor') != -1) 
        bdedit.value = 'bdcs';
    else if (infobd.indexOf('De escritorio') != -1) 
        bdedit.value = 'bde';
    else if (infobd.indexOf('sin BD') != -1)
        bdedit.value = 'sinbd';

    if (document.getElementById("amedida" + indice)) {

        var amedit = document.getElementById("amedida" + indice);

        var filamedida = document.getElementById("fila" + indice).nextSibling.firstChild.nodeValue;

        switch (filamedida) {

            case 'A medida':
                amedit.checked = true;
                break;

            case 'Comercial':
                amedit.checked = false;
                break;
        }
    }
    
    var txtdesc = document.getElementById("txtarea" + indice);
    txtdesc.value = descrips[indice];    
}

function okEditarFila(actualrow) {

    $("#edit" + actualrow).fadeOut("slow");

    modificarSoftware();
}

function okEditarFilaPro(actualrow) {

    $("#edit" + actualrow).fadeOut("slow");

    modificarSoftwarePro();
}

function cancelEditarFila(actualrow) {

    $("#edit" + actualrow).fadeOut("slow");
}


// SOLICITUDES DE CLIENTES


function setVista(sols) {

    vistaSols = sols;
    pag = 1;
    verSolicitudes(0);
}


function avanzarRegistro() {

    if ((indice < numRowsPagina - 1) || (pag < numPaginas)) {

        if ((pag < numPaginas) && (!(indice < numRowsPagina - 1))) {

            avanzarPagina();
        }
        else {
            setIndice(++indice);
            informarPosicion();
        }
    }        

    return false;
}

function retrocederRegistro() {

    if (indice > 0) {

        setIndice(--indice);
        informarPosicion();
    }
    else if (pag > 1) {

        retrocederPagina();
    }

    return false;
}

function avanzarPagina() {

    if (pag < numPaginas) {
        pag++;

        verSolicitudes(0);
    }

    return false;
}

function retrocederPagina() {

    if (pag > 1) {
        
        pag--;
        
        verSolicitudes(5);
    }

    return false;
}


function verSolicitudes(index) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/verSolicitudes.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumSols = document.getElementById("lblNumSols");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                var respuestas = transport.responseText;
                var respuesta = respuestas.split("#");

                numRowsTotal = respuesta[0];

                numPaginas = Math.ceil(numRowsTotal / 6);

                labelNumSols.innerHTML = numRowsTotal + ' en total';

                descrips = Array(numRowsTotal);
                var todaslasdescripciones = respuesta[1].split("*");
                numRowsPagina = todaslasdescripciones.length;

                for (var i = 0; i < numRowsPagina; i++) {

                    descrips[i] = todaslasdescripciones[i];
                }

                idactual = respuesta[2];
                var filas = respuesta[3];
                var latabla = document.getElementById("tablespan");

                latabla.innerHTML = filas;

                setIndice(index);
                
                informarPosicion();
            }
        };

        transport.send("cliente=" + usuario + "&pagina=" + pag + "&vista=" + vistaSols);
    }

}


// OFERTAS DE PROGRAMADORES



function setVistaOfers(ofers) {

    vistaOfers = ofers;
    pag = 1;
    verOfertas(0);
}

function avanzarRegistroPro() {

    if ((indice < numRowsPagina - 1) || (pag < numPaginas)) {

        if ((pag < numPaginas) && (!(indice < numRowsPagina - 1))) {

            avanzarPaginaPro();
        }
        else {
            setIndice(++indice);
            informarPosicion();
        }
    }

    return false;
}

function retrocederRegistroPro() {
    
    if (indice > 0) {
    
        setIndice(--indice);
        informarPosicion();
    }
    else if (pag > 1) {

        pag--;
        verOfertas(5);
    }

    return false;
}

function avanzarPaginaPro() {

    if (pag < numPaginas) {
        
        pag++;
        verOfertas(0);
    }

    return false;
}

function retrocederPaginaPro() {

    if (pag > 1) {

        pag--;
        verOfertas(0);
    }

    return false;
}




function verOfertas(index) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/verOfertas.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumOfers = document.getElementById("lblNumOfers");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                var respuestas = transport.responseText;
                var respuesta = respuestas.split("#");

                numRowsTotal = respuesta[0];

                numPaginas = Math.ceil(numRowsTotal / 6);

                labelNumOfers.innerHTML = numRowsTotal + ' en total';

                descrips = Array(numRowsTotal);
                var todaslasdescripciones = respuesta[1].split("*");
                numRowsPagina = todaslasdescripciones.length;
                for (var i = 0; i < numRowsTotal; i++) {

                    descrips[i] = todaslasdescripciones[i];
                }

                idactual = respuesta[2];
                var filas = respuesta[3];
                var latabla = document.getElementById("tablespan");
                latabla.innerHTML = filas;

                setIndice(index);
                informarPosicion();
            }
        };

        transport.send("programador=" + usuario + "&pagina=" + pag + "&vista=" + vistaOfers);
    }

}



// OFERTAS A CLIENTES



function setVistaOferCli(ofers) {

    vistaOferClis = ofers;
    pag = 1;
    verOfertasDeCliente(0);
}


function avanzarRegistroOferCli() {

    if ((indice < numRowsPagina - 1) || (pag < numPaginas)) {

        if ((pag < numPaginas) && (!(indice < numRowsPagina - 1))) {

            avanzarPaginaOferCli();
        }
        else {
            setIndice(++indice);
            informarPosicion();
        }
    }

    return false;
}

function retrocederRegistroOferCli() {

    if (indice > 0) {

        setIndice(--indice);
        informarPosicion();
    }
    else if (pag > 1) {

        retrocederPaginaOferCli();
    }

    return false;
}

function avanzarPaginaOferCli() {

    if (pag < numPaginas) {
        pag++;

        verOfertasDeCliente(0);
    }

    return false;
}

function retrocederPaginaOferCli() {

    if (pag > 1) {

        pag--;

        verOfertasDeCliente(5);
    }

    return false;
}



function verOfertasDeCliente(index) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/verOfertasACli.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumSols = document.getElementById("lblNumSols");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                var respuestas = transport.responseText;
                var respuesta = respuestas.split("#");

                numRowsTotal = respuesta[0];

                numPaginas = Math.ceil(numRowsTotal / 6);

                labelNumSols.innerHTML = numRowsTotal + ' en total';

                descrips = Array(numRowsTotal);
                var todaslasdescripciones = respuesta[1].split("*");
                numRowsPagina = todaslasdescripciones.length;

                for (var i = 0; i < numRowsPagina; i++) {

                    descrips[i] = todaslasdescripciones[i];
                }

                idactual = respuesta[2];
                var filas = respuesta[3];
                var latabla = document.getElementById("tablespan");

                latabla.innerHTML = filas;

                setIndice(index);

                informarPosicion();
            }
        };

        transport.send("cliente=" + usuario + "&pagina=" + pag + "&vista=" + vistaOferClis);
    }

}


// SOLICITUDES A PROGRAMADORES



function setVistaSolPro(sols) {

    vistaSolPros = sols;
    pag = 1;
    verSolicitudesAProgramador(0);
}


function avanzarRegistroSolPro() {

    if ((indice < numRowsPagina - 1) || (pag < numPaginas)) {

        if ((pag < numPaginas) && (!(indice < numRowsPagina - 1))) {

            avanzarPaginaSolPro();
        }
        else {
            setIndice(++indice);
            informarPosicion();
        }
    }

    return false;
}

function retrocederRegistroSolPro() {

    if (indice > 0) {

        setIndice(--indice);
        informarPosicion();
    }
    else if (pag > 1) {

    retrocederPaginaSolPro();
    }

    return false;
}

function avanzarPaginaSolPro() {

    if (pag < numPaginas) {
        pag++;

        verSolicitudesAProgramador(0);
    }

    return false;
}

function retrocederPaginaSolPro() {

    if (pag > 1) {

        pag--;

        verSolicitudesAProgramador(5);
    }

    return false;
}



function verSolicitudesAProgramador(index) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/verSolicitudesAPro.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumSols = document.getElementById("lblNumSols");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                var respuestas = transport.responseText;
                var respuesta = respuestas.split("#");

                numRowsTotal = respuesta[0];

                numPaginas = Math.ceil(numRowsTotal / 6);

                labelNumSols.innerHTML = numRowsTotal + ' en total';

                descrips = Array(numRowsTotal);
                var todaslasdescripciones = respuesta[1].split("*");
                numRowsPagina = todaslasdescripciones.length;

                for (var i = 0; i < numRowsPagina; i++) {

                    descrips[i] = todaslasdescripciones[i];
                }

                idactual = respuesta[2];
                var filas = respuesta[3];
                var latabla = document.getElementById("tablespan");

                latabla.innerHTML = filas;

                setIndice(index);

                informarPosicion();
            }
        };

        transport.send("programador=" + usuario + "&pagina=" + pag + "&vista=" + vistaSolPros);
    }

}


// MENSAJES

// scripts para visualizar y enviar mensajes


var textos;
var fechas;
var views;
var destinatarios;



function avanzarRegistroMensajes() {

    if ((indice < numRowsPagina - 1) || (pag < numPaginas)) {

        if ((pag < numPaginas) && (!(indice < numRowsPagina - 1))) {

            avanzarPaginaMensajes();
        }
        else {
            setIndiceMensajes(++indice);
            informarPosicion();
        }
    }

    return false;
}

function retrocederRegistroMensajes() {

    if (indice > 0) {

        setIndiceMensajes(--indice);
        informarPosicion();
    }
    else if (pag > 1) {

        retrocederPaginaMensajes();
    }

    return false;
}

function avanzarPaginaMensajes() {

    if (pag < numPaginas) {
        pag++;

        verMensajes(0);
    }

    return false;
}

function retrocederPaginaMensajes() {

    if (pag > 1) {

        pag--;

        verMensajes(5);
    }

    return false;
}


function setIndiceMensajes(value) {

    indice = value;

    $("#viewmensaje").fadeOut("slow");
    $("#viewmensajeB").fadeOut("slow");    

    var filasremite = new Array(5);
    var filasasunto = new Array(5);
    var filasobre = new Array(5);

    filasremite[0] = document.getElementById("filaremite0");
    filasremite[1] = document.getElementById("filaremite1");
    filasremite[2] = document.getElementById("filaremite2");
    filasremite[3] = document.getElementById("filaremite3");
    filasremite[4] = document.getElementById("filaremite4");
    filasremite[5] = document.getElementById("filaremite5");

    filasasunto[0] = document.getElementById("filasunto0");
    filasasunto[1] = document.getElementById("filasunto1");
    filasasunto[2] = document.getElementById("filasunto2");
    filasasunto[3] = document.getElementById("filasunto3");
    filasasunto[4] = document.getElementById("filasunto4");
    filasasunto[5] = document.getElementById("filasunto5");

    filasobre[0] = document.getElementById("filasobre0");
    filasobre[1] = document.getElementById("filasobre1");
    filasobre[2] = document.getElementById("filasobre2");
    filasobre[3] = document.getElementById("filasobre3");
    filasobre[4] = document.getElementById("filasobre4");
    filasobre[5] = document.getElementById("filasobre5");
    
    for (var i = 0; i <= 11; i++) {

        if (filasremite[i]) {

            filasremite[i].setAttribute('class', 'celltipo');
            filasasunto[i].setAttribute('class', 'celltipo');
            filasobre[i].setAttribute('class', 'celltipo');

            if (i == value) {

                setIdActual(filasremite[i].getAttribute('name'));
                filasremite[i].setAttribute('class', 'celltiposel');
                filasasunto[i].setAttribute('class', 'celltiposel');
                filasobre[i].setAttribute('class', 'celltiposel');                
            }
        }
    }
    
    
}



function verMensajes(index) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/verMensajesPara.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumSols = document.getElementById("lblNumSols");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                var respuestas = transport.responseText;
                var respuesta = respuestas.split("#");

                numRowsTotal = respuesta[0];

                numPaginas = Math.ceil(numRowsTotal / 6);

                labelNumSols.innerHTML = numRowsTotal + ' en total';

                fechas = Array(numRowsTotal);
                var todaslasfechas = respuesta[1].split("*");

                textos = Array(numRowsTotal);
                var todoslostextos = respuesta[2].split("*");
                numRowsPagina = todoslostextos.length;

                for (var i = 0; i < numRowsPagina; i++) {

                    textos[i] = todoslostextos[i];
                    fechas[i] = todaslasfechas[i];
                }

                idactual = respuesta[3];
                var filas = respuesta[4];
                var latabla = document.getElementById("tablespan");

                latabla.innerHTML = filas;

                setIndiceMensajes(index);

                informarPosicion();
            }
        };

        transport.send("pagina=" + pag);
    }

}

function readMensaje(indexmensaje) {

    setIndiceMensajes(indexmensaje);

    var viewarea = document.getElementById("txtviewarea");
    viewarea.innerHTML = "";
    var descripview = document.getElementById("descripview");
    descripview.firstChild.nodeValue = "";
    
    var elsobre = document.getElementById(indexmensaje);
    elsobre.setAttribute('src', 'images/openmailb.png');
    
    var remite = document.getElementById("filaremite" + indexmensaje).firstChild.nodeValue;
    var asunto = document.getElementById("filasunto" + indexmensaje).firstChild.nodeValue;

    var botonresponder = document.getElementById("responder");

    var reasunto = "";

    if (!(asunto.indexOf('re: ') != -1))
        reasunto = "re: ";
    
    botonresponder.setAttribute('onclick', 'responderMensaje("' + remite + '", "' + reasunto + asunto + '")');

    views = setTimeout(setviews, 800);

    $("#viewmensaje").fadeIn("slow");
    $("#viewmensajeB").fadeIn("slow");

    marcarMensaje(idactual);  

    return false;
}

function responderMensaje(destinatario, asunto) {

    window.location = "zonaenviomensajes.aspx?" + "destinatario=" + destinatario + "&asunto=" + asunto;
}

function unreadMensaje() {

    $("#viewmensaje").fadeOut("slow");
    $("#viewmensajeB").fadeOut("slow");
}

function marcarMensaje(idmensaje) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/manageMensajes.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            null;
        };

        transport.send("modo=markread" + "&idmensaje=" + idmensaje);
    }

}

function borrarMensaje(idmensaje) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/manageMensajes.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            preloader = document.getElementById("ctl00_BodyPlace_preloader");
            labelNumSols = document.getElementById("lblNumSols");

            if (transport.readyState != 4) {

                preloader.style.visibility = "visible";
            }
            if (transport.readyState == 4) {

                preloader.style.visibility = "hidden";

                --numRowsTotal;
                numPaginas = Math.round((numRowsTotal / 6) + 1);

                while (pag >= numPaginas) {

                    if (((numRowsTotal % 6) == 0) && (pag != 1))
                        pag -= 1;
                    else
                        break;
                }

                verMensajes(0);                
            }
        };

        transport.send("modo=deletemensaje" + "&idmensaje=" + idmensaje);
    }

}

function setviews() {

    var viewarea = document.getElementById("txtviewarea");
    viewarea.innerHTML = textos[indice];

    var descripview = document.getElementById("descripview");
    descripview.firstChild.nodeValue = fechas[indice];
    
    clearTimeout(views)

}

// envio de mensajes

function verDestinatarios(match) {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxDestinatarios");
    listbox.innerHTML = "";

    for (var i = 0; i < destinatarios.length; i++) {

        var thedest = destinatarios[i];

        if (thedest.indexOf(match) != -1) {

            var option = document.createElement('option');

            option.setAttribute('value', destinatarios[i]);
            option.innerHTML = destinatarios[i];

            listbox.appendChild(option);
        }
    }
}

function seleccionarDestinatario(nombre) {

    var txtdest = document.getElementById("ctl00_BodyPlace_txtBoxDest");

    txtdest.value = nombre;
}

function ocultarListBoxDestinatarios() {


    $("#ctl00_BodyPlace_listBoxDestinatarios").fadeOut("slow");
}


function mostrarListBoxDestinatarios() {

    var errorSelPro = document.getElementById("ctl00_BodyPlace_errProgrammer");
    errorSelPro.style.visibility = "hidden";


    $("#ctl00_BodyPlace_listBoxDestinatarios").fadeIn("fast");
}

function leerDestinatarios(tipo) {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "aspx/leer" + tipo + ".aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            if (transport.readyState == 4) {

                if (tipo == 'Programadores') {

                    var losclis = transport.responseText;
                    var cadacli = losclis.split("-");

                    destinatarios = Array(cadacli.length);

                    for (var i = 0; i < cadacli.length; i++) {

                        destinatarios[i] = cadacli[i];
                    }
                }
                else if (tipo == 'Clientes') {

                    var lospros = transport.responseText;
                    var cadapro = lospros.split("-");

                    destinatarios = Array(cadapro.length);

                    for (var i = 0; i < cadapro.length; i++) {

                        destinatarios[i] = cadapro[i];
                    }
                }


                escribirDesinatarios();

            }
        };

        transport.send(null);

    }
}

function escribirDesinatarios() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxDestinatarios");

    for (var i = 0; i < destinatarios.length; i++) {

        var option = document.createElement('option');

        option.setAttribute('value', destinatarios[i]);
        option.innerHTML = destinatarios[i];

        listbox.appendChild(option);
    }

}


function borrarDestinatarios() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxDestinatarios");

    listbox.innerHTML = "";

}

function enviarMensaje() {

    var valido = validarMensaje();

    if (valido) {

        var destinatario = document.getElementById("ctl00_BodyPlace_txtBoxDest").value;
        var asunto = document.getElementById("ctl00_BodyPlace_txtBoxAsunto").value;        
        var eltexto = document.getElementById("ctl00_BodyPlace_txtText").value;

        // state 0: no inicializada
        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageMensajes.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                var preloader = document.getElementById("ctl00_BodyPlace_preloader");
                var botonsol = document.getElementById("btnEnviar");

                // state 2: en progreso
                // state 3: en respuesta
                // state 4: lista

                if (transport.readyState != 4) {
                    preloader.style.visibility = "visible";
                    botonsol.disabled = true;
                }
                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";
                    notificarEnvioMensaje();
                }
            };

            transport.send("modo=sendmensaje" + "&emisor=" + usuario + "&receptor=" + destinatario + 
                           "&asunto=" + asunto + "&texto=" + eltexto);

        }
    }

    return false;

}

function notificarEnvioMensaje() {

    $("#ctl00_BodyPlace_lblEnviado").fadeIn("slow");

    var txtdest = document.getElementById("ctl00_BodyPlace_txtBoxDest");
    var txtasunto = document.getElementById("ctl00_BodyPlace_txtBoxAsunto");
    var texto = document.getElementById("ctl00_BodyPlace_txtText");

    txtdest.value = "";
    txtasunto.value = "";
    texto.value = "";

    borrarDestinatarios();
    escribirDesinatarios();

    setTimeout(ocultarNotificacionMensaje, 2500);

}

function ocultarNotificacionMensaje() {

    $("#ctl00_BodyPlace_lblEnviado").fadeOut("slow");

    var botonenvio = document.getElementById("btnEnviar");

    botonenvio.disabled = false;

    var txtdest = document.getElementById("ctl00_BodyPlace_txtBoxDest");
    txtdest.focus();

}

function validarMensaje() {

    var valido = true;
    var nocoincidedest = false;

    var destiner = document.getElementById("ctl00_BodyPlace_txtBoxDest").value;
    var eltexto = document.getElementById("ctl00_BodyPlace_txtText").value;

    var errorSelPro = document.getElementById("ctl00_BodyPlace_errProgrammer");
    var errorDescripcion = document.getElementById("ctl00_BodyPlace_errDescripcion");

    for (var i = 0; i < destinatarios.length; i++) {

        if (destiner == destinatarios[i]) {
            valido = true;
            nocoincidedest = false;
            break;
        }
        else {
            valido = false;
            nocoincidedest = true;
        }
    }

    if ((destiner == "") || (/^\s+$/.test(destiner)) || (nocoincidedest)) {
        errorSelPro.style.visibility = "visible";
        valido = false;
    }
    else
        errorSelPro.style.visibility = "hidden";


    if ((eltexto == "") || (/^\s+$/.test(eltexto))) {
        errorDescripcion.style.visibility = "visible";
        valido = false;
    }
    else
        errorDescripcion.style.visibility = "hidden";

    return valido;

}



var clientes;
var programadores;

function leerProgramadores() {

    var transport = getTransport();
    if (transport) {

        transport.open('GET', "aspx/leerProgramadores.aspx" + "?nocache=" + Math.random());

        transport.onreadystatechange = function() {

            if (transport.readyState == 4) {

                var losprogs = transport.responseText;
                var cadaprog = losprogs.split("-");

                programadores = Array(cadaprog.length);

                for (var i = 0; i < cadaprog.length; i++) {

                    programadores[i] = cadaprog[i];
                }

                escribirProgramadores();
            }
        };

        transport.send(null);

    }

}

function escribirProgramadores() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxPros");

    for (var i = 0; i < programadores.length; i++) {

        var option = document.createElement('option');

        option.setAttribute('value', programadores[i]);
        option.innerHTML = programadores[i];

        listbox.appendChild(option);
    }

}

function borrarProgramadores() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxPros");

    listbox.innerHTML = "";

}


function demandarSoftware() {

    var valido = validarSoftDem();

    if (valido) {

        var programador = document.getElementById("ctl00_BodyPlace_txtBoxPro").value;
        var tipo = document.getElementById("ctl00_BodyPlace_ddTipo").value;
        var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc").value;
        var conbd;
        var tipobd;

        var check = document.getElementById("chkbd");

        if (check.checked) {

            conbd = 1;
            tipobd = document.getElementById("ctl00_BodyPlace_ddTipobd").value;
        }
        else {
            conbd = 0;
            tipobd = '';
        }

        // state 0: no inicializada
        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                var preloader = document.getElementById("ctl00_BodyPlace_preloader");
                var botonsol = document.getElementById("btnSolicitar");

                // state 2: en progreso
                // state 3: en respuesta
                // state 4: lista

                if (transport.readyState != 4) {
                    preloader.style.visibility = "visible";
                    botonsol.disabled = true;
                }
                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";
                    notificarEnvio();
                }
            };

            transport.send("modo=insertcli" + "&programador=" + programador + "&tipo=" + tipo + "&descripcion=" +
                            descripcion + "&conbd=" + conbd + "&tipobd=" + tipobd);

        }
    }

    return false;

}



function modificarSoftware() {

    var valido = true;

    if (valido) {

        var descripcion = document.getElementById("txtarea" + indice).value;
        var conbd;
        var tipobd;

        var bdselect = document.getElementById("select" + indice).value;

        switch (bdselect) {

            case 'sinbd':
                conbd = 0;
                tipobd = '';
                break;

            case 'bdcs':
                conbd = 1;
                tipobd = 'Cliente / Servidor';
                break;

            case 'bde':
                conbd = 1;
                tipobd = 'De escritorio';
                break;
        }

        // state 0: no inicializada
        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                var preloader = document.getElementById("ctl00_BodyPlace_preloader");

                // state 2: en progreso
                // state 3: en respuesta
                // state 4: lista

                if (transport.readyState != 4) {
                    preloader.style.visibility = "visible";
                }
                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";

                    verSolicitudes(indice);
                }
            };

            transport.send("modo=modifycli" + "&idsoft=" + idactual + "&descripcion=" + descripcion + "&conbd=" +
                            conbd + "&tipobd=" + tipobd);

        }
    }

    return false;

}



function borrarSoft(idsoftware) {

    if (window.confirm("¿Seguro de que desea borrar la solicitud actual?") == true) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";

                    --numRowsTotal;
                    numPaginas = Math.round((numRowsTotal / 6) + 1);

                    while (pag >= numPaginas) {

                        if (((numRowsTotal % 6) == 0) && (pag != 1))
                            pag -= 1;
                        else
                            break;
                    }

                    verSolicitudes(0);
                }
            };

            transport.send("modo=deletecli" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


function notificarEnvio() {

    $("#ctl00_BodyPlace_lblEnviado").fadeIn("slow");

    var txtpro = document.getElementById("ctl00_BodyPlace_txtBoxPro");
    var tipo = document.getElementById("ctl00_BodyPlace_ddTipo");
    var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc");
    var conbd = document.getElementById("chkbd");

    txtpro.value = "";
    tipo.value = "nil";
    descripcion.value = "";
    conbd.checked = false;
    $("#ctl00_BodyPlace_lblTipobd").fadeOut("fast");
    $("#ctl00_BodyPlace_ddTipobd").fadeOut("fast");

    borrarProgramadores();
    escribirProgramadores();

    setTimeout(ocultarNotificacion, 2500);

}

function ocultarNotificacion() {

    $("#ctl00_BodyPlace_lblEnviado").fadeOut("slow");

    var botonsol = document.getElementById("btnSolicitar");

    botonsol.disabled = false;

    var txtpro = document.getElementById("ctl00_BodyPlace_txtBoxPro");
    txtpro.focus();

}


function validarSoftDem() {

    var valido = true;
    var nocoincidepro = false;

    var programmer = document.getElementById("ctl00_BodyPlace_txtBoxPro").value;
    var tipo = document.getElementById("ctl00_BodyPlace_ddTipo").value;
    var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc").value;

    var errorSelPro = document.getElementById("ctl00_BodyPlace_errProgrammer");
    var errorTipo = document.getElementById("ctl00_BodyPlace_errTipo");
    var errorDescripcion = document.getElementById("ctl00_BodyPlace_errDescripcion");

    for (var i = 0; i < programadores.length; i++) {

        if (programmer == programadores[i]) {
            valido = true;
            nocoincidepro = false;
            break;
        }
        else {
            valido = false;
            nocoincidepro = true;
        }
    }

    if ((programmer == "") || (/^\s+$/.test(programmer)) || (nocoincidepro)) {
        errorSelPro.style.visibility = "visible";
        valido = false;
    }
    else
        errorSelPro.style.visibility = "hidden";


    if (tipo == 'nil') {
        errorTipo.style.visibility = "visible";
        valido = false;
    }
    else
        errorTipo.style.visibility = "hidden";

    if ((descripcion == "") || (/^\s+$/.test(descripcion))) {
        errorDescripcion.style.visibility = "visible";
        valido = false;
    }
    else
        errorDescripcion.style.visibility = "hidden";

    return valido;

}

function mostrarInfo(idSoft) {

    if (taimout)
        clearTimeout(taimout);

    var globo = document.getElementById("globo");
    var lbl = document.getElementById("globodes");

    globo.setAttribute('style', 'margin-top:' + (posY - 1020) + 'px;margin-left:' + (posX - 50) + 'px');

    lbl.setAttribute('style', 'margin-top:' + (posY - 1000) + 'px;margin-left:' + (posX - 30) + 'px');

    lbl.innerHTML = "<b>" + descrips[idSoft] + "</b>";

    $("#globo").fadeIn("slow");
    $("#globodes").fadeIn("slow");

    taimout = setTimeout(ocultarSoft, 4000);

    return false;
}

function ocultarSoft() {

    $("#globo").fadeOut("slow");
    $("#globodes").fadeOut("slow");

    clearTimeout(taimout);
}


function verProgramadores(match) {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxPros");
    listbox.innerHTML = "";

    for (var i = 0; i < programadores.length; i++) {

        var thepro = programadores[i];

        if (thepro.indexOf(match) != -1) {

            var option = document.createElement('option');

            option.setAttribute('value', programadores[i]);
            option.innerHTML = programadores[i];

            listbox.appendChild(option);
        }
    }
}

function seleccionarProgramador(nombre) {

    var txtpro = document.getElementById("ctl00_BodyPlace_txtBoxPro");

    txtpro.value = nombre;
}

function ocultarListBoxPros() {


    $("#ctl00_BodyPlace_listBoxPros").fadeOut("slow");
}


function mostrarListBoxPros() {

    var errorSelPro = document.getElementById("ctl00_BodyPlace_errProgrammer");
    errorSelPro.style.visibility = "hidden";


    $("#ctl00_BodyPlace_listBoxPros").fadeIn("fast");
}


function focusDescripcion() {

    var txtdescripcion = document.getElementById("ctl00_BodyPlace_txtDesc");

    txtdescripcion.focus();
}

function focusPro() {

    var txtpro = document.getElementById("ctl00_BodyPlace_txtBoxPro");

    txtpro.focus();
}


// SECCIÓN DE PROGRAMADOR


function leerClientes() {

    var transport = getTransport();
    if (transport) {

        transport.open('GET', "aspx/leerClientes.aspx" + "?nocache=" + Math.random());

        transport.onreadystatechange = function() {

            if (transport.readyState == 4) {

                var losclis = transport.responseText;
                var cadacli = losclis.split("-");

                clientes = Array(cadacli.length);

                for (var i = 0; i < cadacli.length; i++) {

                    clientes[i] = cadacli[i];
                }

                escribirClientes();
            }
        };

        transport.send(null);

    }
}

function escribirClientes() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxClis");

    for (var i = 0; i < clientes.length; i++) {

        var option = document.createElement('option');

        option.setAttribute('value', clientes[i]);
        option.innerHTML = clientes[i];

        listbox.appendChild(option);
    }

}


function borrarClientes() {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxClis");

    listbox.innerHTML = "";

}

function ofertarSoftware() {

    var valido = validarSoftOfer();

    if (valido) {

        var cliente = document.getElementById("ctl00_BodyPlace_txtBoxCli").value;
        var tipo = document.getElementById("ctl00_BodyPlace_ddTipo").value;
        var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc").value;
        var personalizable;
        var conbd;
        var tipobd;

        var checkpersonalizable = document.getElementById("chkpers");

        if (checkpersonalizable.checked)
            personalizable = 1;
        else
            personalizable = 0;

        var check = document.getElementById("chkbd");

        if (check.checked) {

            conbd = 1;
            tipobd = document.getElementById("ctl00_BodyPlace_ddTipobd").value;
        }
        else {
            conbd = 0;
            tipobd = '';
        }

        // state 0: no inicializada
        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                var preloader = document.getElementById("ctl00_BodyPlace_preloader");
                var botonofer = document.getElementById("btnOfertar");

                // state 2: en progreso
                // state 3: en respuesta
                // state 4: lista

                if (transport.readyState != 4) {
                    preloader.style.visibility = "visible";
                    botonofer.disabled = true;
                }
                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";
                    notificarEnvioOferta();
                }
            };

            transport.send("modo=insertpro" + "&cliente=" + cliente + "&tipo=" + tipo + "&descripcion=" +
                            descripcion + "&personalizable=" + personalizable + "&conbd=" + conbd + "&tipobd=" + tipobd);

        }
    }

    return false;

}

function modificarSoftwarePro() {

    var valido = true;

    if (valido) {

        var descripcion = document.getElementById("txtarea" + indice).value;
        var conbd;
        var tipobd;
        var amedida;

        var amselect = document.getElementById("amedida" + indice);

        if (amselect.checked)
            amedida = 1;
        else
            amedida = 0;

        var bdselect = document.getElementById("select" + indice).value;

        switch (bdselect) {

            case 'sinbd':
                conbd = 0;
                tipobd = '';
                break;

            case 'bdcs':
                conbd = 1;
                tipobd = 'Cliente / Servidor';
                break;

            case 'bde':
                conbd = 1;
                tipobd = 'De escritorio';
                break;
        }

        // state 0: no inicializada
        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                var preloader = document.getElementById("ctl00_BodyPlace_preloader");

                // state 2: en progreso
                // state 3: en respuesta
                // state 4: lista

                if (transport.readyState != 4) {
                    preloader.style.visibility = "visible";
                }
                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";

                    verOfertas(indice);
                }
            };

            transport.send("modo=modifypro" + "&idsoft=" + idactual + "&descripcion=" + descripcion +
                           "&amedida=" + amedida + "&conbd=" + conbd + "&tipobd=" + tipobd);

        }
    }

    return false;

}


function borrarSoftOfer(idsoftware) {


    if (window.confirm("¿Seguro de que desea borrar la oferta actual?") == true) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {
                    preloader.style.visibility = "hidden";

                    --numRowsTotal;
                    numenlaces = Math.round((numRowsTotal / 6) + 1);

                    while (pag >= numenlaces) {

                        if (((numRowsTotal % 6) == 0) && (pag != 1))
                            pag -= 1;
                        else
                            break;
                    }
                    verOfertas(0);
                }
            };

            transport.send("modo=deletepro" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


function validarSoftOfer() {

    var valido = true;
    var nocoincidecli = false;

    var customer = document.getElementById("ctl00_BodyPlace_txtBoxCli").value;
    var tipo = document.getElementById("ctl00_BodyPlace_ddTipo").value;
    var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc").value;

    var errorSelPro = document.getElementById("ctl00_BodyPlace_errCustomer");
    var errorTipo = document.getElementById("ctl00_BodyPlace_errTipo");
    var errorDescripcion = document.getElementById("ctl00_BodyPlace_errDescripcion");

    for (var i = 0; i < clientes.length; i++) {

        if (customer == clientes[i]) {
            valido = true;
            nocoincidecli = false;
            break;
        }
        else {
            valido = false;
            nocoincidecli = true;
        }
    }

    if ((customer == "") || (/^\s+$/.test(customer)) || (nocoincidecli)) {
        errorSelPro.style.visibility = "visible";
        valido = false;
    }
    else
        errorSelPro.style.visibility = "hidden";


    if (tipo == 'nil') {
        errorTipo.style.visibility = "visible";
        valido = false;
    }
    else
        errorTipo.style.visibility = "hidden";

    if ((descripcion == "") || (/^\s+$/.test(descripcion))) {
        errorDescripcion.style.visibility = "visible";
        valido = false;
    }
    else
        errorDescripcion.style.visibility = "hidden";

    return valido;

}


function notificarEnvioOferta() {

    $("#ctl00_BodyPlace_lblEnviado").fadeIn("slow");

    var txtcli = document.getElementById("ctl00_BodyPlace_txtBoxCli");
    var tipo = document.getElementById("ctl00_BodyPlace_ddTipo");
    var descripcion = document.getElementById("ctl00_BodyPlace_txtDesc");
    var personalizable = document.getElementById("chkpers");
    var conbd = document.getElementById("chkbd");

    txtcli.value = "";
    tipo.value = "nil";
    descripcion.value = "";
    personalizable.checked = false;
    conbd.checked = false;
    $("#ctl00_BodyPlace_lblTipobd").fadeOut("fast");
    $("#ctl00_BodyPlace_ddTipobd").fadeOut("fast");

    borrarClientes();
    escribirClientes();

    setTimeout(ocultarNotificacionOferta, 2500);

}

function ocultarNotificacionOferta() {

    $("#ctl00_BodyPlace_lblEnviado").fadeOut("slow");

    var botonofer = document.getElementById("btnOfertar");

    botonofer.disabled = false;

    var txtcli = document.getElementById("ctl00_BodyPlace_txtBoxCli");
    txtcli.focus();

}



function focusCli() {

    var txtcli = document.getElementById("ctl00_BodyPlace_txtBoxCli");
    txtcli.focus();
}

function verClientes(match) {

    var listbox = document.getElementById("ctl00_BodyPlace_listBoxClis");
    listbox.innerHTML = "";

    for (var i = 0; i < clientes.length; i++) {

        var thecli = clientes[i];

        if (thecli.indexOf(match) != -1) {

            var option = document.createElement('option');

            option.setAttribute('value', clientes[i]);
            option.innerHTML = clientes[i];

            listbox.appendChild(option);
        }
    }
}


function seleccionarCliente(nombre) {

    var txtcli = document.getElementById("ctl00_BodyPlace_txtBoxCli");

    txtcli.value = nombre;
}

function ocultarListBoxClis() {


    $("#ctl00_BodyPlace_listBoxClis").fadeOut("slow");
}


function mostrarListBoxClis() {

    var errorSelCli = document.getElementById("ctl00_BodyPlace_errCustomer");
    errorSelCli.style.visibility = "hidden";


    $("#ctl00_BodyPlace_listBoxClis").fadeIn("fast");
}

function irAsolicitudes() {

    window.location = "zonaclisoftdemanda.aspx";
}


// OFERTAS Y SOLICITUDES


function aceptarOfertaSoft(idsoftware) {

    if (numRowsTotal > 0) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";
                    verOfertasDeCliente(indice);
                }
            };

            transport.send("modo=acceptofer" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


function rechazarOfertaSoft(idsoftware) {

    if (numRowsTotal > 0) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";
                    verOfertasDeCliente(indice);
                }
            };

            transport.send("modo=rejectofer" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


function aceptarSolicitudSoft(idsoftware) {

    if (numRowsTotal > 0) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";
                    verSolicitudesAProgramador(indice);
                }
            };

            transport.send("modo=acceptsol" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


function rechazarSolicitudSoft(idsoftware) {

    if (numRowsTotal > 0) {

        var preloader = document.getElementById("ctl00_BodyPlace_preloader");

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "aspx/manageSoftware.aspx" + "?nocache=" + Math.random());
            // state 1: inicializada
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";
                    verSolicitudesAProgramador(indice);
                }
            };

            transport.send("modo=rejectsol" + "&idsoft=" + idsoftware);

        }
    }

    return false;
}


// INSERCIÓN DE CLIENTES Y PROGRAMADORES


function insertarCliente() {

    var registroValido = ValidarRegistro();

    if (registroValido) {

        var nombre = document.getElementById("ctl00_BodyPlace_txtNombre").value;
        var apellidos = document.getElementById("ctl00_BodyPlace_txtApellidos").value;
        var empresa = document.getElementById("ctl00_BodyPlace_txtEmpresa").value;
        var sector = document.getElementById("ctl00_BodyPlace_ddSector").value;
        var cargo = document.getElementById("ctl00_BodyPlace_txtCargo").value;
        var email = document.getElementById("ctl00_BodyPlace_txteMail").value;
        var tel = document.getElementById("ctl00_BodyPlace_txtTel").value;
        var nick = document.getElementById("ctl00_BodyPlace_txtNick").value;
        var clave = document.getElementById("ctl00_BodyPlace_txtClave").value;

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "ASPX/insertCliente.aspx" + "?nocache=" + Math.random());
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                preloader = document.getElementById("loadingpanel");

                if (transport.readyState != 4) {

                    preloader.style.visibility = "visible";
                }
                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";

                    respuesta = transport.responseText;

                    if (respuesta.indexOf("nick no disponible") != -1) {

                        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = "hala, nick noho";

                    }

                    if (respuesta.indexOf("insertado correctamente") != -1) {

                        document.getElementById("ctl00_BodyPlace_PanelVuelta").style.visibility = "visible";
                    }
                }
            };

            transport.send("nombre=" + nombre + "&apellidos=" + apellidos + "&empresa=" + empresa
                    + "&sector=" + sector + "&cargo=" + cargo + "&email=" + email + "&tel=" + tel
                    + "&nick=" + nick + "&clave=" + clave);
        }
    }
}


function insertarProgramador() {

    var registroValido = ValidarRegistroPro();

    if (registroValido) {

        var nombre = document.getElementById("ctl00_BodyPlace_txtNombre").value;
        var apellidos = document.getElementById("ctl00_BodyPlace_txtApellidos").value;
        var email = document.getElementById("ctl00_BodyPlace_txteMail").value;
        var tel = document.getElementById("ctl00_BodyPlace_txtTel").value;
        var empresa = document.getElementById("ctl00_BodyPlace_txtEmpresa").value;
        var nick = document.getElementById("ctl00_BodyPlace_txtNick").value;
        var clave = document.getElementById("ctl00_BodyPlace_txtClave").value;

        var experiencias = "";

        var numchecks = document.getElementsByTagName("td").length;
        var checks = document.getElementsByTagName("td");
        var txts = document.getElementsByTagName("label");

        for (i = 0; i < numchecks; i++) {

            if (checks.item(i).innerHTML != "") {

                if (checks.item(i).firstChild.checked) {

                    if (experiencias != "")
                        experiencias += "-";

                    experiencias += txts.item(i).innerHTML;
                }

            }
        }

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "ASPX/insertProgramador.aspx" + "?nocache=" + Math.random());
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                preloader = document.getElementById("loadingpanel");

                if (transport.readyState != 4) {

                    preloader.style.visibility = "visible";
                }
                if (transport.readyState == 4) {

                    preloader.style.visibility = "hidden";

                    respuesta = transport.responseText;

                    if (respuesta.indexOf("nick no disponible") != -1) {

                        document.getElementById("ctl00_BodyPlace_errNick").innerHTML = "hala, nick noho";

                    }

                    if (respuesta.indexOf("insertado correctamente") != -1) {

                        document.getElementById("ctl00_BodyPlace_PanelVuelta").style.visibility = "visible";
                    }
                }
            };

            transport.send("nombre=" + nombre + "&apellidos=" + apellidos
                    + "&email=" + email + "&tel=" + tel + "&empresa=" + empresa
                    + "&experiencias=" + experiencias + "&nick=" + nick + "&clave=" + clave);
        }
    }
}


function irAofertas() {

    window.location = "zonaprosoftoferta.aspx";
}




// este script para
// el trasporte AJAX



function getTransport() {
    var transport = false;

    if (window.XMLHttpRequest) {
        transport = new XMLHttpRequest(); // Opera, Mozilla, IE7
    }
    else if (window.ActiveXObject) {
        try {
            transport = new ActiveXObject('Msxml2.XMLHTTP'); // IE 6
        }
        catch (err) {
            transport = new ActiveXObject('Microsoft.XMLHTTP'); // IE 5
        }
    }

    return (transport);
}



// en este script todo lo relacionado con las notificaciones de
// nuevo mensaje, ofertas y solicitudes

var intervalo;
var intervalo2;

function iniciarNotificaciones() {

    verNotificaciones();
    actualizarCarpeta();

    intervalo = setInterval(verNotificaciones, 4000);
    intervalo2 = setInterval(actualizarCarpeta, 4000);
}

function verNotificaciones() {

    var transport = getTransport();
    if (transport) {

        transport.open('POST', "ASPX/manageNotificaciones.aspx" + "?nocache=" + Math.random());
        transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

        transport.onreadystatechange = function() {

            if (transport.readyState == 4) {

                var respuestas = transport.responseText;

                if (respuestas) {

                    if (respuestas != "##") {

                        var respuesta = respuestas.split("#");

                        var ids = respuesta[0].split("*");
                        var tooltips = respuesta[1].split("*");
                        var tipos = respuesta[2].split("*");

                        var tiposMensaje = 0;
                        var tiposSoftware = 0;

                        for (var i = 0; i < tooltips.length; i++) {

                            switch (tipos[i]) {

                                case "Software":
                                    tiposSoftware++;
                                    break;

                                case "Mensaje":
                                    tiposMensaje++;
                                    break;
                            }
                        }

                        if (tiposSoftware > 0) {

                            var menusoftware = (document.getElementById("asoftwarecli")) || (document.getElementById("asoftwarepro"))

                            menusoftware.innerHTML = "Software (" + tiposSoftware + ")";
                            menusoftware.setAttribute('style', 'color:#e91c2b');
                        }

                        if (tiposMensaje > 0) {
                            var menumensaje = document.getElementById("amensaje");

                            menumensaje.innerHTML = "Mensajes (" + tiposMensaje + ")";
                            menumensaje.setAttribute('style', 'color:#e91c2b');
                        }

                        if ((document.getElementById("tablecarpeta")) && ((tiposSoftware > 0) || (tiposMensaje > 0))) {

                            actualizarCarpeta();
                        }

                    }
                }
            }
        };

        transport.send("modo=buscar" + "&nick=" + usuario);
    }
}

function actualizarCarpeta() {

    if (document.getElementById("tablecarpeta")) {

        var transport = getTransport();
        if (transport) {

            transport.open('POST', "ASPX/verCarpeta.aspx" + "?nocache=" + Math.random());
            transport.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");

            transport.onreadystatechange = function() {

                if (transport.readyState == 4) {

                    var filas = transport.responseText;
                    var latabla = document.getElementById("tablecarpeta");

                    latabla.innerHTML = filas;
                }
            };

            transport.send("usuario=" + usuario);
        }
    }
}


