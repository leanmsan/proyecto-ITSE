import '../css/menu.css'
import React, { useEffect, useState } from 'react';

export function NavBar() {

    const [busqueda, setBusqueda] = useState([]);
    const [productos, setProductos] = useState([]);

    const handleChange = (event) => {
        const searchTerm = event.target.value;
        console.log(event.target.value);
        setBusqueda(searchTerm);
        filtrar(event.target.value);
  }

const filtrar = (terminoBusqueda) => {
    let resultadosBusqueda = productos.filter((elemento) => {
        if(elemento.name.toString().toLowerCase().includes(terminoBusqueda.toLowerCase())){
            return elemento;
        }
    })
    setProductos(resultadosBusqueda);
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
                        onChange={handleChange}
                    />
                </div>
            </div>
    </div>
    )
}