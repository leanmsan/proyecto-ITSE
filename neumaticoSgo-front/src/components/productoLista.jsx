import { useEffect, useState } from "react"
import {getAllProductos} from '../api/productos'
import {ProductoCard} from './ProductoCard'

export function ProductoLista () {
    const [productos, setProductos] = useState([])
    useEffect(() => {
        async function loadProductos (){
            const res = await getAllProductos()
            setProductos(res.data.productos)
            console.log(res.data.productos)
        }
        loadProductos()
    },[])
        console.log(productos,"esto es productos")
    return(
        <div>
            
            {productos.map(producto => (
                <ProductoCard key={producto.idproducto} producto={producto} />

        ))} </div>
    )
}