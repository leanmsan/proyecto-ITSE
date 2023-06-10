export function ProductoCard({producto}) {

    const caracteristicaString = JSON.stringify(producto.caracteristicas);
    const caracteristicasLimpias = caracteristicaString.replace(/[^a-zA-Z0-9]/g, ' ');

    function convertirCapitalCase(texto) {
        return texto.toLowerCase().replace(/(?:^|\s)\w/g, function(letra) {
          return letra.toUpperCase();
        });   
    }
    
    const caracteristicasFinal = convertirCapitalCase(caracteristicasLimpias);
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
        <p>Caracteristicas: {caracteristicasFinal}</p>
        <hr />
    </div>
    )
}