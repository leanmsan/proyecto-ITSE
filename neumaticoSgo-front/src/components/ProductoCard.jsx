export function ProductoCard({producto}) {
    return (
        <div>
        <h1>Producto: {producto.nombre}</h1>
        <p>Id Producto: {producto.idproducto}</p>
        <p>Marca del Producto: {producto.marca}</p>
        <p>Descripcion: {producto.descripcion}</p>
        <p>Precio Compra: {producto.preciocompra}</p>
        <p>Precio Venta: {producto.precioventa}</p>
        <p>Stock Producto: {producto.stockdisponible}</p>
        <p>Rubro: {producto.rubro_id}</p>
        <p>Caracteristicas: {JSON.stringify(producto.caracteristicas)}</p>
        <hr />
    </div>
    )
}