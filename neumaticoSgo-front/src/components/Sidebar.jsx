import {Link } from 'react-router-dom'
import logo from '../img/logo.png'
import '../css/menu.css'

export function Sidebar({handleTabClick, selectedTab}) {
    return (
            <nav>
                <div className="logo-name">
                    <div className="logo-image">
                        <img src={logo} alt="Logo Neumatico Santiago"/>
                    </div>
                </div>

                <div className="menu-items">
                    <ul className="nav-links">
                        <li className="nav-link-item">
                            <Link to="/inicio" onClick={() => handleTabClick('inicio')}>
                                <i className="fa-solid fa-house-chimney nav-link-icon"></i>
                                <span className="link-name">Inicio</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/productos" onClick={() => handleTabClick('productos')}>
                                <i className="fa-solid fa-cart-flatbed nav-link-icon"></i>
                                <span className="link-name">Productos</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/altaproducto" >
                                <i className="fa-solid fa-square-plus nav-link-icon"></i>
                                <span className="link-name">Alta de producto</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/proveedores" onClick={() => handleTabClick('proveedores')}>
                                <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
                                <span className="link-name">Proveedores</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/movimientos" onClick={() => handleTabClick('movimientos')}>
                                <i className="fa-solid fa-cash-register nav-link-icon"></i>
                                <span className="link-name">Movimientos</span>
                            </Link>
                        </li>
                    </ul>

                    <ul className="logout-mod">
                        <li className="nav-link-item">
                            <Link to="/login">
                                <i className="fa-solid fa-right-from-bracket nav-link-icon"></i>
                                <span className="link-name">Salir</span>
                            </Link>
                        </li>
                    </ul>
                </div>
            </nav>
    )
}