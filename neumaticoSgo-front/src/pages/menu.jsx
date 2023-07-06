import '../css/menu.css'
import { TablaProductos } from '../components/TablaProductos'
import { TablaProveedores } from '../components/TablaProveedores'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { NavBar } from '../components/NavBar'
import { DynamicForm } from '../components/DynamicForm'
import { Sidebar } from '../components/Sidebar'
import { ProveedoresForm } from '../components/AltaProveedores'
import { TablaEntradasMovimientos } from '../components/TablaEntradaMovimientos'


export function Menu() {
    
    const [selectedTab, setSelectedTab] = useState('productos');
    const navigate = useNavigate()


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
      ): selectedTab === 'altaProveedores' ? (
        <ProveedoresForm/>
      ): selectedTab === 'entradas' ? (
        <TablaEntradasMovimientos/>
      ):null
    }
        </div>
    )
}