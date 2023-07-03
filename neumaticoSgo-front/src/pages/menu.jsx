import '../css/menu.css'
import { TablaProductos } from '../components/tablaproductos'
import { TablaProveedores } from '../components/TablaProveedores'
import { useState } from 'react'
import { NavBar } from '../components/NavBar'
import { DynamicForm } from '../components/DynamicForm'
import { Sidebar } from '../components/Sidebar'
export function Menu() {
    
    const [selectedTab, setSelectedTab] = useState('productos');
    
    const handleTabClick = (tab) => {
        setSelectedTab(tab);
      };

    


    
    return (

        <div>
            <Sidebar handleTabClick = {handleTabClick} selectedTab = {selectedTab}/>
            <NavBar/>
            {selectedTab === 'productos' ? (
        <TablaProductos />
      ) : selectedTab === 'proveedores' ? (
        <TablaProveedores/>
      ) : selectedTab === 'altaProducto' ? (
        <DynamicForm/>
      ): null
    }
        </div>
    )
}