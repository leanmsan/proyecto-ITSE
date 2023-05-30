export function ProductoCard({producto}) {
    return (
        <div>
        <h1>Producto: {producto.nombreproducto}</h1>
        <p>Marca del Producto: {producto.marcaproducto}</p>
        <p>Precio Compra: {producto.preciocompra}</p>
        <p>Precio Venta: {producto.precioventa}</p>
        <p>Stock Producto: {producto.stockproducto}</p>
        <hr />
    </div>
    )
}