package main

import (
	"database/sql"
	"fmt"

	_ "github.com/lib/pq"
)

var DB *sql.DB

// ConfiguracionBD contiene los parámetros de conexión
type ConfiguracionBD struct {
	Host     string
	Port     string
	User     string
	Password string
	DBName   string
	SSLMode  string
}

// ConectarBD establece la conexión con PostgreSQL
func ConectarBD(config ConfiguracionBD) error {
	connStr := fmt.Sprintf("host=%s port=%s user=%s password=%s dbname=%s sslmode=%s",
		config.Host,
		config.Port,
		config.User,
		config.Password,
		config.DBName,
		config.SSLMode,
	)

	var err error
	DB, err = sql.Open("postgres", connStr)
	if err != nil {
		return fmt.Errorf("error al abrir la conexión: %v", err)
	}

	// Verificar que la conexión funciona
	err = DB.Ping()
	if err != nil {
		return fmt.Errorf("error al conectar con la base de datos: %v", err)
	}

	return nil
}

// CerrarBD cierra la conexión con la base de datos
func CerrarBD() error {
	if DB != nil {
		return DB.Close()
	}
	return nil
}

// ==================== CLIENTE ====================

// CrearCliente inserta un nuevo cliente en la base de datos
func CrearCliente(cliente Cliente) (int, error) {
	var id int
	err := DB.QueryRow(
		"INSERT INTO cliente (nombre, apellido, identificacion, telefono, direccion, correo, contrasena) VALUES ($1, $2, $3, $4, $5, $6, $7) RETURNING idcliente",
		cliente.Nombre,
		cliente.Apellido,
		cliente.Identificacion,
		cliente.Telefono,
		cliente.Direccion,
		cliente.Correo,
		cliente.Contrasena,
	).Scan(&id)

	if err != nil {
		return 0, fmt.Errorf("error al crear cliente: %v", err)
	}
	return id, nil
}

// ObtenerCliente obtiene un cliente por su ID
func ObtenerCliente(id int) (Cliente, error) {
	var cliente Cliente
	err := DB.QueryRow(
		"SELECT idcliente, nombre, apellido, identificacion, telefono, direccion, correo, contrasena FROM cliente WHERE idcliente = $1",
		id,
	).Scan(
		&cliente.IDCliente,
		&cliente.Nombre,
		&cliente.Apellido,
		&cliente.Identificacion,
		&cliente.Telefono,
		&cliente.Direccion,
		&cliente.Correo,
		&cliente.Contrasena,
	)

	if err != nil {
		return Cliente{}, fmt.Errorf("error al obtener cliente: %v", err)
	}
	return cliente, nil
}

// ObtenerTodosClientes obtiene todos los clientes
func ObtenerTodosClientes() ([]Cliente, error) {
	rows, err := DB.Query(
		"SELECT idcliente, nombre, apellido, identificacion, telefono, direccion, correo, contrasena FROM cliente ORDER BY idcliente",
	)
	if err != nil {
		return nil, fmt.Errorf("error al obtener clientes: %v", err)
	}
	defer rows.Close()

	var clientes []Cliente
	for rows.Next() {
		var cliente Cliente
		err := rows.Scan(
			&cliente.IDCliente,
			&cliente.Nombre,
			&cliente.Apellido,
			&cliente.Identificacion,
			&cliente.Telefono,
			&cliente.Direccion,
			&cliente.Correo,
			&cliente.Contrasena,
		)
		if err != nil {
			return nil, err
		}
		clientes = append(clientes, cliente)
	}
	return clientes, rows.Err()
}

// ActualizarCliente actualiza los datos de un cliente
func ActualizarCliente(cliente Cliente) error {
	_, err := DB.Exec(
		"UPDATE cliente SET nombre=$1, apellido=$2, identificacion=$3, telefono=$4, direccion=$5, correo=$6, contrasena=$7 WHERE idcliente=$8",
		cliente.Nombre,
		cliente.Apellido,
		cliente.Identificacion,
		cliente.Telefono,
		cliente.Direccion,
		cliente.Correo,
		cliente.Contrasena,
		cliente.IDCliente,
	)
	if err != nil {
		return fmt.Errorf("error al actualizar cliente: %v", err)
	}
	return nil
}

// EliminarCliente elimina un cliente
func EliminarCliente(id int) error {
	_, err := DB.Exec("DELETE FROM cliente WHERE idcliente = $1", id)
	if err != nil {
		return fmt.Errorf("error al eliminar cliente: %v", err)
	}
	return nil
}

// ==================== USUARIO ====================

// CrearUsuario inserta un nuevo usuario
func CrearUsuario(usuario Usuario) (int, error) {
	var id int
	err := DB.QueryRow(
		"INSERT INTO usuario (nombre, correo, contrasena, rol) VALUES ($1, $2, $3, $4) RETURNING idusuario",
		usuario.Nombre,
		usuario.Correo,
		usuario.Contrasena,
		usuario.Rol,
	).Scan(&id)

	if err != nil {
		return 0, fmt.Errorf("error al crear usuario: %v", err)
	}
	return id, nil
}

// ObtenerUsuario obtiene un usuario por su ID
func ObtenerUsuario(id int) (Usuario, error) {
	var usuario Usuario
	err := DB.QueryRow(
		"SELECT idusuario, nombre, correo, contrasena, rol FROM usuario WHERE idusuario = $1",
		id,
	).Scan(&usuario.IDUsuario, &usuario.Nombre, &usuario.Correo, &usuario.Contrasena, &usuario.Rol)

	if err != nil {
		return Usuario{}, fmt.Errorf("error al obtener usuario: %v", err)
	}
	return usuario, nil
}

// ObtenerUsuarioPorCorreo obtiene un usuario por su correo
func ObtenerUsuarioPorCorreo(correo string) (Usuario, error) {
	var usuario Usuario
	err := DB.QueryRow(
		"SELECT idusuario, nombre, correo, contrasena, rol FROM usuario WHERE correo = $1",
		correo,
	).Scan(&usuario.IDUsuario, &usuario.Nombre, &usuario.Correo, &usuario.Contrasena, &usuario.Rol)

	if err != nil {
		return Usuario{}, fmt.Errorf("error al obtener usuario: %v", err)
	}
	return usuario, nil
}

// EliminarUsuario elimina un usuario
func EliminarUsuario(id int) error {
	_, err := DB.Exec("DELETE FROM usuario WHERE idusuario = $1", id)
	if err != nil {
		return fmt.Errorf("error al eliminar usuario: %v", err)
	}
	return nil
}

// ObtenerTodosUsuarios obtiene todos los usuarios
func ObtenerTodosUsuarios() ([]Usuario, error) {
	rows, err := DB.Query(
		"SELECT idusuario, nombre, correo, contrasena, rol FROM usuario ORDER BY idusuario",
	)
	if err != nil {
		return nil, fmt.Errorf("error al obtener usuarios: %v", err)
	}
	defer rows.Close()

	var usuarios []Usuario
	for rows.Next() {
		var usuario Usuario
		err := rows.Scan(&usuario.IDUsuario, &usuario.Nombre, &usuario.Correo, &usuario.Contrasena, &usuario.Rol)
		if err != nil {
			return nil, err
		}
		usuarios = append(usuarios, usuario)
	}
	return usuarios, rows.Err()
}

// ActualizarUsuario actualiza un usuario
func ActualizarUsuario(usuario Usuario) error {
	_, err := DB.Exec(
		"UPDATE usuario SET nombre=$1, correo=$2, contrasena=$3, rol=$4 WHERE idusuario=$5",
		usuario.Nombre,
		usuario.Correo,
		usuario.Contrasena,
		usuario.Rol,
		usuario.IDUsuario,
	)
	if err != nil {
		return fmt.Errorf("error al actualizar usuario: %v", err)
	}
	return nil
}

// ==================== PRODUCTO ====================

// CrearProducto inserta un nuevo producto
func CrearProducto(producto Producto) (int, error) {
	var id int
	err := DB.QueryRow(
		"INSERT INTO producto (nombre, descripcion, precio, impuesto) VALUES ($1, $2, $3, $4) RETURNING idproducto",
		producto.Nombre,
		producto.Descripcion,
		producto.Precio,
		producto.Impuesto,
	).Scan(&id)

	if err != nil {
		return 0, fmt.Errorf("error al crear producto: %v", err)
	}
	return id, nil
}

// ObtenerProducto obtiene un producto por su ID
func ObtenerProducto(id int) (Producto, error) {
	var producto Producto
	err := DB.QueryRow(
		"SELECT idproducto, nombre, descripcion, precio, impuesto FROM producto WHERE idproducto = $1",
		id,
	).Scan(&producto.IDProducto, &producto.Nombre, &producto.Descripcion, &producto.Precio, &producto.Impuesto)

	if err != nil {
		return Producto{}, fmt.Errorf("error al obtener producto: %v", err)
	}
	return producto, nil
}

// ObtenerTodosProductos obtiene todos los productos
func ObtenerTodosProductos() ([]Producto, error) {
	rows, err := DB.Query(
		"SELECT idproducto, nombre, descripcion, precio, impuesto FROM producto ORDER BY idproducto",
	)
	if err != nil {
		return nil, fmt.Errorf("error al obtener productos: %v", err)
	}
	defer rows.Close()

	var productos []Producto
	for rows.Next() {
		var producto Producto
		err := rows.Scan(&producto.IDProducto, &producto.Nombre, &producto.Descripcion, &producto.Precio, &producto.Impuesto)
		if err != nil {
			return nil, err
		}
		productos = append(productos, producto)
	}
	return productos, rows.Err()
}

// ActualizarProducto actualiza un producto
func ActualizarProducto(producto Producto) error {
	_, err := DB.Exec(
		"UPDATE producto SET nombre=$1, descripcion=$2, precio=$3, impuesto=$4 WHERE idproducto=$5",
		producto.Nombre,
		producto.Descripcion,
		producto.Precio,
		producto.Impuesto,
		producto.IDProducto,
	)
	if err != nil {
		return fmt.Errorf("error al actualizar producto: %v", err)
	}
	return nil
}

// EliminarProducto elimina un producto
func EliminarProducto(id int) error {
	_, err := DB.Exec("DELETE FROM producto WHERE idproducto = $1", id)
	if err != nil {
		return fmt.Errorf("error al eliminar producto: %v", err)
	}
	return nil
}

// ==================== FACTURA ====================

// CrearFactura inserta una nueva factura
func CrearFactura(factura Factura) (int, error) {
	var id int
	err := DB.QueryRow(
		"INSERT INTO factura (numero_factura, fecha, idcliente, total, impuesto_total, estado, archivo_xml, archivo_pdf) VALUES ($1, $2, $3, $4, $5, $6, $7, $8) RETURNING idfactura",
		factura.NumeroFactura,
		factura.Fecha,
		factura.IDCliente,
		factura.Total,
		factura.ImpuestoTotal,
		factura.Estado,
		factura.ArchivoXML,
		factura.ArchivoPDF,
	).Scan(&id)

	if err != nil {
		return 0, fmt.Errorf("error al crear factura: %v", err)
	}
	return id, nil
}

// ObtenerFactura obtiene una factura por su ID
func ObtenerFactura(id int) (Factura, error) {
	var factura Factura
	err := DB.QueryRow(
		"SELECT idfactura, numero_factura, fecha, idcliente, total, impuesto_total, estado, archivo_xml, archivo_pdf FROM factura WHERE idfactura = $1",
		id,
	).Scan(&factura.IDFactura, &factura.NumeroFactura, &factura.Fecha, &factura.IDCliente, &factura.Total, &factura.ImpuestoTotal, &factura.Estado, &factura.ArchivoXML, &factura.ArchivoPDF)

	if err != nil {
		return Factura{}, fmt.Errorf("error al obtener factura: %v", err)
	}
	return factura, nil
}

// ObtenerTodasFacturas obtiene todas las facturas
func ObtenerTodasFacturas() ([]Factura, error) {
	rows, err := DB.Query(
		"SELECT idfactura, numero_factura, fecha, idcliente, total, impuesto_total, estado, archivo_xml, archivo_pdf FROM factura ORDER BY idfactura",
	)
	if err != nil {
		return nil, fmt.Errorf("error al obtener facturas: %v", err)
	}
	defer rows.Close()

	var facturas []Factura
	for rows.Next() {
		var factura Factura
		err := rows.Scan(&factura.IDFactura, &factura.NumeroFactura, &factura.Fecha, &factura.IDCliente, &factura.Total, &factura.ImpuestoTotal, &factura.Estado, &factura.ArchivoXML, &factura.ArchivoPDF)
		if err != nil {
			return nil, err
		}
		facturas = append(facturas, factura)
	}
	return facturas, rows.Err()
}

// ActualizarFactura actualiza una factura
func ActualizarFactura(factura Factura) error {
	_, err := DB.Exec(
		"UPDATE factura SET numero_factura=$1, fecha=$2, idcliente=$3, total=$4, impuesto_total=$5, estado=$6, archivo_xml=$7, archivo_pdf=$8 WHERE idfactura=$9",
		factura.NumeroFactura,
		factura.Fecha,
		factura.IDCliente,
		factura.Total,
		factura.ImpuestoTotal,
		factura.Estado,
		factura.ArchivoXML,
		factura.ArchivoPDF,
		factura.IDFactura,
	)
	if err != nil {
		return fmt.Errorf("error al actualizar factura: %v", err)
	}
	return nil
}

// EliminarFactura elimina una factura
func EliminarFactura(id int) error {
	_, err := DB.Exec("DELETE FROM factura WHERE idfactura = $1", id)
	if err != nil {
		return fmt.Errorf("error al eliminar factura: %v", err)
	}
	return nil
}

// ==================== DETALLE FACTURA ====================

// CrearDetalleFactura inserta un detalle de factura
func CrearDetalleFactura(detalle DetalleFactura) (int, error) {
	var id int
	err := DB.QueryRow(
		"INSERT INTO detalle_factura (idfactura, idproducto, cantidad, precio_unitario, subtotal) VALUES ($1, $2, $3, $4, $5) RETURNING iddetalle",
		detalle.IDFactura,
		detalle.IDProducto,
		detalle.Cantidad,
		detalle.PrecioUnitario,
		detalle.Subtotal,
	).Scan(&id)

	if err != nil {
		return 0, fmt.Errorf("error al crear detalle factura: %v", err)
	}
	return id, nil
}

// ObtenerDetallesFactura obtiene todos los detalles de una factura
func ObtenerDetallesFactura(idFactura int) ([]DetalleFactura, error) {
	rows, err := DB.Query(
		"SELECT iddetalle, idfactura, idproducto, cantidad, precio_unitario, subtotal FROM detalle_factura WHERE idfactura = $1",
		idFactura,
	)
	if err != nil {
		return nil, fmt.Errorf("error al obtener detalles: %v", err)
	}
	defer rows.Close()

	var detalles []DetalleFactura
	for rows.Next() {
		var detalle DetalleFactura
		err := rows.Scan(&detalle.IDDetalle, &detalle.IDFactura, &detalle.IDProducto, &detalle.Cantidad, &detalle.PrecioUnitario, &detalle.Subtotal)
		if err != nil {
			return nil, err
		}
		detalles = append(detalles, detalle)
	}
	return detalles, rows.Err()
}

// EliminarDetalleFactura elimina un detalle de factura
func EliminarDetalleFactura(id int) error {
	_, err := DB.Exec("DELETE FROM detalle_factura WHERE iddetalle = $1", id)
	if err != nil {
		return fmt.Errorf("error al eliminar detalle: %v", err)
	}
	return nil
}
