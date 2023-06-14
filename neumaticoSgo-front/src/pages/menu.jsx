import {Link } from 'react-router-dom'
import '../css/menu.css'
import logo from '../img/logo.png'


function Sidebar() {
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
                            <Link to="/productos">
                                <i className="fa-solid fa-cart-flatbed nav-link-icon"></i>
                                <span className="link-name">Productos</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/altaproducto">
                                <i className="fa-solid fa-square-plus nav-link-icon"></i>
                                <span className="link-name">Alta de producto</span>
                            </Link>
                        </li>
                        <li className="nav-link-item">
                            <Link to="/proveedores">
                                <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
                                <span className="link-name">Proveedores</span>
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

function NavBar() {
    return (
        <div>
            <div className="top">
                <i className="fa-solid fa-bars sidebar-toggle"></i>
                <div className="search-box">
                    <i className="fa-solid fa-magnifying-glass"></i>
                    <input type="text" placeholder="Buscar productos"/>
                </div>
            </div>
    </div>
    )
}

export function Menu() {
    return (
        <div>
            <Sidebar/>
            <NavBar/>
        </div>
    )
}