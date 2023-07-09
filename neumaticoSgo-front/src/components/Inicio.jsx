import React from 'react';
import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import Goodyear from '../img/Goodyear.png'

export const Inicio = () => {
  return (
    <div>
      <NavBar/>
      <Sidebar/>
      <div className="home">
        <h1 className='title'>Sistema de Stock de Neumáticos Santiago</h1>
        <p className='subtitle'>Bienvenido al sistema de gestión de stock y movimientos.</p>
        <img src={Goodyear} alt="Home"/>
      </div>
    </div>
  );
};
