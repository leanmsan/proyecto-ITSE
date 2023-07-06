import '../css/menu.css'
import React, { useState } from 'react';

export function NavBar({ productos, setProductosFiltrados }) {

    const [busqueda, setBusqueda] = useState([]);

    const handleSearch = (event) => {
        const searchTerm = event.target.value;
        console.log(event.target.value)
        setBusqueda(searchTerm);
  }

const filtrar = (terminoBusqueda) => {
    var resultadosBusqueda = productos.filter((elemento) => {
        if(elemento.name.toString().toLowerCase().includes(terminoBusqueda.toLowerCase())){
            return elemento;
        }
    })
    setData(resultadosBusqueda);
}

    return (
        
        <div>
            <div className="top">
                <i className="fa-solid fa-bars sidebar-toggle"></i>
                <div className="search-box">
                    <i className="fa-solid fa-magnifying-glass"></i>
                    <input 
                        type="text" 
                        placeholder="Buscar productos"
                        value={busqueda}
                        onChange={handleSearch}
                    />
                </div>
            </div>
    </div>
    )
}