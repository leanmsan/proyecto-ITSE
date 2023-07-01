import {Link} from 'react-router-dom'

export function Navegacion (){
    return (
        <div>
            <Link to='/productos'>
                <h1>Productos</h1>
            </Link>
            <Link to='/productoForm'>Alta Productos</Link>
            <Link to='/inicio'>Inicio</Link>
        </div>
    )
}