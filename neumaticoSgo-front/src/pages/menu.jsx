import '../css/menu.css'
import { TablaProductos } from '../components/tablaproductos'
import { TablaProveedores } from '../components/TablaProveedores'
import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { NavBar } from '../components/NavBar'
import { DynamicForm } from '../components/DynamicForm'
import { Sidebar } from '../components/Sidebar'
import { ProveedoresForm } from '../components/altaProveedores'
import { TablaEntradasMovimientos } from '../components/TablaEntradaMovimientos'
import { TablaSalidasMovimientos } from '../components/TablaSalidaMovimiento'
import { RegistroEntradasForm } from '../components/EntradasForm'
import { RegistroSalidasForm } from '../components/SalidasForm'
import {Inicio} from '../components/Inicio'


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
        {selectedTab === 'inicio' ? (
        <Inicio />
      ) : selectedTab === 'productos' ? (
        <TablaProductos />
      ) : selectedTab === 'proveedores' ? (
        <TablaProveedores/>
      ) : selectedTab === 'altaProducto' ? (
        <DynamicForm/>
      ): selectedTab === 'altaProveedores' ? (
        <ProveedoresForm/>
      ): selectedTab === 'entradas' ? (
        <TablaEntradasMovimientos/>
      ):
        selectedTab === 'registroentradas' ? (
        <RegistroEntradasForm/>
      ):
        selectedTab === 'salidas' ? (
        <TablaSalidasMovimientos/>
      ):
      selectedTab === 'registrosalidas' ? (
        <RegistroSalidasForm/>
      ): null

    }
        </div>
    )
}