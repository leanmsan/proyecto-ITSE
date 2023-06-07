export function ProductoCard({producto}) {
    return (
        <div>
        <h1>Producto: {producto.nombre}</h1>
        <p>Marca del Producto: {producto.marca}</p>
        <p>Precio Compra: {producto.preciocompra}</p>
        <p>Precio Venta: {producto.precioventa}</p>
        <p>Stock Producto: {producto.stock}</p>
        <p>Rubro Producto: {producto.rubro}</p>
        <hr />
    </div>
    )
}