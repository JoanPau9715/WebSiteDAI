<%@ Page Language="C#" MasterPageFile="~/Principal.master" AutoEventWireup="true" CodeFile="Registropro.aspx.cs" Inherits="Registropro" Title="Comunicación y tecnología" %>
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
                    <asp:Label ID="Label7" CssClass="Etiquetas" runat="server" Text="Experiencia"></asp:Label>                
                    <asp:CheckBoxList ID="chExperiencia" CssClass="Expers" runat="server" RepeatColumns="2" RepeatDirection="Horizontal">
                    </asp:CheckBoxList>
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
                <input id="Button1" type="button" value="Enviar" class="Botones4" onclick="insertarProgramador()" />
            </div> 
            <div class="panelBienvenidaPro" id="PanelVuelta" runat="server">
                <asp:Label ID="Label8" runat="server" Text="<b>E KOMO MAI!</b> Kailua da la bienvenida a todos los <b>programadores</b>"></asp:Label>
                <asp:LinkButton ID="LinkButton1" runat="server" oncommand="AccesoDirecto_Command">>>Pulse aquí para acceder</asp:LinkButton>
            </div>   
            <div class="preloaderpro" id="loadingpanel">
                <asp:Image ID="Image1" runat="server" ImageUrl="FOTOS/loading.gif" />
            </div>                
        </asp:Panel>
    </div>
</asp:Content>

