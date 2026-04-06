package adso.sena.biblioteca.model;

public class Usuario {

    private int idUsuario;
    private String documento;
    private String nombres;
    private String apellidos;
    private String email;
    private String password;
    private String telefono;
    private TipoUsuario tipoUsuario;
    private EstadoUsuario estadoUsuario;

    public Usuario() {}

    public Usuario(String documento, String nombres, String apellidos, String email,
                   String telefono, TipoUsuario tipoUsuario) {
        this.documento    = documento;
        this.nombres      = nombres;
        this.apellidos    = apellidos;
        this.email        = email;
        this.telefono     = telefono;
        this.tipoUsuario  = tipoUsuario;
        this.estadoUsuario = new EstadoUsuario(1, "activo", "Usuario habilitado para préstamos");
    }

    // ─── Getters y Setters existentes ───────────────────────────────────────
    public int getIdUsuario()                        { return idUsuario; }
    public void setIdUsuario(int idUsuario)          { this.idUsuario = idUsuario; }

    public String getDocumento()                     { return documento; }
    public void setDocumento(String documento)       { this.documento = documento; }

    public String getNombres()                       { return nombres; }
    public void setNombres(String nombres)           { this.nombres = nombres; }

    public String getApellidos()                     { return apellidos; }
    public void setApellidos(String apellidos)       { this.apellidos = apellidos; }

    public String getEmail()                         { return email; }
    public void setEmail(String email)               { this.email = email; }

    public String getTelefono()                      { return telefono; }
    public void setTelefono(String telefono)         { this.telefono = telefono; }

    public TipoUsuario getTipoUsuario()              { return tipoUsuario; }
    public void setTipoUsuario(TipoUsuario t)        { this.tipoUsuario = t; }

    public EstadoUsuario getEstadoUsuario()          { return estadoUsuario; }
    public void setEstadoUsuario(EstadoUsuario e)    { this.estadoUsuario = e; }

    // ─── Nuevo: password ────────────────────────────────────────────────────
    public String getPassword()                      { return password; }
    public void setPassword(String password)         { this.password = password; }

    // ─── Nuevo: rol derivado del tipo de usuario ────────────────────────────
    // administrativo (id=3) → admin | estudiante/docente (id=1,2) → usuario
    public String getRol() {
        if (tipoUsuario != null && tipoUsuario.getIdTipoUsuario() == 3) {
            return "admin";
        }
        return "usuario";
    }

    public boolean esAdmin() {
        return "admin".equals(getRol());
    }

    // ─── Helpers existentes ──────────────────────────────────────────────────
    public String getNombreCompleto() {
        return nombres + " " + apellidos;
    }

    @Override
    public String toString() {
        return getNombreCompleto() + " (" + documento + ")";
    }
}