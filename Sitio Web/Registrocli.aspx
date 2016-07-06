<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Registrocli.aspx.cs" Inherits="Registro" Title="Comunicación y tecnología" %>
<%@ MasterType TypeName="Principal" %>

<asp:Content ID="Content1" ContentPlaceHolderID="HeadPlace" Runat="Server">
</asp:Content>
<asp:Content ID="Content2" ContentPlaceHolderID="BodyPlace" Runat="Server"> 
    <div class="BodyPlace">
        <asp:Panel ID="Panel1" runat="server" Height="640px">
            <asp:Label ID="Label1" runat="server" Text="Estos datos pasarán a formar parte de la <b>base de datos</b> sobre miembros de
                                    la comunidad<br />Usted puede modificar o dar de baja sus datos cuando desee" CssClass="TextoBienvenida"></asp:Label>
            <div class="CuadroRegistro">
                <p>
                    <asp:Label CssClass="Etiquetas" ID="lblNombre" runat="server" Text="Nombre"></asp:Label>
                    <asp:TextBox ID="txtNombre" runat="server" CssClass="Edits" onkeypress="return permiteCaracteres(event, 'car')"></asp:TextBox>
                    <asp:Label ID="errNombre" runat="server" CssClass="EtiquetaError"></asp:Label>
                </p>                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="lblApellidos" runat="server" Text="Apellidos"></asp:Label>
                    <asp:TextBox ID="txtApellidos" runat="server" CssClass="Edits" onkeypress="return permiteCaracteres(event, 'car')"></asp:TextBox>                
                    <asp:Label ID="errApellidos" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="lblEmpresa" runat="server" Text="Empresa"></asp:Label>
                    <asp:TextBox ID="txtEmpresa" runat="server" CssClass="Edits"></asp:TextBox>                
                    <asp:Label ID="errEmpresa" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="Label7" runat="server" Text="Sector"></asp:Label>
                    <asp:DropDownList ID="ddSector" runat="server" CssClass="DDListSector" onchange="PasarFocoACargo()">
                    </asp:DropDownList>
                    <asp:Label ID="errSector" runat="server" CssClass="EtiquetaError"></asp:Label>                                        
                </p>                                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="lblCargo" runat="server" Text="Cargo"></asp:Label>
                    <asp:TextBox ID="txtCargo" runat="server" CssClass="Edits"></asp:TextBox>                
                    <asp:Label ID="errCargo" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                                
            </div>                                    
            <div class="CuadroRegistro2">
                <p>
                    <asp:Label CssClass="Etiquetas" ID="Label2" runat="server" Text="e Mail"></asp:Label>
                    <asp:TextBox ID="txteMail" runat="server" CssClass="Edits"></asp:TextBox>
                    <asp:Label ID="erreMail" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>
                <p>
                    <asp:Label CssClass="Etiquetas" ID="Label3" runat="server" Text="Tel"></asp:Label>
                    <asp:TextBox ID="txtTel" runat="server" CssClass="Edits" onkeypress="return permiteCaracteres(event, 'num')"></asp:TextBox>                
                    <asp:Label ID="errTel" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="Label4" runat="server" Text="Nick"></asp:Label>
                    <asp:TextBox ID="txtNick" runat="server" CssClass="Edits" onkeypress="return permiteCaracteres(event, 'numscars')"></asp:TextBox>                
                    <asp:Label ID="errNick" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                
                <p>
                    <asp:Label CssClass="Etiquetas" ID="Label5" runat="server" Text="Contraseña"></asp:Label>
                    <asp:TextBox ID="txtClave" runat="server" CssClass="Edits" TextMode="Password"></asp:TextBox>                
                    <asp:Label ID="errClave" runat="server" CssClass="EtiquetaError"></asp:Label>                    
                </p>                                
                <p>
                    <asp:Label ID="Label6" runat="server" Text="Confirmar" CssClass="Etiquetas"></asp:Label>
                    <asp:TextBox ID="txtConfirmarClave" runat="server" CssClass="Edits" 
                        TextMode="Password"></asp:TextBox>                                                
                    <asp:Label ID="errConfirmarClave" runat="server" CssClass="EtiquetaError"></asp:Label>
                </p>
            </div>  
            <div class="CuadroRegistro3">
                <input id="Button1" type="button" value="Enviar" class="Botones4" onclick="insertarCliente()" />
            </div> 
            <div id="PanelVuelta" runat="server" class="panelBienvenida">
                <asp:Label ID="Label8" runat="server" Text="<b>E KOMO MAI!</b>  Gracias por unirse a <b>Kailua</b> Comunicación y Tecnología ©"></asp:Label>
                <asp:LinkButton ID="AccesoDirecto" runat="server" oncommand="AccesoDirecto_Command">>>Pulse aquí para acceder</asp:LinkButton>
            </div>  
            <div class="preloadercli" id="loadingpanel">
                <asp:Image ID="loading" runat="server" ImageUrl="FOTOS/loading.gif" />                
            </div>
        </asp:Panel>
    </div>
</asp:Content>

