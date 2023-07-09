import React from 'react';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';

export const Inicio = () => {
  return (
    <div>
      <NavBar/>
      <Sidebar/>
      <div className="home">
        <h1>Sistema de Stock</h1>
        <p>Bienvenido al sistema de gestión de stock.</p>
        <img src="ruta-a-tu-imagen.jpg" alt="Home" />
      </div>
    </div>
  );
};
