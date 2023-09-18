import { Sidebar } from './Sidebar';
import { NavBar } from './NavBar';
import DelBarco from '../img/delbarco.png'

export const Inicio = () => {
  return (
    <div>
      <NavBar/>
      <Sidebar/>
      <div className="home">
        <h1 className='title'>Sistema de Gestión de Producción</h1>
        <p className='subtitle'>Cervecería Del Barco</p>
        <img src={DelBarco} alt="Home"/>
      </div>
    </div>
  );
};
