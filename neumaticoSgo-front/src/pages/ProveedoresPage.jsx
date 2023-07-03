import { Sidebar } from "../components/Sidebar"
import { NavBar } from "../components/NavBar"
import { TablaProveedores } from "../components/TablaProveedores"
export function ProovedoresPage(){
    return (
        <div>
            <Sidebar/>
            <NavBar/>
            <TablaProveedores/>
            <p>Proovedores</p>
        </div>
    )
}