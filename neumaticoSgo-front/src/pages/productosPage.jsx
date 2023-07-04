import { Sidebar } from "../components/Sidebar"
import { NavBar } from "../components/NavBar"
import { TablaProductos } from "../components/tablaproductos"


export function ProductosPage(){
    return (
        <div>
            <NavBar/>
            <Sidebar/>
            <TablaProductos/>

        </div>
    )
}