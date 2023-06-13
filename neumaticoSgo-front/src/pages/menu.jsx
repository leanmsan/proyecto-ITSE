
import '../css/menu.css'
import logo from '../img/logo.png'
import { TablaProductos } from '../components/tablaProducto'


export function Menu() {
    return (
        <div>
            <nav>
                <div className="logo-name">
                    <div className="logo-image">
                        <img src={logo} alt="Logo Neumatico Santiago"/>
                    </div>
                </div>

                <div className="menu-items">
                    <ul className="nav-links">
                        <li className="nav-link-item">
                            <a href='/productos'>
                                <i className="fa-solid fa-cart-flatbed nav-link-icon"></i>
                                <span className="link-name">Productos</span>
                            </a>
                        </li>
                        <li className="nav-link-item">
                            <a href="#">
                                <i className="fa-solid fa-square-plus nav-link-icon"></i>
                                <span className="link-name">Alta de producto</span>
                            </a>
                        </li>
                        <li className="nav-link-item">
                            <a href="#">
                                <i className="fa-solid fa-person-circle-plus nav-link-icon"></i>
                                <span className="link-name">Proveedores</span>
                            </a>
                        </li>
                    </ul>

                    <ul className="logout-mod">
                        <li className="nav-link-item">
                            <a href="#">
                                <i className="fa-solid fa-right-from-bracket nav-link-icon"></i>
                                <span className="link-name">Salir</span>
                            </a>
                        </li>
                    </ul>
                </div>
            </nav>

            <section className="dashboard">
                <div className="top">
                    <i className="fa-solid fa-bars sidebar-toggle"></i>
                    <div className="search-box">
                        <i className="fa-solid fa-magnifying-glass"></i>
                        <input type="text" placeholder="Buscar productos"/>
                    </div>
                </div>
                <div>
                    <TablaProductos></TablaProductos>
                </div>
            </section>
        </div>
    )
}